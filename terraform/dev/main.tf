module "network" {
  source = "../modules/network"

  environment = var.environment
  project_id  = var.project_id
  vpc_name    = "archery-vpc"
  region      = var.region
  subnets = [
    {
      name          = "archery-subnet-1"
      ip_cidr_range = "10.10.10.0/24"
    }
  ]
}

module "postgres" {
  source = "../modules/postgres"

  region       = var.region
  project_id   = var.project_id
  project_name = "archery"
  vpc_id       = module.network.vpc_id
  environment  = var.environment
}