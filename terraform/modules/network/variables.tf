variable "project_id" {}

variable "region" {}
variable "vpc_name" {}
variable "environment" {}

variable "subnets" {
  description = "The list of subnets"
  type = list(object({
    name          = string
    ip_cidr_range = string
  }))
}