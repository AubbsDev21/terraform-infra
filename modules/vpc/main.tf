#################  VPC  #################################
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(var.tags, {
    Name = var.vpc_name
    Enviroment = var.vpc_environment
  })
}

###############  IGW  ###################################
resource "aws_internet_gateway" "gw" {
  count = var.create_igw ? 1 : 0
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-igw"
  })
  depends_on = [ aws_vpc.main]
}



############## Seciurity Groups ###################

resource "aws_security_group" "security_group_vpc" {
  name = "${var.vpc_name}"
  description = "This is the security group for the vpc"
  vpc_id = aws_vpc.main.id

   tags = merge(var.tags, {
    Name = "${var.vpc_name}-sg"
  })
  
}

################ security group rules ingress ##########################
resource "aws_vpc_security_group_ingress_rule" "allow_tls" {
  for_each = var.subnet_public_cidr

  cidr_ipv4 = each.value.cidr_block
  from_port = 443
  to_port = 443
  ip_protocol = "tcp"
  security_group_id = aws_security_group.security_group_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  for_each = var.subnet_public_cidr

  cidr_ipv4 = each.value.cidr_block
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
  security_group_id = aws_security_group.security_group_vpc.id
  
}
########### Public Subnets ########################

resource "aws_subnet" "public" {
  for_each = var.subnet_public_cidr
  vpc_id = aws_vpc.main.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zones
  
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-public-subnet-${each.value.cidr_block}"
    Enviroment = var.vpc_environment
  })
  
}
######### Route Tables ###########################

resource "aws_route_table" "public_rt" {
  count = var.create_igw ? 1 : 0
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.cidr_block_route
    gateway_id = aws_internet_gateway.gw[count.index].id
  }

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-public-rt"
  })
}

################ Route Table Association ######################
resource "aws_route_table_association" "public" {
  for_each = var.subnet_public_cidr
  subnet_id = aws_subnet.public[each.key].id # Reference the subnet ID
  route_table_id = aws_route_table.public_rt[0].id

  depends_on = [aws_route_table.public_rt]
}

