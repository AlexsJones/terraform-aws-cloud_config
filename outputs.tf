output "aws_instance_docker" {
  value = "${aws_eip.docker-eu-west1a-eip.public_ip}"
}
