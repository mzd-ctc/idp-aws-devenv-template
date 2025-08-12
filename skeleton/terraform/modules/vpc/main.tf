# VPC 모듈 - 네트워크 인프라 구성
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# VPC 생성
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.environment_name}-vpc"
    Environment = var.environment_type
    Team        = var.team_name
    ManagedBy   = "terraform"
  }
}

# 인터넷 게이트웨이
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.environment_name}-igw"
    Environment = var.environment_type
    Team        = var.team_name
  }
}

# Public 서브넷들
resource "aws_subnet" "public" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.environment_name}-public-${var.availability_zones[count.index]}"
    Environment = var.environment_type
    Team        = var.team_name
    Type        = "public"
  }
}

# Private 서브넷들
resource "aws_subnet" "private" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + length(var.availability_zones))
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "${var.environment_name}-private-${var.availability_zones[count.index]}"
    Environment = var.environment_type
    Team        = var.team_name
    Type        = "private"
  }
}

# NAT 게이트웨이용 Elastic IP
resource "aws_eip" "nat" {
  count = var.enable_nat_gateway ? 1 : 0
  domain = "vpc"

  tags = {
    Name        = "${var.environment_name}-nat-eip"
    Environment = var.environment_type
    Team        = var.team_name
  }
}

# NAT 게이트웨이
resource "aws_nat_gateway" "main" {
  count         = var.enable_nat_gateway ? 1 : 0
  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name        = "${var.environment_name}-nat"
    Environment = var.environment_type
    Team        = var.team_name
  }

  depends_on = [aws_internet_gateway.main]
}

# Public 라우팅 테이블
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${var.environment_name}-public-rt"
    Environment = var.environment_type
    Team        = var.team_name
  }
}

# Private 라우팅 테이블
resource "aws_route_table" "private" {
  count  = var.enable_nat_gateway ? 1 : 0
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[0].id
  }

  tags = {
    Name        = "${var.environment_name}-private-rt"
    Environment = var.environment_type
    Team        = var.team_name
  }
}

# Public 서브넷 라우팅 테이블 연결
resource "aws_route_table_association" "public" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Private 서브넷 라우팅 테이블 연결
resource "aws_route_table_association" "private" {
  count          = var.enable_nat_gateway ? length(var.availability_zones) : 0
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[0].id
} 