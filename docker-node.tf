resource "aws_instance" "docker" {
  connection {
    user     = "ec2-user"
    key_file = "${aws_key_pair.terraform.key_file}"
  }

  availability_zone = "${lookup(var.availability_zone,"primary")}"
  ami               = "${lookup(var.amazon_amis,"${var.region}")}"
  instance_type     = "t2.micro"
  user_data         = "${data.template_file.user_data.rendered}"
  subnet_id         = "${aws_subnet.public-One.id}"
  security_groups   = ["${aws_security_group.default.id}"]
  key_name          = "${aws_key_pair.terraform.id}"

  tags {
    Name = "Docker"
  }
}

data "template_file" "user_data" {
  template = "${file("cloud-config.yml")}"
}

resource "aws_eip" "docker-eu-west1a-eip" {
  instance = "${aws_instance.docker.id}"
  vpc      = true
}
