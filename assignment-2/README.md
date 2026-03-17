# Terraform Assignment 2 – EC2 Deployment with Cloud-Init

Just finished CoderCo's 2nd Terraform assignment and it's really helped solidify my understanding of Terraform basics.

## What I Did
Used Terraform to deploy an EC2 instance on AWS that automatically installs and starts Apache on boot using cloud-init. No manual steps required.

## What is Cloud-Init?
Cloud-init is a script that runs when an EC2 instance boots for the first time. In this project it installs and starts Apache automatically.

## How it Works
1. Terraform creates the EC2 instance and passes the cloud-init file via `user_data`
2. On boot, cloud-init installs and starts Apache
3. Instance is ready with no manual configuration

## Files
- `main.tf` - EC2 instance and security group
- `variables.tf` - variable declarations
- `terraform.tfvars` - variable values
- `outputs.tf` - outputs the public IP
- `provider.tf` - AWS provider config
- `cloud-init.yaml` - installs and starts Apache on boot

## How to Deploy
```bash
terraform init
terraform plan
terraform apply
```

Visit `http://YOUR_IP` in your browser — if you see the Apache welcome page, it worked.

## Proof it Works
<img width="1440" height="860" alt="working-apache-website" src="https://github.com/user-attachments/assets/85e1c430-2557-4703-86d4-fe6637c48bb1" />
