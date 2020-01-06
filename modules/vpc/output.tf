# VPC Module outputs  ###################

# VPC
output "vpc_id" {
  description = "VPC ID"
  value       = "${aws_vpc.cluster_vpc.id}"
}

# Subnets
output "public_subnets_ids" {
  description = "Public Subnet ID 리스트"
  value       = "${aws_subnet.public.*.id}"
}

output "private_subnets_ids" {
  description = "Private Subnet ID 리스트"
  value       = "${aws_subnet.private.*.id}"
}

# Security group
output "alb_sg_id" {
  value = "${aws_security_group.alb_sg.id}"
}

output "ecs_sg_id" {
  value = "${aws_security_group.ecs_sg.id}"
}

output "cache_sg_id" {
  value = "${aws_security_group.cache_sg.id}"
}

output "rds_sg_id" {
  value = "${aws_security_group.rds_sg.id}"
}
