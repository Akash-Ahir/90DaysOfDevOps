# Day 64 -- Terraform State Management and Remote Backends

## Task
The state file is the single most important thing in Terraform. It is the source of truth -- the map between your `.tf` files and what actually exists in the cloud. Lose it and Terraform forgets everything. Corrupt it and your next apply could destroy production.

Today you learn to manage state like a professional -- remote backends, locking, importing existing resources, and handling drift.


---

## Challenge Tasks

## Task 1: Inspect Your Current State
Use your Day 63 config (or create a small config with a VPC and EC2 instance). Apply it and then explore the state:

```bash
terraform show                                    # Full state in human-readable format
terraform state list                              # All resources tracked by Terraform
terraform state show aws_instance.<name>          # Every attribute of the instance
terraform state show aws_vpc.<name>               # Every attribute of the VPC

```

Answer:
1. How many resources does Terraform track?
    - It showing total 11 managed AWS resources 

2. What attributes does the state store for an EC2 instance? (hint: way more than what you defined)
    - Its store Instance ID, ARN ,AMI ID ,Instance type ,Instance state, Public IP, Private IP, Public DNS, Private DNS, Availability Zone, Security Group IDs, and many other AWS attributes.

3. Open `terraform.tfstate` in an editor -- find the `serial` number. What does it represent?
   - 12

<img width="696" height="178" alt="task 1" src="https://github.com/user-attachments/assets/418de619-1c2b-4caf-906f-3a2b412433b3" />


---

## Task 2: Set Up S3 Remote Backend
Storing state locally is dangerous -- one deleted file and you lose everything. Time to move it to S3.

1. First, create the backend infrastructure (do this manually or in a separate Terraform config):
```bash
# Create S3 bucket for state storage
aws s3api create-bucket \
  --bucket terraweek-state-<yourname> \
  --region ap-south-1 \
  --create-bucket-configuration LocationConstraint=ap-south-1 

# Enable versioning (so you can recover previous state)
aws s3api put-bucket-versioning \
  --bucket terraweek-state-<yourname> \
  --versioning-configuration Status=Enabled

# Create DynamoDB table for state locking
aws dynamodb create-table \
  --table-name terraweek-state-lock \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region ap-south-1
```

<img width="1738" height="326" alt="task 2 1" src="https://github.com/user-attachments/assets/2dcfe1fe-0c0b-4ab7-a81b-6e22bdf8a453" />
<img width="1512" height="200" alt="task 2 2" src="https://github.com/user-attachments/assets/4acb6406-f17e-47c7-a46b-bed6022eaf5f" />





2. Add the backend block to your Terraform config:
```hcl
terraform {
  backend "s3" {
    bucket         = "terraweek-state-<yourname>"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraweek-state-lock"
    encrypt        = true
  }
}
```

<img width="1080" height="706" alt="task 2 3" src="https://github.com/user-attachments/assets/b6791ef1-3a9e-4dd4-86b5-776b3e133c1d" />


3. Run:
```bash
terraform init
```
Terraform will ask: "Do you want to copy existing state to the new backend?" -- say yes.

4. Verify:
   - Check the S3 bucket -- you should see `dev/terraform.tfstate` - yes
   - Your local `terraform.tfstate` should now be empty or gone - yes its empty
   - Run `terraform plan` -- it should show no changes (state migrated correctly)
  
   <img width="1402" height="541" alt="task 2 4" src="https://github.com/user-attachments/assets/98adc3fc-53a2-4f3d-8ee6-076c11e1cfef" />


---

## Task 3: Test State Locking
State locking prevents two people from running `terraform apply` at the same time and corrupting the state.

1. Open **two terminals** in the same project directory
2. In Terminal 1, run:
```bash
terraform apply
```
3. While Terminal 1 is waiting for confirmation, in Terminal 2 run:
```bash
terraform plan
```

4. Terminal 2 should show a **lock error** with a Lock ID


<img width="1841" height="477" alt="task 3 1" src="https://github.com/user-attachments/assets/293de931-8034-4f95-b761-c03b645220a9" />

<img width="1280" height="297" alt="task 3 2" src="https://github.com/user-attachments/assets/7d805442-6be6-4314-8aea-e3fbdc00278e" />


**Document:** What is the error message? Why is locking critical for team environments?

  - Terraform returned an "Error acquiring the state lock" because another user is accessing the the remote state.


  - State locking ensures that only one Terraform operation can modify the infrastructure at a time and avoids state corruption
  

5. After the test, if you get stuck with a stale lock:
```bash
terraform force-unlock <LOCK_ID>
```

---

## Task 4: Import an Existing Resource
Not everything starts with Terraform. Sometimes resources already exist in AWS and you need to bring them under Terraform management.

1. Manually create an S3 bucket in the AWS console -- name it `terraweek-import-test-<yourname>`

<img width="1647" height="500" alt="task 4 1" src="https://github.com/user-attachments/assets/f0c98df3-c2d2-434e-86cd-a4f803a0c2fc" />


