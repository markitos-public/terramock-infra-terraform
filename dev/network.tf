resource "google_compute_network" "vpc_network" {
  description             = "VPC network for the ${var.environment} environment managed by ${var.team} team"
  name                    = "${local.prefix}-vpc"
  auto_create_subnetworks = false
  project                 = var.project_id
}

resource "google_compute_subnetwork" "subnet" {
  for_each   = var.subnetworks
  depends_on = [google_compute_network.vpc_network]
  region     = var.region
  network    = google_compute_network.vpc_network.id
  project    = var.project_id

  name          = "${local.prefix}-subnet-${each.key}"
  description   = "Subnetwork for ${each.key} in the ${var.environment} environment managed by ${var.team} team"
  ip_cidr_range = each.value
}

resource "google_compute_firewall" "firewall_rules" {
  description = "Default firewall rules for the ${var.environment} environment managed by ${var.team} team"
  name        = "${local.prefix}-allow-ssh-http-https"
  network     = google_compute_network.vpc_network.id
  project     = var.project_id

  allow {
    protocol = "tcp"
    ports    = var.firewall_ports
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = local.network_tags
  direction     = "INGRESS"
  priority      = 1000
}
