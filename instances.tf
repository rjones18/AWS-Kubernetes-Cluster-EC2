resource "aws_instance" "master_server" {
  count                  = var.number_of_instances
  ami                    = data.aws_ami.ubuntu_image.id
  instance_type          = var.ec2_type
  subnet_id              = data.aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.my_public_app_sg.id]
  key_name               = var.my_keypair
  private_ip             = "172.31.86.101"
  iam_instance_profile   = aws_iam_instance_profile.example.name

  tags = {
    Name = "master_node_server"
  }
}

resource "aws_instance" "worker_server1" {
  count                  = var.number_of_instances
  ami                    = data.aws_ami.ubuntu_image.id
  instance_type          = var.ec2_type
  subnet_id              = data.aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.my_public_app_sg.id]
  key_name               = var.my_keypair
  private_ip             = "172.31.84.70"
  iam_instance_profile   = aws_iam_instance_profile.example.name

  tags = {
    Name = "worker_node_server_1"
  }
}

resource "aws_instance" "worker_server2" {
  count                  = var.number_of_instances
  ami                    = data.aws_ami.ubuntu_image.id
  instance_type          = var.ec2_type
  subnet_id              = data.aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.my_public_app_sg.id]
  key_name               = var.my_keypair
  private_ip             = "172.31.87.85"
  iam_instance_profile   = aws_iam_instance_profile.example.name

  tags = {
    Name = "worker_node_server_2"
  }
}