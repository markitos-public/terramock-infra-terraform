variable "cloud_run_image" {
  description = "The full name of the Docker image to deploy to Cloud Run (includes repo, name, and tag)"
  type        = string
}
variable "project_id" {
  description = "The ID of the Google Cloud project to use."
  type        = string

  validation {
    condition     = can(regex("^[a-z]([-a-z0-9]{0,61}[a-z0-9])?$", var.project_id))
    error_message = "The project ID must be a valid Google Cloud project ID."
  }
}

variable "region" {
  description = "The region to deploy resources in."
  type        = string

  validation {
    condition     = can(regex("^[a-z]([-a-z0-9]{0,61}[a-z0-9])?$", var.region))
    error_message = "The region must be a valid Google Cloud region."
  }
}
variable "zone" {
  description = "The zone to deploy resources in."
  type        = string

  validation {
    condition     = can(regex("^[a-z]([-a-z0-9]{0,61}[a-z0-9])?$", var.zone))
    error_message = "The zone must be a valid Google Cloud zone."
  }
}
