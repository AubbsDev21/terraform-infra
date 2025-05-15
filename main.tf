module "vpc" {
  source = "./modules/vpc"


  vpc_name   = var.vpc_name
  cidr_block = var.cidr_block


  subnet_public_cidr = var.subnet_public_cidr
  ###subnet_private_cidr = var.subnet_private_cidr

  cidr_block_route = var.cidr_block_route
  create_igw       = var.create_igw



}

module "ec2" {
  source = "./modules/ec2"

  ec2_name  = var.ec2_name
  ec2_count = var.ec2_count

  instance_type = var.instance_type
  ami_id        = var.ami_id
  environment   = var.environment

  subnet_id = module.vpc.public_subnet_id_output[*]

  depends_on = [module.vpc]
}

terraform {
  backend "s3" {
    bucket  = "my-terraform-state-bucket-75445365"
    key     = "tfstatefile"
    region  = "us-east-1"
    profile = "default"

    use_lockfile = true
  }
}