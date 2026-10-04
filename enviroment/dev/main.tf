# VPC module

module "vpc_main" {
  source     = "../../modules/network/vpc"
  region     = var.region
  cidr_block = var.cidr_block
  env        = var.env
  num_azs    = var.num_azs
  enable_nat = var.enable_nat
}

# Security Group Module

module "Security_Group" {
  source           = "../../modules/network/sg"
  vpc_id           = module.vpc_main.vpc_id
  env              = var.env
  db_sg_name       = var.db_sg_name
  allow_db_traffic = var.allow_db_traffic
  allowed_db_cidr  = var.cidr_block
}

# DB Module

module "main_db" {
  source                     = "../../modules/rds"
  env                        = var.env
  db_config                  = var.db_config
  db_username                = var.db_username
  db_password                = var.db_password
  db_subnet_group_name       = var.db_subnet_group_name
  db_security_group_ids      = [module.Security_Group.allow_db_traffic_id]
  db_subnet_group_subnet_ids = [for subnet_ids in module.vpc_main.private_2_subnet_ids : subnet_ids]
}

# ECR Module

module "main_ecr" {
  source = "../../modules/ecr"
  repo   = var.repo
  env    = var.env
}

# ACM Module

module "acm_main" {
  source      = "../../modules/acm"
  domain_name = var.domain_name
  env         = var.env
}


# SM Module

module "main_sm" {
  source               = "../../modules/sm"
  credentials          = var.credentials
  db_username          = var.db_username
  db_password          = var.db_password
  external_name_EKS    = var.external_name_EKS
  db_name              = module.main_db.db_name
  flask_app_Secret_key = var.flask_app_Secret_key
  env                  = var.env
}

# EKS Module

module "main_eks" {
  source                      = "../../modules/eks"
  cluster_name                = var.cluster_name
  cluster_version             = var.cluster_version
  cluster_subnet_ids          = [for subnet_ids in module.vpc_main.private_1_subnet_ids : subnet_ids]
  env                         = var.env
  fargate_profile_name        = var.fargate_profile_name
  fargate_second_profile_name = var.fargate_second_profile_name
  fargate_profile_subnet_ids  = [for subnet_ids in module.vpc_main.private_1_subnet_ids : subnet_ids]
  namespace                   = var.namespace
  second_namespace            = var.second_namespace
}
