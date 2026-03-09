{
  "version": 4,
  "terraform_version": "1.14.6",
  "serial": 3,
  "lineage": "8f6dc672-d562-d51b-bf54-09f993cb3e50",
  "outputs": {
    "instance_id": {
      "value": "i-0a81a639a89551891",
      "type": "string"
    },
    "public_ip": {
      "value": "13.41.191.98",
      "type": "string"
    },
    "wordpress_url": {
      "value": "http://ec2-13-41-191-98.eu-west-2.compute.amazonaws.com",
      "type": "string"
    }
  },
  "resources": [
    {
      "mode": "managed",
      "type": "aws_instance",
      "name": "wordpress",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 2,
          "attributes": {
            "ami": "ami-087c9ba923d9765d8",
            "arn": "arn:aws:ec2:eu-west-2:906478107774:instance/i-0a81a639a89551891",
            "associate_public_ip_address": true,
            "availability_zone": "eu-west-2b",
            "capacity_reservation_specification": [
              {
                "capacity_reservation_preference": "open",
                "capacity_reservation_target": []
              }
            ],
            "cpu_options": [
              {
                "amd_sev_snp": "",
                "core_count": 1,
                "nested_virtualization": "",
                "threads_per_core": 2
              }
            ],
            "credit_specification": [
              {
                "cpu_credits": "unlimited"
              }
            ],
            "disable_api_stop": false,
            "disable_api_termination": false,
            "ebs_block_device": [],
            "ebs_optimized": false,
            "enable_primary_ipv6": null,
            "enclave_options": [
              {
                "enabled": false
              }
            ],
            "ephemeral_block_device": [],
            "force_destroy": false,
            "get_password_data": false,
            "hibernation": false,
            "host_id": "",
            "host_resource_group_arn": null,
            "iam_instance_profile": "",
            "id": "i-0a81a639a89551891",
            "instance_initiated_shutdown_behavior": "stop",
            "instance_lifecycle": "",
            "instance_market_options": [],
            "instance_state": "running",
            "instance_type": "t3.micro",
            "ipv6_address_count": 0,
            "ipv6_addresses": [],
            "key_name": "jabz.uk",
            "launch_template": [],
            "maintenance_options": [
              {
                "auto_recovery": "default"
              }
            ],
            "metadata_options": [
              {
                "http_endpoint": "enabled",
                "http_protocol_ipv6": "disabled",
                "http_put_response_hop_limit": 2,
                "http_tokens": "required",
                "instance_metadata_tags": "disabled"
              }
            ],
            "monitoring": false,
            "network_interface": [],
            "outpost_arn": "",
            "password_data": "",
            "placement_group": "",
            "placement_group_id": "",
            "placement_partition_number": 0,
            "primary_network_interface": [
              {
                "delete_on_termination": true,
                "network_interface_id": "eni-086d26ece75b81fb4"
              }
            ],
            "primary_network_interface_id": "eni-086d26ece75b81fb4",
            "private_dns": "ip-172-31-37-93.eu-west-2.compute.internal",
            "private_dns_name_options": [
              {
                "enable_resource_name_dns_a_record": false,
                "enable_resource_name_dns_aaaa_record": false,
                "hostname_type": "ip-name"
              }
            ],
            "private_ip": "172.31.37.93",
            "public_dns": "ec2-13-41-191-98.eu-west-2.compute.amazonaws.com",
            "public_ip": "13.41.191.98",
            "region": "eu-west-2",
            "root_block_device": [
              {
                "delete_on_termination": true,
                "device_name": "/dev/xvda",
                "encrypted": false,
                "iops": 3000,
                "kms_key_id": "",
                "tags": {},
                "tags_all": {},
                "throughput": 125,
                "volume_id": "vol-0265954c48ddf6080",
                "volume_size": 8,
                "volume_type": "gp3"
              }
            ],
            "secondary_network_interface": [],
            "secondary_private_ips": [],
            "security_groups": [
              "wordpress-sg"
            ],
            "source_dest_check": true,
            "spot_instance_request_id": "",
            "subnet_id": "subnet-026dcecf2b77e9422",
            "tags": {
              "Name": "WordPress-Server"
            },
            "tags_all": {
              "Name": "WordPress-Server"
            },
            "tenancy": "default",
            "timeouts": null,
            "user_data": "#!/bin/bash\nyum update -y\n\n# Install Apache, PHP and MySQL client\nyum install -y httpd php php-mysqlnd php-fpm php-json wget\n\n# Install and start MariaDB\namazon-linux-extras install -y mariadb10.5\nsystemctl start mariadb\nsystemctl enable mariadb\n\n# Create WordPress database and user\nmysql -e \"CREATE DATABASE wordpress;\"\nmysql -e \"CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'WPpass123!';\"\nmysql -e \"GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';\"\nmysql -e \"FLUSH PRIVILEGES;\"\n\n# Download and install WordPress\ncd /var/www/html\nwget https://wordpress.org/latest.tar.gz\ntar -xzf latest.tar.gz\ncp -r wordpress/* .\nrm -rf wordpress latest.tar.gz\n\n# Configure database connection\ncp wp-config-sample.php wp-config.php\nsed -i \"s/database_name_here/wordpress/\" wp-config.php\nsed -i \"s/username_here/wpuser/\" wp-config.php\nsed -i \"s/password_here/WPpass123!/\" wp-config.php\n\n# Fix permissions and start Apache\nchown -R apache:apache /var/www/html\nchmod -R 755 /var/www/html\nsystemctl start httpd\nsystemctl enable httpd",
            "user_data_base64": null,
            "user_data_replace_on_change": false,
            "volume_tags": null,
            "vpc_security_group_ids": [
              "sg-0abc3456618bd32b1"
            ]
          },
          "sensitive_attributes": [],
          "identity_schema_version": 0,
          "identity": {
            "account_id": "906478107774",
            "id": "i-0a81a639a89551891",
            "region": "eu-west-2"
          },
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6MTIwMDAwMDAwMDAwMCwicmVhZCI6OTAwMDAwMDAwMDAwLCJ1cGRhdGUiOjYwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMiJ9",
          "dependencies": [
            "aws_security_group.wordpress_sg"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_security_group",
      "name": "wordpress_sg",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "arn": "arn:aws:ec2:eu-west-2:906478107774:security-group/sg-0abc3456618bd32b1",
            "description": "Allow HTTP and SSH",
            "egress": [
              {
                "cidr_blocks": [
                  "0.0.0.0/0"
                ],
                "description": "",
                "from_port": 0,
                "ipv6_cidr_blocks": [],
                "prefix_list_ids": [],
                "protocol": "-1",
                "security_groups": [],
                "self": false,
                "to_port": 0
              }
            ],
            "id": "sg-0abc3456618bd32b1",
            "ingress": [
              {
                "cidr_blocks": [
                  "0.0.0.0/0"
                ],
                "description": "HTTP",
                "from_port": 80,
                "ipv6_cidr_blocks": [],
                "prefix_list_ids": [],
                "protocol": "tcp",
                "security_groups": [],
                "self": false,
                "to_port": 80
              },
              {
                "cidr_blocks": [
                  "0.0.0.0/0"
                ],
                "description": "SSH",
                "from_port": 22,
                "ipv6_cidr_blocks": [],
                "prefix_list_ids": [],
                "protocol": "tcp",
                "security_groups": [],
                "self": false,
                "to_port": 22
              }
            ],
            "name": "wordpress-sg",
            "name_prefix": "",
            "owner_id": "906478107774",
            "region": "eu-west-2",
            "revoke_rules_on_delete": false,
            "tags": {
              "Name": "wordpress-sg"
            },
            "tags_all": {
              "Name": "wordpress-sg"
            },
            "timeouts": null,
            "vpc_id": "vpc-06c3b1e24145c909c"
          },
          "sensitive_attributes": [],
          "identity_schema_version": 0,
          "identity": {
            "account_id": "906478107774",
            "id": "sg-0abc3456618bd32b1",
            "region": "eu-west-2"
          },
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6OTAwMDAwMDAwMDAwfSwic2NoZW1hX3ZlcnNpb24iOiIxIn0="
        }
      ]
    }
  ],
  "check_results": null
}
