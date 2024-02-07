resource "aws_instance" "qa_server1" {
  ami           = data.aws_ami.ami1.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.instance_key.key_name
  user_data     = file("ansible.sh")  # This assumes ansible.sh contains the necessary commands to configure your instance
  tags = {
    Name = "qa-server1"
  }

provisioner "local-exec" {
    command = "ansible-playbook -i ${aws_instance.qa_server1.private_ip}, ansible.yaml"


  /*provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y ansible"
    ]
  }*/

}
# Run Ansible playbook
 # command = ansible-playbook -i localhost, "/c/Users/ehong/week15-Jenkins/devops-lab/DEVOPS-UTRAINS/ansible-jenkins/ansible.yml"

}
