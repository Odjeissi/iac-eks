# VPC Variables

variable "region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "env" {
  description = "Environment name (e.g., dev, test, prod)"
  type        = string
}

variable "num_azs" {
  description = "Number of Availability Zones to use"
  type        = number
}

variable "enable_nat" {
  description = "Enable or disable NAT Gateway"
  type        = bool
}


# SG Variables

variable "db_sg_name" {
  description = "The name of the SG to be created"
  type        = string
}

variable "allow_db_traffic" {
  description = "Configuration for allowing db traffic"
  type = object({
    ip_protocol = string
    ports       = list(string)
  })
}

# DB Variables

variable "db_config" {
  description = "Configuration settings for the database instance."
  type = object({
    identifier                 = string
    db_name                    = string
    engine                     = string
    engine_version             = string
    instance_class             = string
    allocated_storage          = number
    skip_final_snapshot        = bool
    multi_az                   = bool
    storage_type               = string
    storage_encrypted          = bool
    auto_minor_version_upgrade = bool
  })
}

variable "db_username" {
  description = "Database user name."
  type        = string
}

variable "db_password" {
  description = "Database password."
  type        = string
  sensitive   = true
}

variable "db_subnet_group_name" {
  description = "Name of the DB subnet group to associate with the database instance."
  type        = string
}

# acm variables

variable "domain_name" {
  description = "The domain name to use for the deployment."
  type        = string
}

# ecr variables

variable "repo" {
  description = "value"
  type = object({
    name         = string
    force_delete = bool
  })
}

# EKS Variables

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the cluster"
  type        = string
}

variable "fargate_profile_name" {
  description = "Name of the Fargate profile"
  type        = string
}

variable "namespace" {
  description = "namespace to create"
  type        = list(string)
}

# SM

variable "credentials" {
  description = "Name and description of the secret."
  type = object({
    name        = string
    description = string
  })
}

variable "flask_app_Secret_key" {
  description = "Secret key for the Flask app."
  type        = string
  sensitive   = true
}

variable "external_name_EKS" {
  description = "External DNS name used by the EKS Kubernetes ExternalName Service."
  type        = string
}
