resource "aws_iam_role" "example" {
  name = "example_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "ecr_policy" {
  name        = "ecr_policy"
  description = "A policy that allows access to a specific ECR repo"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ],
        Resource = "arn:aws:ecr:us-east-1:614768946157:repository/translator-app"
      },
      {
        Effect   = "Allow",
        Action   = "ecr:GetAuthorizationToken",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lb_attach" {
  role       = aws_iam_role.example.name
  policy_arn = aws_iam_policy.lb_policy.arn
}

resource "aws_iam_role_policy_attachment" "ec2_ecr_attach" {
  role       = aws_iam_role.example.name
  policy_arn = aws_iam_policy.ecr_policy.arn
}

resource "aws_iam_instance_profile" "example" {
  name = "traslator_profile"
  role = aws_iam_role.example.name
}

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