resource "aws_iam_role" "apprunner" {
  name = "apprunner-service-2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = ["tasks.apprunner.amazonaws.com", "build.apprunner.amazonaws.com"],
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "apprunner-ecr-policy" {
  role       = aws_iam_role.apprunner.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_apprunner_service" "example" {
  service_name = "python_translator_app"

  // observability_configuration {
  //   observability_configuration_arn = aws_apprunner_observability_configuration.example.arn
  //   observability_enabled           = true
  // }

  source_configuration {
    image_repository {
      image_configuration {
        port = "8080"
      }
      image_identifier      = "614768946157.dkr.ecr.us-east-1.amazonaws.com/translator-app:latest"
      image_repository_type = "ECR"
    }
    auto_deployments_enabled = true
    authentication_configuration {
      access_role_arn = aws_iam_role.apprunner.arn
    }
  }

  tags = {
    Name = "python-translator-apprunner-service"
  }

  instance_configuration {
    instance_role_arn = "arn:aws:iam::614768946157:role/apprunner-role"
  }
}



