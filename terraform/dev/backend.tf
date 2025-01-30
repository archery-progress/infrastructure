terraform {
  backend "gcs" {
    bucket = "archery-terraform-state"
    prefix = "dev"
  }
}