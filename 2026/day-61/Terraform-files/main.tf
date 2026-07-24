provider "aws" {
        region = "us-east-1"
}


resource "aws_s3_bucket" "terra_worker_bucket" {
        bucket = "akashahir-s3-bucket"
}

resource "aws_instance" "my_server" {
  ami           = "ami-0b826bb6d96d2afe4"
  instance_type = "t3.micro"
  tags = {
  Name = "TerraWeek-Modified"
}
}
