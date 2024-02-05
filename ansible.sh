#!/bin/bash

#### Autor : Alix S.
#### Date : 01-13-2024

sudo yum update -y

# Install required dependencies
sudo yum install -y epel-release

# Install Ansible
sudo yum install -y ansible

ansible-playbook -i localhost, "/c/Users/ehong/week15-Jenkins/devops-lab/DEVOPS-UTRAINS/ansible-jenkins/ansible.yml"

