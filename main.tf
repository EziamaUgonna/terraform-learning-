terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
    #region = "ca-central-1"
    #access_key = "AKIA6E4QUBYS3MPOXAHP"
    #secret_key = "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"
}

#variable "cidr_blocks" {
#description = "cidr blocks for vpc and subnets"
#type = list(string)  
#}
variable "cidr_blocks" {
  description = "cidr blocks and name tags for vpc and subnets"
  type = list(object({
      cidr_block = string
      name = string
  }))
}

resource "aws_vpc" "development-vpc" {
   cidr_block = var.cidr_blocks[0].cidr_block
   tags = {
      Name: var.cidr_blocks[0].name
   }
  
}
variable avail_zone{}
resource "aws_subnet" "dev-subnet-1" {
   vpc_id =  aws_vpc.development-vpc.id
   cidr_block = var.cidr_blocks[1].cidr_block

   #availability_zone = "ca-central-1b"
   availability_zone = var.avail_zone
   tags = {
      Name: var.cidr_blocks[1].name
   }
  
}