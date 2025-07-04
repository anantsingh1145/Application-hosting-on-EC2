module "asg-test" {
  source = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name = "test-asg"
  use_name_prefix    = false          
  force_delete       = true 

  min_size                  = 1
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  security_groups           = [module.test-asg-ec2-sg.security_group_id]

  launch_template_id      = aws_launch_template.asg-test.id
  launch_template_version = "$Latest"
  create_launch_template = false

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
      max_healthy_percentage = 100
    }
    triggers = ["tag"]
  }

  tags = {
    Environment = "dev"
    Project     = "megasecret"
  }

  depends_on = [ module.test-asg-ec2-sg, aws_launch_template.asg-test ]
}