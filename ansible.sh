#!/bin/bash

# Author: Alix S.
# Date: 01-13-2024

# Update the system and install necessary dependencies
sudo yum update -y
sudo yum install -y epel-release
sudo yum install -y ansible python38 git

# Install AWS CLI, boto3, and botocore
sudo pip3.8 install boto3 botocore awscli

# Install Java 18
sudo yum install java-18* -y

# Change terminal color (if necessary)
# echo "PS1='\[\e[1;32m\]\u@\h \w$ \[\e[m\]'" >> /home/ec2-user/.bash_profile

# Clone the Git repository and run Ansible playbook
mkdir -p /home/ec2-user/qa-dev
git clone https://github.com/alixstearns/automate-playbook.git /home/ec2-user/qa-dev
ansible-playbook /home/ec2-user/qa-dev/ansible.yml

# Download the ec2.py script and ec2.ini configuration file for dynamic inventory
wget https://raw.githubusercontent.com/ansible/ansible/stable-2.9/contrib/inventory/ec2.py
wget https://raw.githubusercontent.com/ansible/ansible/stable-2.9/contrib/inventory/ec2.ini

# Make the ec2.py script executable
chmod +x ec2.py

# Run the ec2.py script to generate the dynamic inventory
inventory_file="/home/ec2-user/qa-dev/inventory.yml"
./ec2.py --list > $inventory_file

# Run your Ansible playbook using the generated dynamic inventory
ansible-playbook -i $inventory_file /home/ec2-user/qa-dev/ansible.yml

# Clean up - remove the downloaded files
rm -f ec2.py ec2.ini

exit 0
