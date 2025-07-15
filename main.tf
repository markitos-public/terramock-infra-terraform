resource "google_cloud_run_service" "frontend" {
  name     = "terramock-app-frontend"
  location = var.region
  project  = var.project_id

  template {
    spec {
      containers {
        image = var.cloud_run_image
        ports {
          container_port = 80
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

output "cloud_run_service_url" {
  description = "The URL on which the deployed Cloud Run service is available."
  value       = google_cloud_run_service.frontend.status[0].url
}

output "cloud_run_service_name" {
  description = "The name of the deployed Cloud Run service."
  value       = google_cloud_run_service.frontend.name
}

output "cloud_run_service_location" {
  description = "The region where the Cloud Run service is deployed."
  value       = google_cloud_run_service.frontend.location
}