2. Write a `resource "aws_s3_bucket"` block in your config for this bucket (just the bucket name, nothing else)
3. Import it:
```bash
terraform import aws_s3_bucket.imported terraweek-import-test-<yourname>
```

<img width="1227" height="607" alt="task 4 2" src="https://github.com/user-attachments/assets/268e854f-80dd-4e2b-8b93-fddcf2e4f8c1" />


4. Run `terraform plan`:
   - If you see "No changes" -- the import was perfect
   - If you see changes -- your config does not match reality. Update your config to match, then plan again until you get "No changes"

5. Run `terraform state list` -- the imported bucket should now appear alongside your other resources

<img width="641" height="397" alt="task 4 3" src="https://github.com/user-attachments/assets/b4e68e11-4dd2-4cd2-962f-2f828a514804" />


**Document:** What is the difference between `terraform import` and creating a resource from scratch?


  `terraform import` - terraform import helps to fetch the remote resources which is already running to your local 

  
  `resource from scratch` - creating a resources from terraform  provisions which later applied on aws or other provider 
  
  

---

## Task 5: State Surgery -- mv and rm
Sometimes you need to rename a resource or remove it from state without destroying it in AWS.

1. **Rename a resource in state:**
```bash
terraform state list                              # Note the current resource names
terraform state mv aws_s3_bucket.imported aws_s3_bucket.logs_bucket
```

<img width="666" height="322" alt="task 5 1" src="https://github.com/user-attachments/assets/896fd1d4-51a4-4388-9f7f-19220538cc71" />


Update your `.tf` file to match the new name. Run `terraform plan` -- it should show no changes.

<img width="1043" height="207" alt="task 5 2" src="https://github.com/user-attachments/assets/60165ec8-a98b-4f0b-aa9e-3a757796ffc9" />
<img width="1660" height="637" alt="task 5 3" src="https://github.com/user-attachments/assets/b92ee80e-7c55-4ddf-85fd-9193416bb3eb" />
<img width="652" height="347" alt="task 5 4" src="https://github.com/user-attachments/assets/5b9c0822-ed39-4cda-8802-aa10f59c379f" />





2. **Remove a resource from state (without destroying it):**
```bash
terraform state rm aws_s3_bucket.logs_bucket
```

<img width="973" height="562" alt="task 5 5" src="https://github.com/user-attachments/assets/3bff168e-9a40-4875-b9ef-3ae604fcb475" />


Run `terraform plan` -- Terraform no longer knows about the bucket, but it still exists in AWS.

<img width="1775" height="647" alt="task 5 6" src="https://github.com/user-attachments/assets/6a0d0710-179c-4eab-bc30-0cadb4150031" />


3. **Re-import it** to bring it back:
```bash
terraform import aws_s3_bucket.logs_bucket terraweek-import-test-<yourname>
```
<img width="1090" height="271" alt="task 5 7" src="https://github.com/user-attachments/assets/7a12081f-4531-4aae-9fe0-d107d805d33c" />
<img width="1045" height="308" alt="task 5 8" src="https://github.com/user-attachments/assets/b0976dbd-86fd-4f3b-a1c8-54489e86d9db" />



**Document:** When would you use `state mv` in a real project? When would you use `state rm`?

  `state mv` - used when renaming or reorganizing Terraform resources without recreating the underlying infrastructure
  
  `state rm` - used when an existing resource should no longer be managed by Terraform but must continue to exist in the cloud

---

## Task 6: Simulate and Fix State Drift
State drift happens when someone changes infrastructure outside of Terraform -- through the AWS console, CLI, or another tool.

1. Apply your full config so everything is in sync
2. Go to the **AWS console** and manually:
   - Change the Name tag of your EC2 instance to `"ManuallyChanged"`
   - Change the instance type if it's stopped (or add a new tag)
  
<img width="1122" height="221" alt="task 6 1" src="https://github.com/user-attachments/assets/901fb4ff-13b4-465a-ad67-97840c1e66e0" />


3. Run:
```bash
terraform plan
```
You should see a **diff** -- Terraform detects that reality no longer matches the desired state.

<img width="986" height="503" alt="task 6 2" src="https://github.com/user-attachments/assets/32c7f84c-7654-4e24-a7e0-69f7e1444f95" />


4. You have two choices:
   - **Option A:** Run `terraform apply` to force reality back to match your config (reconcile)
   - **Option B:** Update your `.tf` files to match the manual change (accept the drift)

5. Choose Option A -- apply and verify the tags are restored.

6. Run `terraform plan` again -- it should show "No changes." Drift resolved.

<img width="1227" height="911" alt="task 6 3" src="https://github.com/user-attachments/assets/ac25f581-9776-45ff-a2cc-3f1858e86e4c" />


**Document:** How do teams prevent state drift in production? (hint: restrict console access, use CI/CD for all changes)
  - We can restricted AWS Console using IAM permissions and using  CI/CD for all changes also Regular terraform plan checks help detect any unexpected drift before changes are applied


---

## Diagram: local state vs remote state setup
<img width="888" height="587" alt="image" src="https://github.com/user-attachments/assets/90c18cc9-9111-4c2d-a5f8-f7fc5a0e92aa" />


---
