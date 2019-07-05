# Create a new load balancer
resource "aws_elb" "nelb" {
  name               = "Terraform-elb"
  subnets            = ["${var.subnet_id}"]
  security_groups    = ["${var.vpc_security_group_ids}"]

  listener {
    instance_port     = 8081
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8081/"
    interval            = 30
  }

  instances                   = ["${var.instances}"]
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "Elastic Load Balancer"
  }
}
