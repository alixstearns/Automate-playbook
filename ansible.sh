#!/bin/bash

#### Autor : Alix S.
#### Date : 01-13-2024

sudo yum update -y

ansible-galaxy collection install amazon.aws
# # install ansible with python3
sudo amazon-linux-extras install python3.8 -y

# Install required dependencies
sudo yum install -y epel-release
sudo amazon-linux-extras install epel -y

# Install Ansible
sudo yum install -y ansible

# #install boto3 and botocore
sudo pip3.8 install boto3 botocore awscli
#change terminal color
echo "PS1='\e[1;32m\u@\h \w$ \e[m'" >> /home/ec2-user/.bash_profile
# Install Java 18
sudo yum install java-18* -y

sudo yum install git -y
mkdir -p /home/ec2-user/qa-dev
git clone https://github.com/alixstearns/week17-ansible-code.git
cp -r /week17-ansible-code/*  /home/ec2-user/qa-dec
rm -rf week17-ansible-code



exit 0
#ansible-playbook -i localhost, "/c/Users/ehong/week15-Jenkins/devops-lab/DEVOPS-UTRAINS/ansible-jenkins/ansible.yml"