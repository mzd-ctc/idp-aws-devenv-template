terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${{ values.project_name }}-${{ values.environment_type }}-vpc"
    Environment = "${{ values.environment_type }}"
    Team        = "${{ values.team_name }}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${{ values.project_name }}-${{ values.environment_type }}-igw"
    Environment = "${{ values.environment_type }}"
    Team        = "${{ values.team_name }}"
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + 1)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  
  map_public_ip_on_launch = true

  tags = {
    Name        = "${{ values.project_name }}-${{ values.environment_type }}-public-${count.index + 1}"
    Environment = "${{ values.environment_type }}"
    Team        = "${{ values.team_name }}"
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + 10)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name        = "${{ values.project_name }}-${{ values.environment_type }}-private-${count.index + 1}"
    Environment = "${{ values.environment_type }}"
    Team        = "${{ values.team_name }}"
  }
}

# Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${{ values.project_name }}-${{ values.environment_type }}-public-rt"
    Environment = "${{ values.environment_type }}"
    Team        = "${{ values.team_name }}"
  }
}

# Route Table Association for Public Subnets
resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Data source for availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

# EKS Cluster (optional)
{% if values.create_eks == "true" %}
resource "aws_eks_cluster" "main" {
  name     = "${{ values.project_name }}-${{ values.environment_type }}"
  role_arn = aws_iam_role.eks_cluster.arn
  version  = "1.28"

  vpc_config {
    subnet_ids = concat(aws_subnet.public[*].id, aws_subnet.private[*].id)
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
  ]

  tags = {
    Environment = "${{ values.environment_type }}"
    Team        = "${{ values.team_name }}"
  }
}

resource "aws_iam_role" "eks_cluster" {
  name = "${{ values.project_name }}-${{ values.environment_type }}-eks-cluster"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}
{% endif %} 