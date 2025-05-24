 provider "aws" {
   region     = "us-east-1"
}

locals {
  instance_name = "${terraform.workspace}-instance" 
}
data "aws_ami" "latest" {
    most_recent = true
}


resource "aws_instance" "ec2_example" {

    ami         = data.aws_ami.latest.id # Amazon Linux 2 AMI

    instance_type = var.instance_type

    tags = {
      Name = local.instance_name
    }
}

variable "instance_type" {
  description = "The type of instance to create"
  type        = string
  default     = "t2.micro"
  
}
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-t"
    key            = "ec2/all-workspace-test/terraform.tfstate"
    region        =  "us-east-1"
    #dynamodb_table = "value-lock-table"
    #encrypt        = true
  }
}