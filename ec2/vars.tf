# "aws_availability_zones" "available" {}

variable "ami" {
  default = "ami-0a313d6098716f372"
}

variable "key_path" {
  default = "ec2/devops_key"
}

variable "pem_file" {
  default = "ec2/devops.pem"
}

variable "vpc_id" {}

variable "subnet_id" {}

variable "vpc_security_group_ids" {}
