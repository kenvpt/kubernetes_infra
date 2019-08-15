locals = {
  cluster_name                      = "kubernetesda.com"
  master_autoscaling_group_ids      = ["${aws_autoscaling_group.master-us-west-1b-masters-kubernetesda-com.id}"]
  master_security_group_ids         = ["${aws_security_group.masters-kubernetesda-com.id}"]
  masters_role_arn                  = "${aws_iam_role.masters-kubernetesda-com.arn}"
  masters_role_name                 = "${aws_iam_role.masters-kubernetesda-com.name}"
  node_autoscaling_group_ids        = ["${aws_autoscaling_group.nodes-kubernetesda-com.id}"]
  node_security_group_ids           = ["${aws_security_group.nodes-kubernetesda-com.id}"]
  node_subnet_ids                   = ["${aws_subnet.us-west-1b-kubernetesda-com.id}", "${aws_subnet.us-west-1c-kubernetesda-com.id}"]
  nodes_role_arn                    = "${aws_iam_role.nodes-kubernetesda-com.arn}"
  nodes_role_name                   = "${aws_iam_role.nodes-kubernetesda-com.name}"
  region                            = "us-west-1"
  route_table_private-us-west-1b_id = "${aws_route_table.private-us-west-1b-kubernetesda-com.id}"
  route_table_private-us-west-1c_id = "${aws_route_table.private-us-west-1c-kubernetesda-com.id}"
  route_table_public_id             = "${aws_route_table.kubernetesda-com.id}"
  subnet_us-west-1b_id              = "${aws_subnet.us-west-1b-kubernetesda-com.id}"
  subnet_us-west-1c_id              = "${aws_subnet.us-west-1c-kubernetesda-com.id}"
  subnet_utility-us-west-1b_id      = "${aws_subnet.utility-us-west-1b-kubernetesda-com.id}"
  subnet_utility-us-west-1c_id      = "${aws_subnet.utility-us-west-1c-kubernetesda-com.id}"
  vpc_cidr_block                    = "${aws_vpc.kubernetesda-com.cidr_block}"
  vpc_id                            = "${aws_vpc.kubernetesda-com.id}"
}

output "cluster_name" {
  value = "kubernetesda.com"
}

output "master_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.master-us-west-1b-masters-kubernetesda-com.id}"]
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-kubernetesda-com.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-kubernetesda-com.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-kubernetesda-com.name}"
}

output "node_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.nodes-kubernetesda-com.id}"]
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-kubernetesda-com.id}"]
}

output "node_subnet_ids" {
  value = ["${aws_subnet.us-west-1b-kubernetesda-com.id}", "${aws_subnet.us-west-1c-kubernetesda-com.id}"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-kubernetesda-com.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-kubernetesda-com.name}"
}

output "region" {
  value = "us-west-1"
}

output "route_table_private-us-west-1b_id" {
  value = "${aws_route_table.private-us-west-1b-kubernetesda-com.id}"
}

output "route_table_private-us-west-1c_id" {
  value = "${aws_route_table.private-us-west-1c-kubernetesda-com.id}"
}

output "route_table_public_id" {
  value = "${aws_route_table.kubernetesda-com.id}"
}

output "subnet_us-west-1b_id" {
  value = "${aws_subnet.us-west-1b-kubernetesda-com.id}"
}

output "subnet_us-west-1c_id" {
  value = "${aws_subnet.us-west-1c-kubernetesda-com.id}"
}

output "subnet_utility-us-west-1b_id" {
  value = "${aws_subnet.utility-us-west-1b-kubernetesda-com.id}"
}

output "subnet_utility-us-west-1c_id" {
  value = "${aws_subnet.utility-us-west-1c-kubernetesda-com.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.kubernetesda-com.cidr_block}"
}

output "vpc_id" {
  value = "${aws_vpc.kubernetesda-com.id}"
}

provider "aws" {
  region = "us-west-1"
}

