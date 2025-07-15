.PHONY: default clean help init

default: help

help:
	@echo "Available commands:"
	@echo "  clean     - Clean up Terraform state files and directories"

clean:
	rm -rf .terraform
	rm -f *.tfstate *.tfstate.backup .terraform.lock.hcl

init:
	@echo "Initializing Terraform..."
	terraform init
	
plan:
	@echo "Planning Terraform changes..."
	terraform plan

apply:
	@echo "Applying Terraform changes..."
	terraform apply -auto-approve

destroy:
	@echo "Destroying Terraform resources..."
	terraform destroy -auto-approve