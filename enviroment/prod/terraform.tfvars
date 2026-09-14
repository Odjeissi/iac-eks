# VPC

region = "us-east-1"

cidr_block = "11.0.0.0/16"

env = "prod"

num_azs = 2


enable_nat = true

# SG

db_sg_name = "allow_postgress_traffic"


allow_db_traffic = {
  ip_protocol = "tcp"
  ports       = [5432]
}

# DB

db_config = {
  identifier                 = "postgres-db"
  db_name                    = "employees"
  engine                     = "postgres"
  engine_version             = "16.4"
  instance_class             = "db.t3.micro"
  allocated_storage          = 20
  skip_final_snapshot        = true
  multi_az                   = false
  storage_type               = "gp3"
  storage_encrypted          = false
  auto_minor_version_upgrade = false
}

db_subnet_group_name = "db-subnet-group"

# ecr

repo = {
  name         = "project/my-app"
  force_delete = true
}

# EKS

cluster_name = "demo-eks"

cluster_version = "1.35"

fargate_profile_name = "fargate-profile-1"

namespace = ["argocd", "kube-system", "dev", "stage", "prod"]

# ACM

domain_name = "thecloudguy.live"

# SM

credentials = {
  name        = "app_Secrets"
  description = "credentials for database"
}

# change this name to prod-external-service-db to due nameprefix when using argocd
external_name_EKS = "prod-external-service-db"


