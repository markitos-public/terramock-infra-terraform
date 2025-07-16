.PHONY: default clean help tf-clean tf-format tf-validate tf-init tf-plan tf-apply tf-destroy

default: help

help:
	@echo "Available commands:"
	@echo "  clean     - Clean up Terraform state files and directories"

tf-clean:
	rm -rf .terraform
	rm -f *.tfstate *.tfstate.backup .terraform.lock.hcl

tf-format:
	@echo "Formatting Terraform files..."
	terraform fmt -recursive
	@echo "Terraform files formatted."

tf-validate:
	@echo "Validating Terraform files..."
	terraform validate
	@echo "Terraform files validated."

tf-init:
	@echo "Initializing Terraform..."
	terraform init
	@echo "Terraform initialized."
	
tf-plan:
	@echo "Planning Terraform changes..."
	terraform plan
	@echo "Terraform plan completed."

tf-apply:
	@echo "Applying Terraform changes..."
	terraform apply -auto-approve
	@echo "Terraform changes applied."

tf-destroy:
	@echo "Destroying Terraform resources..."
	terraform destroy -auto-approve
	@echo "Terraform resources destroyed."