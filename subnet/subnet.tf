#Create the Public Subnet
resource "aws_subnet" "public" {
  vpc_id = "${var.vpc_id}"
  cidr_block = "${var.subnet_cidr}"

  tags = {
    Name = "Public Subnet"
  }
}

#Define the InternetGateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${var.vpc_id}"
  tags = {
        Name = "InternetGateway"
    }
}

# Define the route table
resource "aws_route_table" "public-rt" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "Public Route Table"
  }
}

# Assign the route table to the Subnet
resource "aws_route_table_association" "web-public-rt" {
  subnet_id = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public-rt.id}"
}

output "subnet_id" {
  value = "${aws_subnet.public.id}"
}