resource "aws_autoscaling_attachment" "master-us-west-1b-masters-kubernetesda-com" {
  elb                    = "${aws_elb.api-kubernetesda-com.id}"
  autoscaling_group_name = "${aws_autoscaling_group.master-us-west-1b-masters-kubernetesda-com.id}"
}

resource "aws_autoscaling_group" "master-us-west-1b-masters-kubernetesda-com" {
  name                 = "master-us-west-1b.masters.kubernetesda.com"
  launch_configuration = "${aws_launch_configuration.master-us-west-1b-masters-kubernetesda-com.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-west-1b-kubernetesda-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "kubernetesda.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-west-1b.masters.kubernetesda.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-us-west-1b"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-kubernetesda-com" {
  name                 = "nodes.kubernetesda.com"
  launch_configuration = "${aws_launch_configuration.nodes-kubernetesda-com.id}"
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier  = ["${aws_subnet.us-west-1b-kubernetesda-com.id}", "${aws_subnet.us-west-1c-kubernetesda-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "kubernetesda.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.kubernetesda.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "b-etcd-events-kubernetesda-com" {
  availability_zone = "us-west-1b"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                        = "kubernetesda.com"
    Name                                     = "b.etcd-events.kubernetesda.com"
    "k8s.io/etcd/events"                     = "b/b"
    "k8s.io/role/master"                     = "1"
    "kubernetes.io/cluster/kubernetesda.com" = "owned"
  }
}

resource "aws_ebs_volume" "b-etcd-main-kubernetesda-com" {
  availability_zone = "us-west-1b"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                        = "kubernetesda.com"
    Name                                     = "b.etcd-main.kubernetesda.com"
    "k8s.io/etcd/main"                       = "b/b"
    "k8s.io/role/master"                     = "1"
    "kubernetes.io/cluster/kubernetesda.com" = "owned"
  }
}

resource "aws_eip" "us-west-1b-kubernetesda-com" {
  vpc = true

  tags = {
    KubernetesCluster                        = "kubernetesda.com"
    Name                                     = "us-west-1b.kubernetesda.com"
    "kubernetes.io/cluster/kubernetesda.com" = "owned"
  }
}

resource "aws_eip" "us-west-1c-kubernetesda-com" {
  vpc = true

  tags = {
    KubernetesCluster                        = "kubernetesda.com"
    Name                                     = "us-west-1c.kubernetesda.com"
    "kubernetes.io/cluster/kubernetesda.com" = "owned"
  }
}

resource "aws_elb" "api-kubernetesda-com" {
  name = "api-kubernetesda-com-gn282v"

  listener = {
    instance_port     = 443
    instance_protocol = "TCP"
    lb_port           = 443
    lb_protocol       = "TCP"
  }

  security_groups = ["${aws_security_group.api-elb-kubernetesda-com.id}"]
  subnets         = ["${aws_subnet.utility-us-west-1b-kubernetesda-com.id}", "${aws_subnet.utility-us-west-1c-kubernetesda-com.id}"]

  health_check = {
    target              = "SSL:443"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    timeout             = 5
  }

  idle_timeout = 300

  tags = {
    KubernetesCluster                        = "kubernetesda.com"
    Name                                     = "api.kubernetesda.com"
    "kubernetes.io/cluster/kubernetesda.com" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-kubernetesda-com" {
  name = "masters.kubernetesda.com"
  role = "${aws_iam_role.masters-kubernetesda-com.name}"
}

resource "aws_iam_instance_profile" "nodes-kubernetesda-com" {
  name = "nodes.kubernetesda.com"
  role = "${aws_iam_role.nodes-kubernetesda-com.name}"
}

resource "aws_iam_role" "masters-kubernetesda-com" {
  name               = "masters.kubernetesda.com"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.kubernetesda.com_policy")}"
}

resource "aws_iam_role" "nodes-kubernetesda-com" {
  name               = "nodes.kubernetesda.com"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.kubernetesda.com_policy")}"
}

resource "aws_iam_role_policy" "masters-kubernetesda-com" {
  name   = "masters.kubernetesda.com"
  role   = "${aws_iam_role.masters-kubernetesda-com.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.kubernetesda.com_policy")}"
}

