terraform {
    required_version = ">= 0.10.7"
    backend "s3" {}
}

provider "aws" {
    region = "${var.region}"
}

module "target_group" {
    source = "kurron/alb-target-group/aws"

    region                         = "${var.region}"
    name                           = "${var.name}"
    project                        = "${var.project}"
    purpose                        = "${var.purpose}"
    creator                        = "${var.creator}"
    environment                    = "${var.environment}"
    freetext                       = "${var.freetext}"
    port                           = "${var.service_port}"
    protocol                       = "HTTP"
    vpc_id                         = "${var.vpc_id}"
    enable_stickiness              = "Yes"
    health_check_interval          = "30"
    health_check_path              = "${var.health_check_path}"
    health_check_protocol          = "HTTP"
    health_check_timeout           = "5"
    health_check_healthy_threshold = "5"
    unhealthy_threshold            = "2"
    matcher                        = "200-299"
    load_balancer_arn              = "${var.alb_arn}"
}

resource "aws_lb_target_group_attachment" "attachment" {
    count            = "${var.instance_count}"
    target_group_arn = "${module.target_group.target_group_arn}"
    target_id        = "${element( var.instance_ids, count.index) }"
    port             = "${var.service_port}"
}

# Recommendation of https://www.terraform.io/docs/providers/aws/r/security_group_rule.html
resource "aws_security_group_rule" "ingress" {
    type              = "ingress"
    cidr_blocks       = ["0.0.0.0/0"]
    from_port         = "${var.service_port}"
    protocol          = "tcp"
    security_group_id = "${var.security_group_id}"
    to_port           = "${var.service_port}"
    description       = "HTTP access to ${var.name}"
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_security_group_rule" "egress" {
    type              = "egress"
    cidr_blocks       = ["${var.vpc_cidr}"]
    from_port         = "${var.service_port}"
    protocol          = "tcp"
    security_group_id = "${var.security_group_id}"
    to_port           = "${var.service_port}"
    description       = "HTTP access to ${var.name}"
    lifecycle {
        create_before_destroy = true
    }
}
