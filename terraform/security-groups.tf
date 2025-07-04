module "test-asg-ec2-sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "test-asg-ec2-sg"
  description = "Security group for EC2 instaces hosted in ASG"
  vpc_id      = module.vpc.vpc_id

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all outbound traffic"
    }
  ]

  depends_on = [ module.vpc ]
}