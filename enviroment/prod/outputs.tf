# VPC outputs

output "vpc_id" {
  description = "ID of the main VPC"
  value       = module.vpc_main.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc_main.public_subnet_ids
}

output "private_app_subnet_ids" {
  description = "IDs of the private subnets used by fargate profile"
  value       = module.vpc_main.private_1_subnet_ids
}

output "private_db_subnet_ids" {
  description = "IDs of the private subnets intended for the database"
  value       = module.vpc_main.private_2_subnet_ids
}


# Security group outputs

output "database_security_group_id" {
  description = "Security group ID intended for the database"
  value       = module.Security_Group.allow_db_traffic_id
}

#DB outputs

output "db_endpoint" {
  description = "endpoint of the database"
  value       = module.main_db.db_endpoint
}
