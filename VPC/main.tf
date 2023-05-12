#Creating VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr #User should provide own CIDR
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = merge( 
    var.tags,
    var.vpc_tags) #Merging the tags (which is optional and other one is applied to all)
}

#Creating internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags =  var.tags
  
}

#Creating subnets in public in 1a and 1b availbility zones
resource "aws_subnet" "public_subnet" {  #2subnets count
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = var.azs[count.index]
   count = length(var.public_subnet_cidr)
  tags = merge( 
    var.tags,
    var.public_subnet_tags,
    {"Name" = var.public_subnet_names[count.index]})        
}

#Creating Public route table
resource "aws_route_table" "Public" {
  vpc_id = aws_vpc.main.id
  tags = merge (var.tags, 
  var.public_route_tbl_tags,
  {"Name" = var.public_route_tbl_name})
  route {
    cidr_block = var.igw_cidr
    gateway_id = aws_internet_gateway.gw.id
  }
}

#Route table association for public route
resource "aws_route_table_association" "public-rta" {
  count = length(var.public_subnet_cidr)
  subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
  route_table_id = aws_route_table.Public.id
  
}

#Creating Private subnet
resource "aws_subnet" "private_subnet" {  #2subnets count
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone = var.azs[count.index]
   count = length(var.private_subnet_cidr)
  tags = merge( 
    var.tags,
    var.private_subnet_tags,
    {"Name" = var.private_subnet_names[count.index]})        
}

#create elastic ip & NAT for private subnet
resource "aws_eip" "this-eip" {}

resource "aws_nat_gateway" "this-Nat" {
  allocation_id = aws_eip.this-eip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = merge(var.tags)

  depends_on = [aws_internet_gateway.gw]
}

#create private route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = merge (var.tags, 
  var.private_route_tbl_tags,
  {"Name" = var.private_route_tbl_name})
  route {
    cidr_block = var.igw_cidr
    gateway_id = aws_nat_gateway.this-Nat.id
  }
}

#Route table association for private route
resource "aws_route_table_association" "private-rta" {
  count = length(var.private_subnet_cidr)
  subnet_id      = element(aws_subnet.private_subnet[*].id, count.index)
  route_table_id = aws_route_table.private.id
  
}

#Create DB subnet
resource "aws_subnet" "database_subnet" {  #2subnets count
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidr[count.index]
  availability_zone = var.azs[count.index]
   count = length(var.database_subnet_cidr)
  tags = merge( 
    var.tags,
    var.database_subnet_tags,
    {"Name" = var.database_subnet_names[count.index]})        
}

#create database route table
resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id
  tags = merge (var.tags, 
  var.database_route_tbl_tags,
  {"Name" = var.database_route_tbl_name})
  route {
    cidr_block = var.igw_cidr
    gateway_id = aws_nat_gateway.this-Nat.id
  }
}

#Route table association for database route
resource "aws_route_table_association" "database-rta" {
  count = length(var.database_subnet_cidr)
  subnet_id      = element(aws_subnet.database_subnet[*].id, count.index)
  route_table_id = aws_route_table.database.id
  
}

#Database subnet group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = lookup(var.tags, "Name")
  subnet_ids = aws_subnet.database_subnet[*].id 
  tags = var.tags
}