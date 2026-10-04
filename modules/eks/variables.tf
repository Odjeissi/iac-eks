variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the cluster"
  type        = string
}

variable "cluster_subnet_ids" {
  description = "Subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "env" {
  description = "Environment name, such as dev, test, or prod"
  type        = string
}

variable "fargate_profile_name" {
  description = "Name of the Fargate profile"
  type        = string
}

variable "fargate_second_profile_name" {
  description = "Name of the Fargate profile"
  type        = string
}


variable "fargate_profile_subnet_ids" {
  description = "Subnet IDs for the Fargate profile"
  type        = list(string)
}

variable "namespace" {
  description = "namespace to create"
  type        = list(string)
}

variable "second_namespace" {
  description = "namespace to create"
  type        = list(string)
}
