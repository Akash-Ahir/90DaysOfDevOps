# Day 61 -- Introduction to Terraform and Your First AWS Infrastructure

## Task
You have been deploying containers, writing CI/CD pipelines, and orchestrating workloads on Kubernetes. But who creates the servers, networks, and clusters underneath? Today you start your Infrastructure as Code journey with Terraform -- the tool that lets you define, provision, and manage cloud infrastructure by writing code.

By the end of today, you will have created real AWS resources using nothing but a `.tf` file and a terminal.


---

## Challenge Tasks

## Task 1: Understand Infrastructure as Code
Before touching the terminal, research and write short notes on:

1. What is Infrastructure as Code (IaC)? Why does it matter in DevOps?

  `What is Terraform`- Terraform is the practice of managing and provisioning IT infrastructure like servers, databases, and network through machine readable code insted of clicking through manual web interface
  
  `Why does it matter in DevOps`- Manually provisioning cloud infrastructure is slow, hard to track, and prone to human errors. Infrastructure as a code matters because it provides version control, scalability and automated deployments. With terraform devops team can create indentical environment in minutes ensure consistency, and recovery instently from disasters by simple rerunning the code  

2. What problems does IaC solve compared to manually creating resources in the AWS console?
  
  - Manual creation takes time and is prone to human errors which result in saving `time`, `efficiency`, `expenses`, `automation`, `not wasted resources`, and `not dependent on other`

3. How is Terraform different from AWS CloudFormation, Ansible, and Pulumi?

   ###**Terraform vs Ansible**###
 
   `Terraform`- terraform is used to provision infrastructure

   `Ansible` - Ansible is used to configure and manage software on those server

  ###**Terraform vs Cloud Formation**###
  
  `Terraform`- Terraform is owned by harshicorp and can be used for multiple cloud providers 

  `Cloud Formation` - Cloud Formation is  owned by AWS and can be only used for AWS cloud services
  
          
5. What does it mean that Terraform is "declarative" and "cloud-agnostic"?

  - `Declarative`- write code that describes the final desired state of your infrastructure, and the tool figures out the exact step-by-step actions needed to make it happen
  
  - `cloud-agnostic`- it means that we are not dependent on a single platform cloud service we are independent to use any other platform also 

---

## Task 2: Install Terraform and Configure AWS
1. Install Terraform:
```bash
# macOS
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

# Linux (amd64)
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# Windows
choco install terraform
```

2. Verify:
```bash
terraform -version
```

<img width="1016" height="950" alt="task-1" src="https://github.com/user-attachments/assets/0eacf119-1215-4559-8fe8-cd1ac07efa40" />


3. Install and configure the AWS CLI:
```bash
aws configure
# Enter your Access Key ID, Secret Access Key, default region (e.g., ap-south-1), output format (json)
```

4. Verify AWS access:
```bash
aws sts get-caller-identity
```

You should see your AWS account ID and ARN. - YES



---

## Task 3: Your First Terraform Config -- Create an S3 Bucket

Create a project directory and write your first Terraform config:

```bash
mkdir terraform-basics && cd terraform-basics
```

Create a file called `main.tf` with:
1. A `terraform` block with `required_providers` specifying the `aws` provider
2. A `provider "aws"` block with your region
3. A `resource "aws_s3_bucket"` that creates a bucket with a globally unique name

Run the Terraform lifecycle:
```bash
terraform init      # Download the AWS provider
terraform plan      # Preview what will be created
terraform apply     # Create the bucket (type 'yes' to confirm)
```
<img width="1206" height="627" alt="task-3 1" src="https://github.com/user-attachments/assets/ae1f52bb-98bb-4c61-aa28-64675f64c275" />



<img width="1180" height="812" alt="task-3 2" src="https://github.com/user-attachments/assets/1f159c3e-789c-45f6-be59-62e0291a3cd7" />



<img width="1122" height="927" alt="task-3 3" src="https://github.com/user-attachments/assets/f671178d-de57-4d8f-b535-8e90d329a5c5" />



<img width="1035" height="252" alt="task-3 4" src="https://github.com/user-attachments/assets/d0557f5e-9d30-4fd8-a7b5-fe62eb4d0ffe" />



Go to the AWS S3 console and verify your bucket exists.

  - Yes the bucket is created 

