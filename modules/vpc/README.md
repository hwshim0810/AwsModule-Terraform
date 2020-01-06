# VPC Module

### 생성되는 Resource

- VPC
- Internet Gateway(IG)
- Public / Private subnet 각 1개
- Subnet, IG를 연결하는 Route table, Route table association
- Security group
  - Use for ECS
  - Use for ALB
  - Use for RDS
  - Use for Elastic cache


### Input variables

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| project_name | 자원명에 포함될 프로젝트명 | string | - | true |
| env | 자원명에 포함될 환경명 | string | - | true |
| tags | 모든 리소스에 추가되는 tag 맵 | map | - | true |
| vpc_cidr | VPC에 할당한 CIDR block | string | - | true |
| private_subnets | Private Subnet IP 리스트 | list | - | true |
| public_subnets | Public Subnet IP 리스트 | list | - | true |
| azs | 사용할 availability zones 리스트 | list | - | true |
| private_cidr | SSH 접속 허용할 개인 CIDR block | string | - | true |
| alb_cidr | ALB 접속 허용할 CIDR block | string | - | true |
| cache_port | CACHE PORT 번호 | string | - | true |
| rds_port | RDS PORT 번호 | string | - | true |

### Output

| Name | Description |
|------|-------------|
| vpc_id | VPC ID |
| public_subnets_ids | Public Subnet ID 리스트 |
| private_subnets_ids | Private Subnet ID 리스트 |
| alb_sg_id | VPC ALB Security Group ID |
| ecs_sg_id | VPC ECS Security Group ID |
| cache_sg_id | VPC Elastic Cache Security Group ID |
| rds_sg_id | VPC RDS Security Group ID |