# VPC
resource "aws_vpc" "cluster_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = "${merge(var.tags, map("Name", format("%s", var.project_name)))}"
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = "${aws_vpc.cluster_vpc.id}"

  tags = "${merge(var.tags, map("Name", format("%s", var.project_name)))}"
}
