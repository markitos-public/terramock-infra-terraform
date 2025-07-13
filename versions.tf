terraform {
  required_version = ">= 1.12.0, < 2.0.0"

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.43.0"
    }
  }  
}

provider "google" {
  credentials = file("${path.module}/../terramock-nogit-assets/key.json")
  project = var.project_id
  region  = var.region
  zone    = var.zone
}