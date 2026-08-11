# Day 65 -- Terraform Modules: Build Reusable Infrastructure

## Task
You have been writing everything in one big `main.tf` file. That works for learning, but in real teams you manage dozens of environments with hundreds of resources. Copy-pasting configs across projects is a recipe for disaster.

Today you learn Terraform modules -- the way to package, reuse, and share infrastructure code. Think of modules as functions in programming. Write once, call many times.

---

## Challenge Tasks

## Task 1: Understand Module Structure
A Terraform module is just a directory with `.tf` files. Create this structure:

```
terraform-modules/
  main.tf                    # Root module -- calls child modules
  variables.tf               # Root variables
  outputs.tf                 # Root outputs
  providers.tf               # Provider config
  modules/
    ec2-instance/
      main.tf                # EC2 resource definition
      variables.tf           # Module inputs
      outputs.tf             # Module outputs
    security-group/
      main.tf                # Security group resource definition
      variables.tf           # Module inputs
      outputs.tf             # Module outputs
```

Create all the directories and empty files. This is the standard layout every Terraform project follows.
<img width="402" height="521" alt="task-1" src="https://github.com/user-attachments/assets/3b394f7e-6041-4577-a830-ab4244b17b0a" />


**Document:** What is the difference between a "root module" and a "child module"?
  `root module` - The root module is the main Terraform configuration it decides which modules to use and what values to pass to them

  `child module` - A child module contains reusable infrastructure logic that can be called and reused by the root module
  
  ---

## Task 2: Build a Custom EC2 Module
Create `modules/ec2-instance/`:

1. **`variables.tf`** -- define inputs:
   - `ami_id` (string)
   - `instance_type` (string, default: `"t2.micro"`)
   - `subnet_id` (string)
   - `security_group_ids` (list of strings)
   - `instance_name` (string)
   - `tags` (map of strings, default: `{}`)

2. **`main.tf`** -- define the resource:
   - `aws_instance` using all the variables
   - Merge the Name tag with additional tags

3. **`outputs.tf`** -- expose:
   - `instance_id`
   - `public_ip`
   - `private_ip`

Do NOT apply yet -- just write the module.

---

### Task 3: Build a Custom Security Group Module
Create `modules/security-group/`:

1. **`variables.tf`** -- define inputs:
   - `vpc_id` (string)
   - `sg_name` (string)
   - `ingress_ports` (list of numbers, default: `[22, 80]`)
   - `tags` (map of strings, default: `{}`)

2. **`main.tf`** -- define the resource:
   - `aws_security_group` in the given VPC
   - Use `dynamic "ingress"` block to create rules from the `ingress_ports` list
   - Allow all egress

3. **`outputs.tf`** -- expose:
   - `sg_id`

This is your first time using a `dynamic` block -- it loops over a list to generate repeated nested blocks.

---

## Task 4: Call Your Modules from Root
In the root `main.tf`, wire everything together:

1. Create a VPC and subnet directly (or reuse your Day 62 config)
2. Call the security group module:
```hcl
module "web_sg" {
  source        = "./modules/security-group"
  vpc_id        = aws_vpc.main.id
  sg_name       = "terraweek-web-sg"
  ingress_ports = [22, 80, 443]
  tags          = local.common_tags
}

```

3. Call the EC2 module -- deploy **two instances** with different names using the same module:
```hcl
module "web_server" {
  source             = "./modules/ec2-instance"
  ami_id             = data.aws_ami.amazon_linux.id
  instance_type      = "t2.micro"
  subnet_id          = aws_subnet.public.id
  security_group_ids = [module.web_sg.sg_id]
  instance_name      = "terraweek-web"
  tags               = local.common_tags
}

module "api_server" {
  source             = "./modules/ec2-instance"
  ami_id             = data.aws_ami.amazon_linux.id
  instance_type      = "t2.micro"
  subnet_id          = aws_subnet.public.id
  security_group_ids = [module.web_sg.sg_id]
  instance_name      = "terraweek-api"
  tags               = local.common_tags
}
```