resource "aws_iam_role_policy" "nodes-kubernetesda-com" {
  name   = "nodes.kubernetesda.com"
  role   = "${aws_iam_role.nodes-kubernetesda-com.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.kubernetesda.com_policy")}"
}

resource "aws_internet_gateway" "kubernetesda-com" {
  vpc_id = "${aws_vpc.kubernetesda-com.id}"

  tags = {
    KubernetesCluster                        = "kubernetesda.com"
    Name                                     = "kubernetesda.com"
    "kubernetes.io/cluster/kubernetesda.com" = "owned"
  }
}

resource "aws_key_pair" "kubernetes-kubernetesda-com-7d4a0fad57bb7adf46e324bd900e9fa4" {
  key_name   = "kubernetes.kubernetesda.com-7d:4a:0f:ad:57:bb:7a:df:46:e3:24:bd:90:0e:9f:a4"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.kubernetesda.com-7d4a0fad57bb7adf46e324bd900e9fa4_public_key")}"
}

resource "aws_launch_configuration" "master-us-west-1b-masters-kubernetesda-com" {
  name_prefix                 = "master-us-west-1b.masters.kubernetesda.com-"
  image_id                    = "ami-090a5d278903168cd"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-kubernetesda-com-7d4a0fad57bb7adf46e324bd900e9fa4.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-kubernetesda-com.id}"
  security_groups             = ["${aws_security_group.masters-kubernetesda-com.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-west-1b.masters.kubernetesda.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-kubernetesda-com" {
  name_prefix                 = "nodes.kubernetesda.com-"
  image_id                    = "ami-090a5d278903168cd"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-kubernetesda-com-7d4a0fad57bb7adf46e324bd900e9fa4.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-kubernetesda-com.id}"
  security_groups             = ["${aws_security_group.nodes-kubernetesda-com.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.kubernetesda.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_nat_gateway" "us-west-1b-kubernetesda-com" {
  allocation_id = "${aws_eip.us-west-1b-kubernetesda-com.id}"
  subnet_id     = "${aws_subnet.utility-us-west-1b-kubernetesda-com.id}"

  tags = {
    KubernetesCluster                        = "kubernetesda.com"
    Name                                     = "us-west-1b.kubernetesda.com"
    "kubernetes.io/cluster/kubernetesda.com" = "owned"
  }
}

resource "aws_nat_gateway" "us-west-1c-kubernetesda-com" {
  allocation_id = "${aws_eip.us-west-1c-kubernetesda-com.id}"
  subnet_id     = "${aws_subnet.utility-us-west-1c-kubernetesda-com.id}"

  tags = {
    KubernetesCluster                        = "kubernetesda.com"
    Name                                     = "us-west-1c.kubernetesda.com"
    "kubernetes.io/cluster/kubernetesda.com" = "owned"
  }
}

resource "aws_route" "0-0-0-0--0" {
  route_table_id         = "${aws_route_table.kubernetesda-com.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.kubernetesda-com.id}"
}

resource "aws_route" "private-us-west-1b-0-0-0-0--0" {
  route_table_id         = "${aws_route_table.private-us-west-1b-kubernetesda-com.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.us-west-1b-kubernetesda-com.id}"
}

resource "aws_route" "private-us-west-1c-0-0-0-0--0" {
  route_table_id         = "${aws_route_table.private-us-west-1c-kubernetesda-com.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.us-west-1c-kubernetesda-com.id}"
}

resource "aws_route53_record" "api-kubernetesda-com" {
  name = "api.kubernetesda.com"
  type = "A"

  alias = {
    name                   = "${aws_elb.api-kubernetesda-com.dns_name}"
    zone_id                = "${aws_elb.api-kubernetesda-com.zone_id}"
    evaluate_target_health = false
  }

  zone_id = "/hostedzone/ZZNL2IGVW9MN3"
}

resource "aws_route53_zone_association" "ZZNL2IGVW9MN3" {
  zone_id = "/hostedzone/ZZNL2IGVW9MN3"
  vpc_id  = "${aws_vpc.kubernetesda-com.id}"
}

resource "aws_route_table" "kubernetesda-com" {
  vpc_id = "${aws_vpc.kubernetesda-com.id}"

  tags = {
    KubernetesCluster                        = "kubernetesda.com"
    Name                                     = "kubernetesda.com"
    "kubernetes.io/cluster/kubernetesda.com" = "owned"
    "kubernetes.io/kops/role"                = "public"
  }
}

resource "aws_route_table" "private-us-west-1b-kubernetesda-com" {
  vpc_id = "${aws_vpc.kubernetesda-com.id}"

  tags = {
    KubernetesCluster                        = "kubernetesda.com"
    Name                                     = "private-us-west-1b.kubernetesda.com"
    "kubernetes.io/cluster/kubernetesda.com" = "owned"
    "kubernetes.io/kops/role"                = "private-us-west-1b"
  }
}

resource "aws_route_table" "private-us-west-1c-kubernetesda-com" {
  vpc_id = "${aws_vpc.kubernetesda-com.id}"

  tags = {
    KubernetesCluster                        = "kubernetesda.com"
    Name                                     = "private-us-west-1c.kubernetesda.com"
    "kubernetes.io/cluster/kubernetesda.com" = "owned"
    "kubernetes.io/kops/role"                = "private-us-west-1c"
  }
}

resource "aws_route_table_association" "private-us-west-1b-kubernetesda-com" {
  subnet_id      = "${aws_subnet.us-west-1b-kubernetesda-com.id}"
  route_table_id = "${aws_route_table.private-us-west-1b-kubernetesda-com.id}"
}

resource "aws_route_table_association" "private-us-west-1c-kubernetesda-com" {
  subnet_id      = "${aws_subnet.us-west-1c-kubernetesda-com.id}"
  route_table_id = "${aws_route_table.private-us-west-1c-kubernetesda-com.id}"
}

resource "aws_route_table_association" "utility-us-west-1b-kubernetesda-com" {
  subnet_id      = "${aws_subnet.utility-us-west-1b-kubernetesda-com.id}"
  route_table_id = "${aws_route_table.kubernetesda-com.id}"
}

resource "aws_route_table_association" "utility-us-west-1c-kubernetesda-com" {
  subnet_id      = "${aws_subnet.utility-us-west-1c-kubernetesda-com.id}"
  route_table_id = "${aws_route_table.kubernetesda-com.id}"
}

resource "aws_security_group" "api-elb-kubernetesda-com" {
  name        = "api-elb.kubernetesda.com"
  vpc_id      = "${aws_vpc.kubernetesda-com.id}"
  description = "Security group for api ELB"

  tags = {
    KubernetesCluster                        = "kubernetesda.com"
    Name                                     = "api-elb.kubernetesda.com"
    "kubernetes.io/cluster/kubernetesda.com" = "owned"
  }
}

resource "aws_security_group" "masters-kubernetesda-com" {
  name        = "masters.kubernetesda.com"
  vpc_id      = "${aws_vpc.kubernetesda-com.id}"
  description = "Security group for masters"

  tags = {
    KubernetesCluster                        = "kubernetesda.com"
    Name                                     = "masters.kubernetesda.com"
    "kubernetes.io/cluster/kubernetesda.com" = "owned"
  }
}

resource "aws_security_group" "nodes-kubernetesda-com" {
  name        = "nodes.kubernetesda.com"
  vpc_id      = "${aws_vpc.kubernetesda-com.id}"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                        = "kubernetesda.com"
    Name                                     = "nodes.kubernetesda.com"
    "kubernetes.io/cluster/kubernetesda.com" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kubernetesda-com.id}"
  source_security_group_id = "${aws_security_group.masters-kubernetesda-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-kubernetesda-com.id}"
  source_security_group_id = "${aws_security_group.masters-kubernetesda-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-kubernetesda-com.id}"
  source_security_group_id = "${aws_security_group.nodes-kubernetesda-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "api-elb-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.api-elb-kubernetesda-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https-api-elb-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.api-elb-kubernetesda-com.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https-elb-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kubernetesda-com.id}"
  source_security_group_id = "${aws_security_group.api-elb-kubernetesda-com.id}"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "icmp-pmtu-api-elb-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.api-elb-kubernetesda-com.id}"
  from_port         = 3
  to_port           = 4
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-kubernetesda-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-kubernetesda-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kubernetesda-com.id}"
  source_security_group_id = "${aws_security_group.nodes-kubernetesda-com.id}"
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kubernetesda-com.id}"
  source_security_group_id = "${aws_security_group.nodes-kubernetesda-com.id}"
  from_port                = 2382
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kubernetesda-com.id}"
  source_security_group_id = "${aws_security_group.nodes-kubernetesda-com.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kubernetesda-com.id}"
  source_security_group_id = "${aws_security_group.nodes-kubernetesda-com.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-kubernetesda-com.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.nodes-kubernetesda-com.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "us-west-1b-kubernetesda-com" {
  vpc_id            = "${aws_vpc.kubernetesda-com.id}"
  cidr_block        = "172.20.32.0/19"
  availability_zone = "us-west-1b"

  tags = {
    KubernetesCluster                        = "kubernetesda.com"
    Name                                     = "us-west-1b.kubernetesda.com"
    SubnetType                               = "Private"
    "kubernetes.io/cluster/kubernetesda.com" = "owned"
    "kubernetes.io/role/internal-elb"        = "1"
  }
}

