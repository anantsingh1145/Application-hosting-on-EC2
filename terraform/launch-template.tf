resource "aws_launch_template" "asg-test" {
  name = "asg-test-launch-template"

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 20
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  ebs_optimized = true

  image_id = "ami-0a7d80731ae1b2435"

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t3.micro"

  key_name = "asg-test-key"

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = false
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }

  user_data = filebase64("${path.module}/../user-data-file/test-asg-user-data.sh")

  depends_on = [ module.test-asg-ec2-sg ]
}