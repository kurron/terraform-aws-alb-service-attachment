variable "region" {
    type = "string"
    description = "The AWS region to deploy into (e.g. us-east-1)"
}

variable "name" {
    type = "string"
    description = "What to name the resources being created"
}

variable "project" {
    type = "string"
    description = "Name of the project these resources are being created for"
}

variable "purpose" {
    type = "string"
    description = "The role the resources will play"
}

variable "creator" {
    type = "string"
    description = "Person creating these resources"
}

variable "environment" {
    type = "string"
    description = "Context these resources will be used in, e.g. production"
}

variable "freetext" {
    type = "string"
    description = "Information that does not fit in the other tags"
}

variable "service_port" {
    type = "string"
    description = "Port that the service is exposing to the load balancer, e.g. 8080"
}

variable "health_check_path" {
    type = "string"
    description = "Health endpoint to use, e.g. /operations/health"
}

variable "vpc_id" {
    type = "string"
    description = "ID of the VPC the service lives in."
}

variable "alb_arn" {
    type = "string"
    description = "ARN of the load balancer to attach to."
}

variable "instance_ids" {
    type = "list"
    description = "List of EC2 instance IDs that the balancer should forward traffic to."
}

variable "security_group_id" {
    type = "string"
    description = "ID of the ALB's security group. We'll add an ingress rule for the service port."
}

variable "ingress_cidrs" {
    type = "list"
    description = "List of CIDR groups to allow incoming traffic from, e.g. [0.0.0.0/0]"
}
