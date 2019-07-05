module "my_vpc" {
  source = "./vpc"
}

module "my_subnet" {
  source = "./subnet"
  vpc_id = "${module.my_vpc.vpc_id}"
}

module "my_secg" {
  source = "./security_groups"
  vpc_id = "${module.my_vpc.vpc_id}"
}

module "my_ec2" {
  source = "./ec2"
  vpc_id = "${module.my_vpc.vpc_id}"
  subnet_id = "${module.my_subnet.subnet_id}"
  vpc_security_group_ids = "${module.my_secg.sgweb_id}"
}

module "my_elb" {
  source = "./elb"
  subnet_id = "${module.my_subnet.subnet_id}"
  vpc_security_group_ids = "${module.my_secg.sgweb_id}"
  instances = "${module.my_ec2.instance_id}"
}
