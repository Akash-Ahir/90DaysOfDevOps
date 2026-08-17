# Day 67 -- TerraWeek Capstone: Multi-Environment Infrastructure with Workspaces and Modules

## Task
Seven days of Terraform -- HCL, providers, resources, dependencies, variables, outputs, data sources, state management, remote backends, custom modules, registry modules, and a full EKS cluster. Today you put it all together in one production-grade project.

Build a multi-environment AWS infrastructure using custom modules and Terraform workspaces. One codebase, three environments -- dev, staging, and prod. This is how infrastructure teams operate at scale.

---

## Challenge Tasks

## Task 1: Learn Terraform Workspaces
Before building the project, understand workspaces:

```bash
mkdir terraweek-capstone && cd terraweek-capstone
terraform init

# See current workspace
terraform workspace show                    # default

# Create new workspaces
terraform workspace new dev
terraform workspace new staging
terraform workspace new prod

# List all workspaces
terraform workspace list

# Switch between them
terraform workspace select dev
terraform workspace select staging
terraform workspace select prod
```

<img width="1046" height="818" alt="task 1 1" src="https://github.com/user-attachments/assets/7719e871-d7c9-4210-8542-60a21b001563" />


Answer:
1. What does `terraform.workspace` return inside a config?
    - It will return the current workspace


2. Where does each workspace store its state file?
    - terraform.tfstate.d/dev/terraform.tfstate
    - terraform.tfstate.d/staging/terraform.tfstate
    - terraform.tfstate.d/prod/terraform.tfstate

4. How is this different from using separate directories per environment?
    - One configuration can be reused across multiple environments while each workspace maintains its own state.


---

## Task 2: Set Up the Project Structure
Create this layout:

```
terraweek-capstone/
  main.tf                   # Root module -- calls child modules
  variables.tf              # Root variables
  outputs.tf                # Root outputs
  providers.tf              # AWS provider and backend
  locals.tf                 # Local values using workspace
  dev.tfvars                # Dev environment values
  staging.tfvars            # Staging environment values
  prod.tfvars               # Prod environment values
  .gitignore                # Ignore state, .terraform, tfvars with secrets
  modules/
    vpc/
      main.tf
      variables.tf
      outputs.tf
    security-group/
      main.tf
      variables.tf
      outputs.tf
    ec2-instance/
      main.tf
      variables.tf
      outputs.tf
```

<img width="427" height="727" alt="task 2 1" src="https://github.com/user-attachments/assets/2a9a8036-6f9e-407c-b888-3c9f74bd9572" />

Create the `.gitignore`:
```
.terraform/
*.tfstate
*.tfstate.backup
*.tfvars
.terraform.lock.hcl
```
<img width="833" height="182" alt="task 2 2" src="https://github.com/user-attachments/assets/028aa8ef-b528-4c34-8264-b668d0f68361" />





**Document:** Why is this file structure considered best practice?
  - This makes the project easier to read and maintain If I need to modify the VPC logic, I can go directly to the VPC module instead of searching through one large Terraform file.

---

## Task 3: Build the Custom Modules
Create three focused modules:

**Module 1: `modules/vpc/`**
- Input: `cidr`, `public_subnet_cidr`, `environment`, `project_name`
- Resources: VPC, public subnet, internet gateway, route table, route table association
- Output: `vpc_id`, `subnet_id`
- All resources tagged with environment and project name

**Module 2: `modules/security-group/`**
- Input: `vpc_id`, `ingress_ports`, `environment`, `project_name`
- Resources: Security group with dynamic ingress rules, allow all egress
- Output: `sg_id`

**Module 3: `modules/ec2-instance/`**
- Input: `ami_id`, `instance_type`, `subnet_id`, `security_group_ids`, `environment`, `project_name`
- Resources: EC2 instance with tags
- Output: `instance_id`, `public_ip`

Write and validate each module:
```bash
terraform validate
```

<img width="901" height="95" alt="task 3" src="https://github.com/user-attachments/assets/7f0fa692-42cd-4b8f-a445-fffad6da7104" />


---

## Task 4: Wire It All Together with Workspace-Aware Config
In the root module, use `terraform.workspace` to drive environment-specific behavior.

**`locals.tf`:**
```hcl
locals {
  environment = terraform.workspace
  name_prefix = "${var.project_name}-${local.environment}"

  common_tags = {
    Project     = var.project_name
    Environment = local.environment
    ManagedBy   = "Terraform"
    Workspace   = terraform.workspace
  }
}
```

**`variables.tf`:**
```hcl
variable "project_name" {
  type    = string
  default = "terraweek"
}

variable "vpc_cidr" {
  type = string
}

variable "subnet_cidr" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ingress_ports" {
  type    = list(number)
  default = [22, 80]
}
```

**`main.tf`** -- call all three modules, passing workspace-aware names and variables.

**Environment-specific tfvars:**

`dev.tfvars`:
```hcl
vpc_cidr      = "10.0.0.0/16"
subnet_cidr   = "10.0.1.0/24"
instance_type = "t2.micro"
ingress_ports = [22, 80]
```

`staging.tfvars`:
```hcl
vpc_cidr      = "10.1.0.0/16"
subnet_cidr   = "10.1.1.0/24"
instance_type = "t2.small"
ingress_ports = [22, 80, 443]
```

`prod.tfvars`:
```hcl
vpc_cidr      = "10.2.0.0/16"
subnet_cidr   = "10.2.1.0/24"
instance_type = "t3.small"
ingress_ports = [80, 443]
```

