# Terraform WordPress Deployment — AWS

My first proper Terraform project. The goal was to get a WordPress site running on AWS without touching the console — everything provisioned through code.

---

## What I Built

A WordPress site running on an EC2 instance, with a security group controlling traffic and a shell script that handles all the installation automatically on first boot. Once you run `terraform apply` the infrastructure is created and WordPress installs itself — no SSH required.

---

## Architecture

- EC2 instance running WordPress
- Security group allowing HTTP (port 80) and SSH (port 22)
- User data script that installs Apache, MariaDB, PHP and WordPress on boot
- All infrastructure managed through Terraform

---

## Project Structure
```
├── main.tf              # Security group and EC2 instance
├── provider.tf          # AWS provider configuration
├── variables.tf         # Input variables
├── outputs.tf           # Prints IP and URL after deployment
├── scripts/
│   └── user_data.sh     # Installs everything on the EC2 instance
├── screenshots/
│   └── WordPress-Live.png
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

### 4. Review & Apply
```bash
terraform plan
terraform apply
```

### 5. Check the Live Site

After deployment you should see something like:
```
wordpress_url = "http://ec2-xx-xx-xx-xx.eu-west-2.compute.amazonaws.com"
```

Paste that into your browser. Give it a few minutes — the script is still running in the background installing everything.

---

## Outputs

- `instance_id` — EC2 instance ID
- `public_ip` — public IP of the server
- `wordpress_url` — the URL to access the site

---

## What I Struggled With

### Amazon Linux 2023 vs Amazon Linux 2
The AMI I picked turned out to be Amazon Linux 2023, not Amazon Linux 2. This meant the user data script failed silently on boot because `amazon-linux-extras` doesn't exist on AL2023. I only figured this out by SSHing in and running the commands manually. Switched to `dnf install -y mariadb105-server` and it worked.

### MariaDB Not Installing
A knock-on from the AMI issue — because `amazon-linux-extras` failed, MariaDB never got installed and the database was never created. Had to SSH in and set it all up manually, then update the script so it wouldn't happen again on a fresh deployment.

### Database Connection Error
Once the site loaded I got "Error establishing a database connection". Fixed once MariaDB was properly installed and the database and user were created. Hit another issue where the `!` in the password was breaking bash — solved it by going into the MySQL prompt directly instead of running commands inline.

### Overwriting the tfstate File
Ran the wrong command trying to create a `.gitignore` and accidentally overwrote `terraform.tfvars` with the contents of `terraform.tfstate`. Recovered by copying the file back and recreating `terraform.tfvars` from scratch.

### Pushing .terraform to GitHub
The `.terraform/` folder got committed before the `.gitignore` was set up properly. It contains the AWS provider binary which is 822MB — GitHub rejected the push. Had to remove it from git tracking, purge it from the commit history with `git filter-branch` and force push.

---

## Tear Down
```bash
terraform destroy
```

---

## Evidence

[screenshots](./screenshots)
