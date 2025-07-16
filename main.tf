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


resource "google_cloud_run_service" "default" {
  name     = "terramock-app-frontend"
  location = var.region
  project  = var.project_id

  template {
    spec {
      containers {
        image = var.instance_image
        ports {
          container_port = 8080
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.default.location
  project     = google_cloud_run_service.default.project
  service     = google_cloud_run_service.default.name
  policy_data = data.google_iam_policy.noauth.policy_data
}