Notice: dev allows SSH, prod does not. Different CIDRs prevent overlap. Instance types scale up per environment.

---

## Task 5: Deploy All Three Environments
Deploy each environment using its workspace and tfvars file:

**Dev:**
```bash
terraform workspace select dev
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"
```
<img width="1398" height="472" alt="task 5 1" src="https://github.com/user-attachments/assets/b4767e9b-7840-4171-9907-f4c302b3a614" />

<img width="1417" height="867" alt="task 5 2" src="https://github.com/user-attachments/assets/69cf9be6-1bd9-478e-9e1b-274fb31cc977" />



**Staging:**
```bash
terraform workspace select staging
terraform plan -var-file="staging.tfvars"
terraform apply -var-file="staging.tfvars"
```

<img width="1701" height="736" alt="task 5 3" src="https://github.com/user-attachments/assets/1dbba098-f97d-4cd8-8ed8-52045d305c00" />

<img width="1403" height="966" alt="task 5 4" src="https://github.com/user-attachments/assets/6ad4d862-53aa-4f58-b199-944c04d53245" />



**Prod:**
```bash
terraform workspace select prod
terraform plan -var-file="prod.tfvars"
terraform apply -var-file="prod.tfvars"
```

<img width="1778" height="665" alt="task 5 5" src="https://github.com/user-attachments/assets/b2275848-27ec-48f5-a378-7e443fdeed65" />

<img width="1272" height="895" alt="task 5 6" src="https://github.com/user-attachments/assets/8e6b1eae-a2ce-4ed8-beb1-eed4d1927d3e" />



After all three are deployed, verify:
```bash
# Check each workspace's resources
terraform workspace select dev && terraform output
terraform workspace select staging && terraform output
terraform workspace select prod && terraform output
```

<img width="1072" height="472" alt="task 5 7" src="https://github.com/user-attachments/assets/384167f8-ec75-4ac3-9385-1633f0c47030" />


Go to the AWS console and verify:
- Three separate VPCs with different CIDR ranges

<img width="1676" height="150" alt="task 5 8" src="https://github.com/user-attachments/assets/d1cb4a5e-50ec-4fa9-8042-e3f8b15cd611" />


- Three EC2 instances with different instance types

<img width="1681" height="222" alt="task 5 9" src="https://github.com/user-attachments/assets/988175d5-b0ac-4060-8505-28ce17c0dc54" />



- Different Name tags per environment: `terraweek-dev-server`, `terraweek-staging-server`, `terraweek-prod-server`

**Verify:** Are all three environments completely isolated from each other? -yes

---

## Task 6: Document Best Practices
Write down everything you have learned this week as a Terraform best practices guide:

1. **File structure** -- separate files for providers, variables, outputs, main, locals
2. **State management** -- always use remote backend, enable locking, enable versioning
3. **Variables** -- never hardcode, use tfvars per environment, validate with `validation` blocks
4. **Modules** -- one concern per module, always define inputs/outputs, pin registry module versions
5. **Workspaces** -- use for environment isolation, reference `terraform.workspace` in configs
6. **Security** -- .gitignore for state and tfvars, encrypt state at rest, restrict backend access
7. **Commands** -- always run `plan` before `apply`, use `fmt` and `validate` before committing
8. **Tagging** -- tag every resource with project, environment, and managed-by
9. **Naming** -- consistent prefix pattern: `<project>-<environment>-<resource>`
10. **Cleanup** -- always `terraform destroy` non-production environments when not in use

---

## Task 7: Destroy All Environments
Clean up all three environments in reverse order:

```bash
terraform workspace select prod
terraform destroy -var-file="prod.tfvars"
```
<img width="1227" height="805" alt="task 7 1" src="https://github.com/user-attachments/assets/97d99f50-4b03-4c32-9100-7242d0af180d" />

```
terraform workspace select staging
terraform destroy -var-file="staging.tfvars"
```
<img width="1286" height="913" alt="task 7 2" src="https://github.com/user-attachments/assets/7f565e43-dabc-4ae1-87eb-93714e64bc94" />


```
terraform workspace select dev
terraform destroy -var-file="dev.tfvars"
```
<img width="1131" height="912" alt="task 7 3" src="https://github.com/user-attachments/assets/b09ff35a-0e00-4413-beb5-65d9a9971686" />


Verify in the AWS console -- all VPCs, instances, security groups, and gateways should be gone.

<img width="1537" height="242" alt="task 7 5" src="https://github.com/user-attachments/assets/27ad8030-0113-4a1b-a614-70a912243dcf" />
<img width="1691" height="231" alt="task 7 6" src="https://github.com/user-attachments/assets/ec31cb01-e850-407e-bc9b-e19462215e6b" />



Delete the workspaces:
```bash
terraform workspace select default
terraform workspace delete dev
terraform workspace delete staging
terraform workspace delete prod
```

<img width="1047" height="185" alt="task 7 4" src="https://github.com/user-attachments/assets/047de219-d6da-4717-9a18-67dd96f08ccf" />


**Verify:** Is your AWS account completely clean? - yes

---


## Documentation

| Day | Concepts |
|-----|----------|
| 61 | IaC, HCL, init/plan/apply/destroy, state basics |
| 62 | Providers, resources, dependencies, lifecycle |
| 63 | Variables, outputs, data sources, locals, functions |
| 64 | Remote backend, locking, import, drift |
| 65 | Custom modules, registry modules, versioning |
| 66 | EKS with modules, real-world provisioning |
| 67 | Workspaces, multi-env, capstone project |

---
