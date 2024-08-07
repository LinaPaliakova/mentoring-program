data "aws_availability_zones" "available" { state = "available" }
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.VPC_NAME
  cidr = var.vpcCIDR

  azs = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets = [var.PrivSub1CIDR, var.PrivSub2CIDR]
  public_subnets  = [var.PubSub1CIDR, var.PubSub2CIDR]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform   = "true"
    Environment = "Prod"
  }

  vpc_tags = {
    Name = var.VPC_NAME
  }
}
