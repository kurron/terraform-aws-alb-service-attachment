# Overview
This Terraform module simplifies the process of adding a new service port to
an ALB, forwarding traffic to a list of EC2 instances.  It creates a new
Target Group listening on the specified port, binding the specified EC2 instances
to the group.  This module should **not** be used when configuring an ECS
environment, since ECS manages the registration of containers to the target group.

# Prerequisites
* [Terraform](https://terraform.io/) installed and working
* Development and testing was done on [Ubuntu Linux](http://www.ubuntu.com/)

# Building
Since this is just a collection of Terraform scripts, there is nothing to build.

# Installation
This module is not installed but, instead, is obtained by the project using
the module.  See [kurron/terraform-environments](https://github.com/kurron/terraform-environments)
for example usage.

# Tips and Tricks

## Debugging
The `debug` folder contains files that can be used to test out local changes
to the module.  Edit `backend.cfg` and `plan.tf` to your liking and
then run `debug/debug-module.sh` to test your changes.

# Troubleshooting

# License and Credits
This project is licensed under the [Apache License Version 2.0, January 2004](http://www.apache.org/licenses/).

# List of Changes
