# modules/vpc/main.tf
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = "${var.name}-vpc"
    Env  = var.env
  }
}

resource "aws_subnet" "public" {
  count = length(var.azs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index)
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true
  tags = { Name = "${var.name}-public-${count.index}" }
}

resource "aws_subnet" "private" {
  count = length(var.azs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index + 10)
  availability_zone = var.azs[count.index]
  tags = { Name = "${var.name}-private-${count.index}" }
}

output "vpc_id" { value = aws_vpc.this.id }
output "public_subnet_ids" { value = aws_subnet.public[*].id }
output "private_subnet_ids" { value = aws_subnet.private[*].id }

