resource "google_cloud_run_service" "default" {
  name     = "terramock-app-frontend"
  location = var.region
  project  = var.project_id

  template {
    spec {
      containers {
        image = var.image_name
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
  service     = google_cloud_run_service.default.name
  location    = google_cloud_run_service.default.location
  project     = google_cloud_run_service.default.project
  policy_data = data.google_iam_policy.noauth.policy_data
}



