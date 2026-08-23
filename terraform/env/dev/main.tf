module "iam_eks" {
  source = "../../modules/iam-eks"
  project_name = var.project_name
  env = var.env
}

module "iam" {
  source = "../../modules/iam"
  project_name = var.project_name
  env = var.env
  domain_name = var.domain_name
}

module "eks" {
  source = "../../modules/eks"
  project_name = var.project_name
  env = var.env
  eks_cluster_version = var.eks_cluster_version
  private_subnet_ids = var.private_subnet_ids
  cluster_role_arn = module.iam_eks.cluster_role_arn
  node_role_arn = module.iam_eks.node_role_arn
  external_dns_role_arn = module.iam.external_dns_role_arn
}

module "ecr" {
  source = "../../modules/ecr"
  project_name = var.project_name
  env = var.env
  repositories = var.repositories
}

module "acm" {
  source = "../../modules/acm"
  domain_name = var.domain_name
  zone_id = module.dns.zone_id
  sub_domains = var.sub_domains
}

module "dns" {
  source = "../../modules/dns"
  domain_name = var.domain_name
}