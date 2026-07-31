# Day 63 -- Variables, Outputs, Data Sources and Expressions

## Task
Your Day 62 config works, but it is full of hardcoded values -- region, CIDR blocks, AMI IDs, instance types, tags. Change the region and everything breaks. Today you make your Terraform configs dynamic, reusable, and environment-aware.

This is the difference between a config that works once and a config you can use across projects.

---

## Challenge Tasks

### TERRAFORM FILE: 
[main.tf](https://github.com/Akash-Ahir/90DaysOfDevOps/tree/master/2026/day-63/Terraforms-files/main.tf)<br/>

 [providers.tf](https://github.com/Akash-Ahir/90DaysOfDevOps/tree/master/2026/day-63/Terraforms-files/providers.tf)<br/>

## Task 1: Extract Variables
Take your Day 62 infrastructure config and refactor it:

1. Create a `variables.tf` file with input variables for:
   - `region` (string, default: your preferred region)
   - `vpc_cidr` (string, default: `"10.0.0.0/16"`)
   - `subnet_cidr` (string, default: `"10.0.1.0/24"`)
   - `instance_type` (string, default: `"t2.micro"`)
   - `project_name` (string, no default -- force the user to provide it)
   - `environment` (string, default: `"dev"`)
   - `allowed_ports` (list of numbers, default: `[22, 80, 443]`)
   - `extra_tags` (map of strings, default: `{}`)

2. Replace every hardcoded value in `main.tf` with `var.<name>` references
3. Run `terraform plan` -- it should prompt you for `project_name` since it has no default


### [variables.tf](https://github.com/Akash-Ahir/90DaysOfDevOps/tree/master/2026/day-63/Terraforms-files/variables.tf)<br/>


<img width="1497" height="352" alt="task-1 1" src="https://github.com/user-attachments/assets/1d360141-79d5-485d-9409-cfe298cf749a" />

<img width="1452" height="217" alt="task-1 2" src="https://github.com/user-attachments/assets/623f11ca-de9c-4a54-a55f-1702c9dcd354" />



**Document:** What are the five variable types in Terraform? (`string`, `number`, `bool`, `list`, `map`)


  - `string` - A primitive data type used to store text values such as "DevOps" or "terraform"


  - `number` - A primitive data type used to store integers as well as decimal values such as 45 or 4.5


  - `bool` - it is a primitive type which represents a boolean value of either "true" or "false"


  - `list` - it is a collection type that stores an ordered sequence of values like ["s3-bucket-1","s3-bucket-3"]


  - `map` -it is a data structure used to store and manage collection data as key value pairs like {env="dev"}

---

## Task 2: Variable Files and Precedence
1. Create `terraform.tfvars`:
```hcl
project_name = "terraweek"
environment  = "dev"
instance_type = "t2.micro"
```

### [terraform.tfvars](https://github.com/Akash-Ahir/90DaysOfDevOps/tree/master/2026/day-63/Terraforms-files/terraform.tfvars)<br/>


2. Create `prod.tfvars`:
```hcl
project_name = "terraweek"
environment  = "prod"
instance_type = "t3.small"
vpc_cidr     = "10.1.0.0/16"
subnet_cidr  = "10.1.1.0/24"
```

### [prod.tfvars](https://github.com/Akash-Ahir/90DaysOfDevOps/tree/master/2026/day-63/Terraforms-files/prod.tfvars)<br/>


3. Apply with the default file:
```bash
terraform plan                              # Uses terraform.tfvars automatically
```

<img width="1476" height="780" alt="task-2 1" src="https://github.com/user-attachments/assets/b6213c66-0f1e-4a7a-a2af-71134d96feb9" />


4. Apply with the prod file:
```bash
terraform plan -var-file="prod.tfvars"      # Uses prod.tfvars
```

<img width="1526" height="842" alt="task-2 2" src="https://github.com/user-attachments/assets/16a4bdcc-f686-4925-b5df-c0c11ef7731f" />


5. Override with CLI:
```bash
terraform plan -var="instance_type=t2.nano"  # CLI overrides everything
```

<img width="1721" height="897" alt="task-2 3" src="https://github.com/user-attachments/assets/7bf08ac5-6ef7-4208-abe1-fad311726f40" />


6. Set an environment variable:
```bash
export TF_VAR_environment="staging"
terraform plan                              # env var overrides default but not tfvars
```

**Document:** Write the variable precedence order from lowest to highest priority.
  -  Default values in variables.tf
  -  Environment variables (TF_VAR_*)
  -  terraform.tfvars
  -  *.auto.tfvars
  -  -var-file
  -  -var

---

## Task 3: Add Outputs
Create an `outputs.tf` file with outputs for:

1. `vpc_id` -- the VPC ID
2. `subnet_id` -- the public subnet ID
3. `instance_id` -- the EC2 instance ID
4. `instance_public_ip` -- the public IP of the EC2 instance
5. `instance_public_dns` -- the public DNS name
6. `security_group_id` -- the security group ID


### [outputs.tf](https://github.com/Akash-Ahir/90DaysOfDevOps/tree/master/2026/day-63/Terraforms-files/outputs.tf)<br/>


<img width="847" height="235" alt="task-3 1" src="https://github.com/user-attachments/assets/3095aff6-6881-4829-930b-0fae7db0d524" />




Apply your config and verify the outputs are printed at the end:
```bash
terraform apply

# After apply, you can also run:
terraform output                          # Show all outputs
terraform output instance_public_ip       # Show a specific output
terraform output -json                    # JSON format for scripting
```

### `terraform output` and `terraform output instance_public_ip `


<img width="840" height="212" alt="task-3 2" src="https://github.com/user-attachments/assets/269fcde8-c697-4e2a-8dea-e3ef8b415253" />



### `terraform output -json` 



<img width="712" height="782" alt="task-3 3" src="https://github.com/user-attachments/assets/96e5c03b-9ea8-4ec4-8609-1a51b7d09841" />




<img width="1562" height="151" alt="task-3 4" src="https://github.com/user-attachments/assets/18e56dc5-ae11-48bd-b880-28c9281b53f6" />




**Verify:** Does `terraform output instance_public_ip` return the correct IP? -yes (34.237.222.97)

---

## Task 4: Use Data Sources
Stop hardcoding the AMI ID. Use a data source to fetch it dynamically.

1. Add a `data "aws_ami"` block that:
   - Filters for Amazon Linux 2 images
   - Filters for `hvm` virtualization and `gp2` root device
   - Uses `owners = ["amazon"]`
   - Sets `most_recent = true`

2. Replace the hardcoded AMI in your `aws_instance` with `data.aws_ami.amazon_linux.id`

3. Add a `data "aws_availability_zones"` block to fetch available AZs in your region

4. Use the first AZ in your subnet: `data.aws_availability_zones.available.names[0]`

Apply and verify -- your config now works in any region without changing the AMI.


<img width="1570" height="627" alt="task-4 1" src="https://github.com/user-attachments/assets/454cf9b5-5bad-4fe6-866e-576a83e25df5" />

<img width="802" height="507" alt="task-4 2" src="https://github.com/user-attachments/assets/4f7d8050-62c3-4261-927b-8849558c347c" />



**Document:** What is the difference between a `resource` and a `data` source?

  - `resource` - Resouce is used to create, update, or manage infrastructure like EC2 instances, VPCs, or S3 buckets

  - `data source` - Data source is used to fetch information from existing infrastructure without creating or modifying it
    
---

## Task 5: Use Locals for Dynamic Values
1. Add a `locals` block:
```hcl
locals {
  name_prefix = "${var.project_name}-${var.environment}"
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
```

2. Replace all Name tags with `local.name_prefix`:
   - VPC: `"${local.name_prefix}-vpc"`
   - Subnet: `"${local.name_prefix}-subnet"`
   - Instance: `"${local.name_prefix}-server"`

3. Merge common tags with resource-specific tags:
```hcl
tags = merge(local.common_tags, {
  Name = "${local.name_prefix}-server"
})
```

Apply and check the tags in the AWS console -- every resource should have consistent tagging.


<img width="1466" height="292" alt="task-5 1" src="https://github.com/user-attachments/assets/505c5a8e-e9c7-4142-bc2f-811990f21ea0" />


<img width="1220" height="297" alt="task-5 2" src="https://github.com/user-attachments/assets/589b618e-2b32-4a0f-a8b1-152915cc2a86" />


<img width="1397" height="62" alt="task-5 3" src="https://github.com/user-attachments/assets/e620f92a-45ab-439d-ba3e-520eb0301688" />




---

## Task 6: Built-in Functions and Conditional Expressions
Practice these in `terraform console`:
```bash
terraform console
```

1. **String functions:**
   - `upper("terraweek")` -> `"TERRAWEEK"`
   - `join("-", ["terra", "week", "2026"])` -> `"terra-week-2026"`
   - `format("arn:aws:s3:::%s", "my-bucket")`

2. **Collection functions:**
   - `length(["a", "b", "c"])` -> `3`
   - `lookup({dev = "t2.micro", prod = "t3.small"}, "dev")` -> `"t2.micro"`
   - `toset(["a", "b", "a"])` -> removes duplicates

3. **Networking function:**
   - `cidrsubnet("10.0.0.0/16", 8, 1)` -> `"10.0.1.0/24"`

4. **Conditional expression** -- add this to your config:
```hcl
instance_type = var.environment == "prod" ? "t3.small" : "t2.micro"
```
<img width="690" height="415" alt="task-6 1" src="https://github.com/user-attachments/assets/1dd3ea60-b5c1-4e2f-8227-021e0f3de2cf" />






Apply with `environment = "prod"` and verify the instance type changes.



<img width="1457" height="537" alt="task-6 2" src="https://github.com/user-attachments/assets/d1b3f2fc-d595-4168-adc5-24af0aa5b33d" />

---

