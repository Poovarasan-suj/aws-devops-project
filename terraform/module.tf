####--

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr = "10.0.0.0/16"
}

module "ec2" {
  source = "./modules/ec2"

  instance_type     = var.instance_type
  ami               = var.ami
  subnet_id         = module.vpc.subnet_id
  security_group_id = module.vpc.security_group_id
}