resource "google_project_service" "services" {
  for_each = toset([
    "compute.googleapis.com",
    "vpcaccess.googleapis.com",
  ])

  service = each.key

  project            = var.project_id
  disable_on_destroy = false
}

resource "google_compute_network" "vpc_network" {
  name    = "${var.vpc_name}-${var.environment}"
  project = var.project_id

  depends_on = [google_project_service.services]
}

resource "google_compute_subnetwork" "subnets" {
  for_each                 = { for subnet in var.subnets : subnet.name => subnet }
  name                     = "${each.value.name}-${var.environment}"
  ip_cidr_range            = each.value.ip_cidr_range
  region                   = var.region
  network                  = google_compute_network.vpc_network.self_link
  private_ip_google_access = "true"

  depends_on = [google_project_service.services]
}

resource "google_vpc_access_connector" "run_connector" {
  name           = "archery-run-connector-${var.environment}"
  region         = var.region
  network        = google_compute_network.vpc_network.self_link
  ip_cidr_range  = "10.8.0.0/28"
  min_throughput = 200
  max_throughput = 300

  depends_on = [google_project_service.services]
}