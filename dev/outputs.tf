output "prefix" {
  description = "The prefix used for naming resources in the dev environment."
  value       = local.prefix
}

output "backend_path" {
  description = "The path for the backend bucket in the dev environment."
  value       = local.backend_path
}