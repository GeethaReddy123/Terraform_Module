provider "aws" {
  region     = "${var.region}"
}

resource "aws_vpc" "main"{
  cidr_block  = "${var.vpc_cidr}"
  instance_tenancy  = "default"

  tags = {
    Name  = "main"
  }

}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}
