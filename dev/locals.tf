locals {
  prefix               = "${var.project_name}-${var.environment}-${var.team}"
  backend_path         = "${var.environment}/${local.prefix}-backend-bucket"
  service_account_path = "${path.module}/../../terramock-nogit-assets/terramock-terraform-role.json"
  network_tags         = [for tag in var.network_tags_for_web_hosts : "${local.prefix}-${tag}"]
}