**Document:** What did `terraform init` download? What does the `.terraform/` directory contain?

  `terraform init`- This will scan our .tf file in that folder and install all the required automation things and create env

  `.terraform/`- Contains downloaded provider plugins and metadata that Terraform needs to communicate with AWS

---

## Task 4: Add an EC2 Instance
In the same `main.tf`, add:
1. A `resource "aws_instance"` using AMI `ami-0f5ee92e2d63afc18` (Amazon Linux 2 in ap-south-1 -- use the correct AMI for your region)
2. Set instance type to `t2.micro`
3. Add a tag: `Name = "TerraWeek-Day1"`

Run:
```bash
terraform plan      # You should see 1 resource to add (bucket already exists)
terraform apply
```


<img width="1602" height="125" alt="task-4 1" src="https://github.com/user-attachments/assets/257b8381-6a37-4b3b-ba2b-8faf739545cd" />



Go to the AWS EC2 console and verify your instance is running with the correct name tag. 

<img width="617" height="810" alt="task-4 2" src="https://github.com/user-attachments/assets/f5e9f034-2775-42bd-828e-261a8fd60da5" />


**Document:** How does Terraform know the S3 bucket already exists and only the EC2 instance needs to be created?
 
  - Due to terraform state file terraform tracks everything it creates in a state file

---

## Task 5: Understand the State File
Terraform tracks everything it creates in a state file. Time to inspect it.

1. Open `terraform.tfstate` in your editor -- read the JSON structure
2. Run these commands and document what each returns:

`terraform show`                          # Human-readable view of current state


<img width="1077" height="676" alt="task-5 1" src="https://github.com/user-attachments/assets/a20e7ffb-1945-4b3d-bb60-ecca93fda1a0" />


`terraform state list`                    # List all resources Terraform manages


<img width="641" height="81" alt="task-5 2" src="https://github.com/user-attachments/assets/1e60117e-19c9-444c-9791-b1eedc41771a" />


`terraform state show aws_s3_bucket.<name>`   # Detailed view of a specific resource


<img width="912" height="795" alt="task-5 3" src="https://github.com/user-attachments/assets/9575024a-39d9-472c-8ccd-d2c32f4e8ae4" />



`terraform state show aws_instance.<name>`

<img width="1087" height="840" alt="task-5 4" src="https://github.com/user-attachments/assets/5a1b4e65-b86b-4242-8a0f-b8b4bfd619db" />



3. Answer these questions in your notes:
   - What information does the state file store about each resource?
  
     - Resource IDs, ARNs, Public IPs, Metadata and etc
       
   - Why should you never manually edit the state file?
     
      - If we edit it manually then terraform may get confused between the resources it can show the resources is created so it will not create the resources

   - Why should the state file not be committed to Git?
       - because doing so can result in data loss or exposure of secrets stored in the state file
---

## Task 6: Modify, Plan, and Destroy
1. Change the EC2 instance tag from `"TerraWeek-Day1"` to `"TerraWeek-Modified"` in your `main.tf`
2. Run `terraform plan` and read the output carefully:
   - What do the `~`, `+`, and `-` symbols mean?
     `~` this will show the changes/update has to be made in existing resources
     `+` the resources which is going to be added 
     `-` the resources which is going to delete/destroyed

   - Is this an in-place update or a destroy-and-recreate?
     - its and in-place update (~)
    
  
<img width="1482" height="522" alt="task-6 1" src="https://github.com/user-attachments/assets/ee5ad12f-2e97-4a2b-88d3-e55af45d898f" />

3. Apply the change

<img width="1327" height="620" alt="task-6 2" src="https://github.com/user-attachments/assets/8ba6ed37-06ab-49ab-bdbc-673cd4022e87" />

4. Verify the tag changed in the AWS console

<img width="1300" height="215" alt="task-6 3" src="https://github.com/user-attachments/assets/c5a68baa-2719-4ba4-82fc-087e865bc103" />

5. Finally, destroy everything:
```bash
terraform destroy
```


<img width="950" height="362" alt="task-6 4" src="https://github.com/user-attachments/assets/d8f96be2-a51b-4a26-b58c-eced7faa1668" />

6. Verify in the AWS console -- both the S3 bucket and EC2 instance should be gone

<img width="1322" height="110" alt="task-6 5" src="https://github.com/user-attachments/assets/075315d3-487b-47cd-a5ab-53af77a81d81" />


---


`#90DaysOfDevOps` `#TerraWeek` `#DevOpsKaJosh` `#TrainWithShubham`

