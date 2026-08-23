variable "project_name" {
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

variable "cluster_role_arn" {
  type = string
}

variable "node_role_arn" {
  type = string
}

variable "external_dns_role_arn" {
  type = string
}