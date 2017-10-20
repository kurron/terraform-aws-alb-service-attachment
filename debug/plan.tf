terraform {
    required_version = ">= 0.10.7"
    backend "s3" {}
}

data "terraform_remote_state" "vpc" {
    backend = "s3"
    config {
        bucket = "transparent-test-terraform-state"
        key    = "us-west-2/debug/networking/vpc/terraform.tfstate"
        region = "us-east-1"
    }
}

data "terraform_remote_state" "security-groups" {
    backend = "s3"
    config {
        bucket = "transparent-test-terraform-state"
        key    = "us-west-2/debug/networking/security-groups/terraform.tfstate"
        region = "us-east-1"
    }
}

data "terraform_remote_state" "ec2" {
    backend = "s3"
    config {
        bucket = "transparent-test-terraform-state"
        key    = "us-west-2/debug/compute/ec2/terraform.tfstate"
        region = "us-east-1"
    }
}

data "terraform_remote_state" "alb" {
    backend = "s3"
    config {
        bucket = "transparent-test-terraform-state"
        key    = "us-west-2/debug/compute/alb/terraform.tfstate"
        region = "us-east-1"
    }
}

module "service_attachment" {
    source = "../"

    region            = "us-west-2"
    name              = "Ultron Service"
    project           = "Debug"
    purpose           = "Expose the Ultron Service port to the load balancer"
    creator           = "kurron@jvmguy.com"
    environment       = "development"
    freetext          = "No notes at this time."
    service_port      = "9999"
    health_check_path = "/operations/health"
    vpc_id            = "${data.terraform_remote_state.vpc.vpc_id}"
    alb_arn           = "${data.terraform_remote_state.alb.alb_arn}"
    instance_ids      = ["${data.terraform_remote_state.ec2.instance_ids}"]
    instance_count    = "${length( data.terraform_remote_state.ec2.instance_ids )}"
    security_group_id = "${data.terraform_remote_state.security-groups.alb_id}"
    ingress_cidrs     = ["64.222.174.146/32","98.216.147.13/32"]
}
