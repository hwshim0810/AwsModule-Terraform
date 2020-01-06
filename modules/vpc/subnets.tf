# VPC Module subnets  ###################

###### Subnets ######

# Public Subnet
resource "aws_subnet" "public" {
  count = "${length(var.public_subnets)}"

  vpc_id            = "${aws_vpc.cluster_vpc.id}"
  cidr_block        = "${var.public_subnets[count.index]}"
  availability_zone = "${var.azs[count.index]}"

  tags = "${merge(var.tags, map("Name", format("%s", "${var.project_name}_public")))}"
}

# Private Subnet
resource "aws_subnet" "private" {
  count = "${length(var.private_subnets)}"

  vpc_id            = "${aws_vpc.cluster_vpc.id}"
  cidr_block        = "${var.private_subnets[count.index]}"
  availability_zone = "${var.azs[count.index]}"

  tags = "${merge(var.tags, map("Name", format("%s", "${var.project_name}_private")))}"
}

###### Route tables ######

# Public table
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.cluster_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.this.id}"
  }

  tags = "${merge(var.tags, map("Name", format("%s-public", var.project_name)))}"
}

# Private table
resource "aws_route_table" "private" {
  count = "${length(var.azs)}"

  vpc_id = "${aws_vpc.cluster_vpc.id}"

  # TODO: NAT-Bastion instance 만들면 활성화
  #  route {
  #    cidr_block = "0.0.0.0/0"
  #    instance_id = "${aws_instance.bastion.id}"
  #  }

  tags = "${merge(var.tags, map("Name", format("%s-private-%s", var.project_name, var.azs[count.index])))}"
}

###### Associate subnet route table ######

resource "aws_route_table_association" "public" {
  count = "${length(var.public_subnets)}"

  subnet_id      = "${aws_subnet.public.*.id[count.index]}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private" {
  count = "${length(var.private_subnets)}"

  subnet_id      = "${aws_subnet.private.*.id[count.index]}"
  route_table_id = "${aws_route_table.private.*.id[count.index]}"
}
