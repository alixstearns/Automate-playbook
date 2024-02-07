
output "ssh_commands" {
  value = {
    for instance_name, instance in aws_instance.qa-server1 : instance_name => "ssh -i key_name.pem ec2-user@${instance.public_dns}"
  }
}

output "public-ips" {
  value = { for k, instance in aws_instance.qa-server1 : k => instance.public_ip

  }

}

output "private-ips" {
  value = { for k, instance in aws_instance.qa-server1 : k => instance.private_ip

  }

}