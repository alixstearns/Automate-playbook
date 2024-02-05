resource "aws_instance" "qa_server1" {
  ami           = data.aws_ami.ami1.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.instance_key.key_name
  user_data     = file("ansible.sh")
  tags = {
    Name = "qa-server1"
  }
}

# Run Ansible playbook
 #   command = ansible-playbook -i localhost, /c/Users/ehong/week15-Jenkins/devops-lab/DEVOPS-UTRAINS/ansible-jenkins/ansible.yml

