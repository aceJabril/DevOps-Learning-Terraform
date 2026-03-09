# Terraform WordPress Deployment — AWS

This repo contains my first Terraform project where I provisioned a fully functional WordPress site on AWS entirely through code. No manual configuration was performed in the AWS console — everything from the security group to the EC2 instance and WordPress installation was managed exclusively through Terraform.

---

## Objective

Use Terraform to deploy a full WordPress stack on AWS, demonstrating how Infrastructure as Code (IaC) can be used to provision and configure real cloud infrastructure end-to-end.

---

## What I Built

An EC2 instance running WordPress, provisioned and configured automatically using Terraform and a shell script. The instance sits behind a security group that allows HTTP and SSH traffic, and WordPress is installed on first boot via a user data script that installs Apache, MariaDB, PHP and WordPress automatically — no manual intervention required.

---

## Architecture

- EC2 instance running WordPress
- Security Group allowing HTTP (port 80) and SSH (port 22)
- User data shell script to automate all dependencies and configuration on first boot
- All resources provisioned and managed exclusively via Terraform

---

## Project Structure
```
├── main.tf              # Security group and EC2 instance
├── provider.tf          # AWS provider and Terraform settings
├── variables.tf         # Input variables
├── outputs.tf           # Public IP and URL printed after deployment
├── scripts/
│   └── user_data.sh     # Installs Apache, MariaDB, PHP and WordPress
├── screenshots/
│   └── WordPress-live.png
└── README.md
```

---

## How to Deploy

### 1. Clone the Repo
```bash
git clone https://github.com/aceJabril/DevOps-Learning-Terraform.git
cd DevOps-Learning-Terraform
```

### 2. Configure AWS Credentials
```bash
aws configure
```

### 3. Initialise Terraform
```bash
terraform init
```

### 4. Review & Apply Infrastructure
```bash
terraform plan
terraform apply
```

### 5. Check the Live Site

After deployment you should see an output like:
```
wordpress_url = "http://ec2-xx-xx-xx-xx.eu-west-2.compute.amazonaws.com"
```

Open the URL in your browser. Give it 3-5 minutes for the user data script to finish installing WordPress.

---

## Outputs

After deployment Terraform prints three values to the terminal:

- `instance_id` — the EC2 instance ID
- `public_ip` — the server's public IP address
- `wordpress_url` — the full URL to access the WordPress site

---

## Key Concepts Demonstrated

- Infrastructure as Code using Terraform
- AWS EC2 and networking fundamentals
- Automated instance bootstrapping using user data
- Security group configuration for HTTP and SSH access
- Debugging and resolving real-world infrastructure issues

---

## Challenges & How I Solved Them

### Wrong AMI — Amazon Linux 2023 vs Amazon Linux 2
The AMI I used turned out to be Amazon Linux 2023, not Amazon Linux 2 as expected. This caused the user data script to silently fail because commands like `amazon-linux-extras` don't exist on Amazon Linux 2023. I identified this by SSHing into the instance and running the commands manually, which is when I saw `amazon-linux-extras: command not found`. The fix was switching to `dnf install -y mariadb105-server` which is the correct package manager and package name for Amazon Linux 2023.

### MariaDB Not Installing via User Data
Because of the AMI mismatch above, MariaDB never got installed during the automated boot process. The user data script ran but the MariaDB installation step failed silently, meaning the database was never set up. I resolved this by SSHing into the instance and running the installation and database setup commands manually, then updating the user data script with the correct commands for future deployments.

### Database Connection Error on WordPress
After getting the site to load, WordPress showed an "Error establishing a database connection" page. This was a direct result of MariaDB not being installed. Once I installed MariaDB, created the database, and set up the WordPress user with the correct privileges, the error was resolved. I also ran into an issue with the `!` character in the password causing bash to throw an `event not found` error — I solved this by logging directly into the MySQL prompt rather than passing commands inline through the shell.

### Accidentally Overwriting the tfstate File
While trying to create a `.gitignore` file I ran the wrong command which overwrote my `terraform.tfvars` file with the contents of `terraform.tfstate`. I recovered by copying the file back to `terraform.tfstate` and recreating `terraform.tfvars` with just the key name variable.

### Large .terraform Folder Pushed to GitHub
The `.terraform/` directory which contains the AWS provider binary at 822MB was accidentally committed before the `.gitignore` was properly set up. GitHub rejected the push because of the file size limit. I resolved this by removing the folder from git tracking using `git rm -r --cached .terraform/` and then purging it completely from the commit history using `git filter-branch` before force pushing.

---

## Tearing Down

To destroy all resources and avoid AWS charges:
```bash
terraform destroy
```

---

## Evidence

[screenshots](./screenshots)