resource "aws_subnet" "us-west-1c-kubernetesda-com" {
  vpc_id            = "${aws_vpc.kubernetesda-com.id}"
  cidr_block        = "172.20.64.0/19"
  availability_zone = "us-west-1c"

  tags = {
    KubernetesCluster                        = "kubernetesda.com"
    Name                                     = "us-west-1c.kubernetesda.com"
    SubnetType                               = "Private"
    "kubernetes.io/cluster/kubernetesda.com" = "owned"
    "kubernetes.io/role/internal-elb"        = "1"
  }
}

resource "aws_subnet" "utility-us-west-1b-kubernetesda-com" {
  vpc_id            = "${aws_vpc.kubernetesda-com.id}"
  cidr_block        = "172.20.0.0/22"
  availability_zone = "us-west-1b"

  tags = {
    KubernetesCluster                        = "kubernetesda.com"
    Name                                     = "utility-us-west-1b.kubernetesda.com"
    SubnetType                               = "Utility"
    "kubernetes.io/cluster/kubernetesda.com" = "owned"
    "kubernetes.io/role/elb"                 = "1"
  }
}

resource "aws_subnet" "utility-us-west-1c-kubernetesda-com" {
  vpc_id            = "${aws_vpc.kubernetesda-com.id}"
  cidr_block        = "172.20.4.0/22"
  availability_zone = "us-west-1c"

  tags = {
    KubernetesCluster                        = "kubernetesda.com"
    Name                                     = "utility-us-west-1c.kubernetesda.com"
    SubnetType                               = "Utility"
    "kubernetes.io/cluster/kubernetesda.com" = "owned"
    "kubernetes.io/role/elb"                 = "1"
  }
}

resource "aws_vpc" "kubernetesda-com" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    KubernetesCluster                        = "kubernetesda.com"
    Name                                     = "kubernetesda.com"
    "kubernetes.io/cluster/kubernetesda.com" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "kubernetesda-com" {
  domain_name         = "us-west-1.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    KubernetesCluster                        = "kubernetesda.com"
    Name                                     = "kubernetesda.com"
    "kubernetes.io/cluster/kubernetesda.com" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "kubernetesda-com" {
  vpc_id          = "${aws_vpc.kubernetesda-com.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.kubernetesda-com.id}"
}

terraform = {
  required_version = ">= 0.9.3"
}
