/* resource "aws_autoscaling_group" "boutique_ag" {
  desired_capacity     = 2
  launch_configuration = "${aws_launch_configuration.demo.id}"
  max_size             = 2
  min_size             = 1
  name                 = "boutique-eks-ag"
  vpc_zone_identifier  = ["${aws_subnet.aws_subnet.boutique_az_a_private-subnet.id}","${aws_subnet.boutique_az_b_private-subnet.id}"]

  tag {
    key                 = "Name"
    value               = "boutique-eks-ag"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster-name}"
    value               = "owned"
    propagate_at_launch = true
  }
}
*/