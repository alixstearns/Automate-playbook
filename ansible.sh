#!/bin/bash

# Author: Alix S.
# Date: 01-13-2024

# Update the system and install necessary dependencies
sudo yum update -y
sudo ansible-galaxy collection install amazon.aws
sudo yum install -y epel-release
sudo amazon-linux-extras install epel -y
sudo yum install -y ansible
sudo amazon-linux-extras install python3.8 -y

# Install AWS CLI, boto3, and botocore
sudo pip3.8 install boto3 botocore awscli

# Install Java 18
sudo yum install java-18* -y
sudo yum install git -y

# Change terminal color (if necessary)
echo "PS1='\[\e[1;32m\]\u@\h \w$ \[\e[m\]'" >> /home/ec2-user/.bash_profile

# Clone the Git repository and run Ansible playbook
mkdir -p /home/ec2-user/qa-dev
git clone https://github.com/alixstearns/automate-playbook.git /home/ec2-user/qa-dev
cp -r automate-playbook/* /home/ec2-user/qa-dev
rm -rf automate-playbook

# Fetch the private IP address
ip_address=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

# Update the inventory file
sudo bash -c "echo 'qa_server1 ansible_host=$ip_address ansible_user=ec2-user' > inventory.yml"

# Run the playbook
ansible-playbook -i /home/ec2-user/qa-dev/inventory.yml /home/ec2-user/qa-dev/ansible.yml
