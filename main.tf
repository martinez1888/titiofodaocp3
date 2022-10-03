#PROVIDER
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

#REGION
provider "aws" {
  region                  = var.aws_region
  shared_credentials_file = var.credentials_file
}

#MODULES
module "vpc" {
  source          = "./modules/vpc"

}

module "rds" {
  source            = "./modules/rds"
  sn_vpc10_priv_1a_id     = module.vpc.sn_vpc10_priv_1a_id
  sn_vpc10_priv_1c_id     = module.vpc.sn_vpc10_priv_1c_id
  sg_priv_id        = module.ec2.sg_priv_id 

}

module "ec2" {
  source           = "./modules/ec2"
  vpc10_id           = module.vpc.vpc10_id
  sn_vpc10_pub_1a_id     = module.vpc.sn_vpc10_pub_1a_id
  sn_vpc10_pub_1c_id     = module.vpc.sn_vpc10_pub_1c_id
  rds_endpoint     = module.rds.rds_endpoint

}
