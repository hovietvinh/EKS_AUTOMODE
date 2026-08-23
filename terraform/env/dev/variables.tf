variable "project_name" {
  type = string
}

variable "region" {
  type = string
}

variable "env" {
  type = string
}

variable "eks_cluster_version" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "repositories" {
  type = set(string)
}

variable "domain_name" {
  type        = string
}

variable "sub_domains" {
  type        = list(string)
}