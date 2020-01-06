# VPC Module security groups  ###################

# ECS Security Group
resource "aws_security_group" "ecs_sg" {
  name        = "${var.project_name}-${var.env}-ecs-sg"
  vpc_id      = "${aws_vpc.cluster_vpc.id}"
  description = "${var.project_name} ECS Instance security group"
  depends_on  = ["aws_vpc.cluster_vpc"]

  # TODO: Private IP 대신 Bastion 으로 교체
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.private_cidr}"]
  }

  ingress {
    from_port = 32768
    to_port   = 65535
    protocol  = "tcp"
    security_groups = [
      "${aws_security_group.alb_sg.id}",
    ]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(var.tags, map("Name", format("%s", "${var.project_name}_ecs_sg")))}"
}

# ALB Security Group
resource "aws_security_group" "alb_sg" {
  name        = "${var.project_name}-${var.env}-alb-sg"
  vpc_id      = "${aws_vpc.cluster_vpc.id}"
  description = "ALB Security Group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.alb_cidr}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.alb_cidr}"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(var.tags, map("Name", format("%s", "${var.project_name}_alb_sg")))}"
}

# Cache Security Group
resource "aws_security_group" "cache_sg" {
  name   = "${var.project_name}-${var.env}-cache-sg"
  vpc_id = "${aws_vpc.cluster_vpc.id}"

  ingress {
    from_port = "${var.cache_port}"
    to_port   = "${var.cache_port}"
    protocol  = "tcp"
    security_groups = [
      "${aws_security_group.ecs_sg.id}"
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(var.tags, map("Name", format("%s", "${var.project_name}_cache_sg")))}"
}

# RDS Security Group
resource "aws_security_group" "rds_sg" {
  name   = "${var.project_name}-${var.env}-rds-sg"
  vpc_id = "${aws_vpc.cluster_vpc.id}"

  ingress {
    from_port = "${var.rds_port}"
    to_port   = "${var.rds_port}"
    protocol  = "tcp"
    # TODO: Bastion SG 추가
    security_groups = [
      "${aws_security_group.ecs_sg.id}",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(var.tags, map("Name", format("%s", "${var.project_name}_rds_sg")))}"
}
