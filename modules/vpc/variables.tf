# VPC Module variables ###################

variable "project_name" {
  description = "The Project name"
  type        = string
}

variable "env" {
  description = "Module environment"
  type        = string
}

variable "tags" {
  description = "모든 리소스에 추가되는 tag 맵"
  type        = map
}

###### VPC OPTIONS ######

variable "vpc_cidr" {
  description = "VPC에 할당한 CIDR block"
  type        = string
}

variable "public_subnets" {
  description = "Public Subnet IP 리스트"
  type        = list
}

variable "private_subnets" {
  description = "Private Subnet IP 리스트"
  type        = list
}

variable "azs" {
  description = "사용할 availability zones 리스트"
  type        = list
}

variable "private_cidr" {
  description = "SSH 접속 허용할 개인 CIDR block"
  type        = string
}

variable "alb_cidr" {
  description = "ALB 접속 허용할 CIDR block"
  type        = string
}

###### SECURITY GROUP OPTIONS ######

variable "cache_port" {
  description = "CACHE PORT 번호"
}

variable "rds_port" {
  description = "RDS PORT 번호"
}
