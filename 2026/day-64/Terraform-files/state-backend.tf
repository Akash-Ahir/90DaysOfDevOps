terraform {
  backend "s3" {
    bucket         = "akash-terraweek-state"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraweek-state-lock"
    encrypt        = true
  }
}