4. Add root outputs that reference module outputs:
```hcl
output "web_server_ip" {
  value = module.web_server.public_ip
}

output "api_server_ip" {
  value = module.api_server.public_ip
}
```

5. Apply:
```bash
terraform init    # Downloads/links the local modules
terraform plan    # Should show all resources from both module calls
terraform apply
```


<img width="597" height="166" alt="task-4 2" src="https://github.com/user-attachments/assets/8b622f46-607c-4091-9090-7287bf9d83d8" />



<img width="1350" height="651" alt="task-4 3" src="https://github.com/user-attachments/assets/daa42596-e7f3-4b07-8641-84c09123f8e2" />

<img width="1620" height="696" alt="task-4 5" src="https://github.com/user-attachments/assets/9908d91e-5433-4a8a-9371-a2a4ae232f14" />




**Verify:** Two EC2 instances running, same security group, different names. Check the AWS console.

<img width="1533" height="275" alt="task-4 4" src="https://github.com/user-attachments/assets/d91b4b97-a2db-4960-94ce-5ae5f563d2ba" />


<img width="1490" height="251" alt="task-4 6" src="https://github.com/user-attachments/assets/9c14211e-8dc6-41ff-8ca5-d68dcfbdcb2f" />





---

## Task 5: Use a Public Registry Module
Instead of building your own VPC from scratch, use the official module from the Terraform Registry.

1. Replace your hand-written VPC resources with:
```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "terraweek-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway = false
  enable_dns_hostnames = true

  tags = local.common_tags
}
```

2. Update your EC2 and SG module calls to reference `module.vpc.vpc_id` and `module.vpc.public_subnets[0]`

3. Run:
```bash
terraform init     # Downloads the registry module
terraform plan
terraform apply
```
<img width="605" height="143" alt="task-5 1" src="https://github.com/user-attachments/assets/cebf9c12-87da-416d-8646-60a359ee488c" />



<img width="972" height="870" alt="task-5 2" src="https://github.com/user-attachments/assets/34e24b51-584b-4201-97ae-a0e09974a28d" />



<img width="1673" height="297" alt="task-5 3" src="https://github.com/user-attachments/assets/881e8505-8221-4040-bd16-1e9297bb0d62" />





4. Compare: how many resources did the VPC module create vs your hand-written VPC from Day 62?

     `VPC module`    -   The registry VPC module created 20 resources because it supports many features and creates supporting networking resources.


    `hand-written VPC` - The hand-written VPC created 5 resources 


**Document:** Where does Terraform download registry modules to? Check `.terraform/modules/`.
  - .terraform/modules/
      

---

## Task 6: Module Versioning and Best Practices
1. Pin your registry module version explicitly:
   - `version = "5.1.0"` -- exact version
   - `version = "~> 5.0"` -- any 5.x version
   - `version = ">= 5.0, < 6.0"` -- range

2. Run `terraform init -upgrade` to check for newer versions

3. Check the state to see how modules appear:
```bash
terraform state list
```
Notice the `module.vpc.`, `module.web_server.`, `module.web_sg.` prefixes.




<img width="781" height="713" alt="task-6" src="https://github.com/user-attachments/assets/a176927b-09ae-410f-b857-8b76efb19b41" />




4. Destroy everything:
```bash
terraform destroy
```



<img width="827" height="927" alt="task-6 1" src="https://github.com/user-attachments/assets/fb31c938-648f-4979-ad0a-7a67066e5fb1" />


**Document:** Write down five module best practices:
- Always pin versions for registry modules
- Keep modules focused -- one concern per module
- Use variables for everything, hardcode nothing
- Always define outputs so callers can reference resources
- Add a README.md to every custom module

---

## Learn in Public
Share on LinkedIn: "Built my first custom Terraform modules today -- EC2 and security group modules called multiple times with different configs. Then replaced 50 lines of VPC code with one registry module. Modules are the key to scalable infrastructure as code."

`#90DaysOfDevOps` `#TerraWeek` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
