resource "google_compute_network" "default" {
  name                    = "default"
  auto_create_subnetworks = true
  project                 = var.project_id
}

resource "google_compute_firewall" "allow-http-80" {
  name    = "allow-http-80"
  project = var.project_id
  network = google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_tags = ["web-server"]
}

resource "google_compute_firewall" "allow-http-8080" {
  name    = "allow-http-8080"
  project = var.project_id
  network = google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_tags = ["web-server"]
}

resource "google_compute_firewall" "allow-ssh-22" {
  name    = "allow-ssh-22"
  project = var.project_id
  network = google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_tags = ["web-server"]
}
