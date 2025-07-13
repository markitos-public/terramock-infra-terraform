resource "google_compute_network" "vpc_network" {
  project                 = var.project_id
  name                    = "vpc-network"
  description             = "VPC network for TerraMock infrastructure"
  auto_create_subnetworks = true
  mtu                     = 1460
}
