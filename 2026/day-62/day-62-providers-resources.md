# Day 62 -- Providers, Resources and Dependencies

## Task
Yesterday you created standalone resources. But real infrastructure is connected -- a server lives inside a subnet, a subnet lives inside a VPC, a security group controls what traffic gets in. Today you build a complete networking stack on AWS and learn how Terraform figures out what to create first.

Understanding dependencies is what separates a Terraform beginner from someone who can build production infrastructure.

---

### TERRAFORM FILE: 
[main.tf](https://github.com/Akash-Ahir/90DaysOfDevOps/blob/master/2026/day-62/Terraform-files/main.tf)<br/>

 [providers.tf](https://github.com/Akash-Ahir/90DaysOfDevOps/blob/master/2026/day-62/Terraform-files/providers.tf)<br/>


## Challenge Tasks

## Task 1: Explore the AWS Provider
1. Create a new project directory: `terraform-aws-infra`
2. Write a `providers.tf` file:
   - Define the `terraform` block with `required_providers` pinning the AWS provider to version `~> 5.0`
   - Define the `provider "aws"` block with your region
3. Run `terraform init` and check the output -- what version was installed?
    - v5.100.0

<img width="927" height="575" alt="task-1" src="https://github.com/user-attachments/assets/a5723c4c-0976-4ef7-abdf-553773f7fc7d" />


4. Read the provider lock file `.terraform.lock.hcl` -- what does it do?
   - This ensures that every team member working on the project uses the same provider version, preventing unexpected behavior caused by version differences. Terraform creates and updates this file automatically whenever providers are installed or upgraded.

<img width="917" height="590" alt="task-1 2" src="https://github.com/user-attachments/assets/d8b43a6a-d06a-487e-8c68-9db5d78d3813" />


**Document:** What does `~> 5.0` mean? How is it different from `>= 5.0` and `= 5.0.0`?
  - `~> 5.0`  This indicates that version from 5.0 till lesser than 6.0 like 5.1,5.18,5.99 can only be installed 
  - `>= 5.0` This indicate that 5.0 or higher version than 5.0 like 5.5,6.0,7.5 can be installed 
  - `= 5.0.0` This indicate only 5.0.0 version need to be installed nothing else

---

## Task 2: Build a VPC from Scratch
Create a `main.tf` and define these resources one by one:

1. `aws_vpc` -- CIDR block `10.0.0.0/16`, tag it `"TerraWeek-VPC"`
2. `aws_subnet` -- CIDR block `10.0.1.0/24`, reference the VPC ID from step 1, enable public IP on launch, tag it `"TerraWeek-Public-Subnet"`
3. `aws_internet_gateway` -- attach it to the VPC
4. `aws_route_table` -- create it in the VPC, add a route for `0.0.0.0/0` pointing to the internet gateway
5. `aws_route_table_association` -- associate the route table with the subnet

Run `terraform plan` -- you should see 5 resources to create.


<img width="1676" height="577" alt="task-2 1" src="https://github.com/user-attachments/assets/bea3d618-917f-453a-96f9-e40b610eabd0" />
<img width="960" height="405" alt="task-2 2" src="https://github.com/user-attachments/assets/a1d90d39-95ad-4b02-af61-86dea7712464" />



**Verify:** Apply and check the AWS VPC console. Can you see all five resources connected? -yes
<img width="1275" height="662" alt="task-2 3" src="https://github.com/user-attachments/assets/dea9c4ec-8aab-4262-8297-51e6eaf85fdb" />
<img width="1627" height="595" alt="task-2 4" src="https://github.com/user-attachments/assets/c6200333-3e97-4273-a28a-0a6160828c8b" />



---

## Task 3: Understand Implicit Dependencies
Look at your `main.tf` carefully:

1. The subnet references `aws_vpc.main.id` -- this is an implicit dependency
2. The internet gateway references the VPC ID -- another implicit dependency
3. The route table association references both the route table and the subnet

Answer these questions:
- How does Terraform know to create the VPC before the subnet?
  - Terraform analyzes references between resources before creating anything. Since the subnet uses aws_vpc.main.id, Terraform automatically understands that the VPC must exist first. It builds this relationship into its dependency graph and creates the resources in the correct order
    
- What would happen if you tried to create the subnet before the VPC existed?
  - AWS will reject the request because a subnet cannot exist without an associated VPC. Terraform prevents this situation by creating the VPC first based on the dependency graph
   
- Find all implicit dependencies in your config and list them
  - aws_subnet.my_subnet depends on aws_vpc.my_vpc
  - aws_internet_gateway.my_internet_gateway depends on aws_vpc.my_vpc
  - aws_route_table.my_route_table depends on aws_vpc.my_vpc
  - aws_route_table.my_route_table depends on aws_internet_gateway.my_internet_gateway
  - aws_route_table_association.route_table_association depends on aws_route_table.my_route_table

---

## Task 4: Add a Security Group and EC2 Instance
Add to your config:

1. `aws_security_group` in the VPC:
   - Ingress rule: allow SSH (port 22) from `0.0.0.0/0`
   - Ingress rule: allow HTTP (port 80) from `0.0.0.0/0`
   - Egress rule: allow all outbound traffic
   - Tag: `"TerraWeek-SG"`

2. `aws_instance` in the subnet:
   - Use Amazon Linux 2 AMI for your region
   - Instance type: `t2.micro`
   - Associate the security group
   - Set `associate_public_ip_address = true`
   - Tag: `"TerraWeek-Server"`
  
<img width="1440" height="380" alt="task-4 1" src="https://github.com/user-attachments/assets/3d6ac7dc-4825-4399-889f-8cf375aedbc3" />

<img width="1392" height="592" alt="task-4 2" src="https://github.com/user-attachments/assets/033edacd-d1f8-4455-b459-8725ad994f7c" />



Apply and verify -- your EC2 instance should have a public IP and be reachable.
<img width="1462" height="185" alt="task-4 3" src="https://github.com/user-attachments/assets/ea6f30cd-e200-4d15-8564-c53b586bb9fb" />


<img width="1047" height="455" alt="task-4 4" src="https://github.com/user-attachments/assets/f7c189d2-26b4-4ec5-9c57-d299e232a8c0" />



---

## Task 5: Explicit Dependencies with depends_on
Sometimes Terraform cannot detect a dependency automatically.

1. Add a second `aws_s3_bucket` resource for application logs
2. Add `depends_on = [aws_instance.main]` to the S3 bucket -- even though there is no direct reference, you want the bucket created only after the instance
3. Run `terraform plan` and observe the order

<img width="1027" height="330" alt="task-5 1" src="https://github.com/user-attachments/assets/2678de46-9b1c-4b44-9f01-13f8441830aa" />


Now visualize the entire dependency tree:
```bash
terraform graph | dot -Tpng > graph.png
```
If you don't have `dot` (Graphviz) installed, use:
```bash
terraform graph
```



and paste the output into an online Graphviz viewer.

<img width="927" height="257" alt="task-5 2" src="https://github.com/user-attachments/assets/63e8d835-f95c-4e74-b8ae-2492b8a6663d" />


---

## Task 6: Lifecycle Rules and Destroy
1. Add a `lifecycle` block to your EC2 instance:
```hcl
lifecycle {
  create_before_destroy = true
}
```
2. Change the AMI ID to a different one and run `terraform plan` -- observe that Terraform plans to create the new instance before destroying the old one

3. Destroy everything:
```bash
terraform destroy
```
4. Watch the destroy order -- Terraform destroys in reverse dependency order. Verify in the AWS console that everything is cleaned up.

   <img width="1697" height="327" alt="task-6 1" src="https://github.com/user-attachments/assets/ebced4e4-541f-4973-95bb-098bcd4b509b" />
   <img width="1097" height="507" alt="task-6 2" src="https://github.com/user-attachments/assets/2d660f37-5846-44cb-95cf-df31ba887f71" />
   <img width="1522" height="242" alt="task-6 3" src="https://github.com/user-attachments/assets/dde96d51-8c9a-425e-8ee0-29b2508433f4" />
   <img width="1227" height="822" alt="task-6 4" src="https://github.com/user-attachments/assets/2d6998a8-0a93-4505-b8c8-f7ef004b693e" />
   <img width="1685" height="266" alt="task-6 5" src="https://github.com/user-attachments/assets/60bdca86-f386-462d-9fd1-4467dcdfaba5" />



**Document:** What are the three lifecycle arguments (`create_before_destroy`, `prevent_destroy`, `ignore_changes`) and when would you use each?
                          
  `create_before_destroy`- Create a replacement resource before deleting the old one
  
  `prevent_destroy`- Prevent accidental deletion of critical resources

  `ignore_changes`- Ignore updates to specific attributes that may be modified outside Terraform

  
---
