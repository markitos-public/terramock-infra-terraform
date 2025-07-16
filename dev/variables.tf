variable "region" {
  description = "The GCP region where the resources will be deployed."
  type        = string
  default     = "us-central1"
}

variable "subnetworks" {
  description = "List of subnetworks to create in the VPC."
  type        = map(string)
  default = {
    "us-central1-a" = "10.0.1.0/24"
    "us-central1-b" = "10.0.2.0/24"
    "us-central1-c" = "10.0.3.0/24"
  }
}

variable "network_tags_for_web_hosts" {
  description = "List of tags to apply to the web host network resources."
  type        = list(string)
  default     = ["web-host", "ssh-http-https"]
}

variable "firewall_ports" {
  description = "List of ports to allow in the firewall rules."
  type        = list(string)
  default     = ["22", "80", "443"]
}

variable "project_id" {
  description = "The GCP project ID where the resources will be created."
  type        = string
  default     = "terramock"
}

variable "project_name" {
  description = "The name of the GCP project to create or use."
  type        = string
  default     = "terramock"
}

variable "environment" {
  description = "The environment for which the resources are being created (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "team" {
  description = "The team responsible for the resources."
  type        = string
  default     = "devops"
}
