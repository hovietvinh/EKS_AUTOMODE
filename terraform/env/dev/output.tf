output "eks_cluster_name" {
  value = module.eks.eks_cluster_name
}


output "public_subnet_ids" {
  value = var.public_subnet_ids
}

output "certificate_arn" {
  value = module.acm.certificate_arn
}
output "common_zone_nameservers" {
  value = module.dns.common_zone_nameservers
}
