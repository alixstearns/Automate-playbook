resource "aws_instance" "qa_server1" {
  ami           = data.aws_ami.ami1.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.instance_key.key_name
  user_data     = file("ansible.sh")  # This assumes ansible.sh contains the necessary commands to configure your instance
  tags = {
    Name = "qa-server1"
  }
}
/*provisioner "local-exec" {
    command = "ansible-playbook -i ${aws_instance.qa_server1.private_ip}, ansible.yaml"
*/

 # Here we are using the Null resource to copy our ssh key into the master server.
resource "null_resource" "copy_ssh_key" {
  depends_on = [aws_instance.qa_server1]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.ec2_key.private_key_pem
    host        = aws_instance.qa_server1.public_ip
  }

  provisioner "file" {
    source      = "key_name.pem"
    destination = "/home/ec2-user/key_name.pem"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ec2-user/key_name.pem",
    ]
  }
}

