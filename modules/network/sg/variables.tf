variable "env" {
  description = "Environment name (e.g., dev, test, prod)"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created."
  type        = string
}

variable "allowed_db_cidr" {
  description = "The CIDR block of the VPC allowed to access the database."
  type        = string
}

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
