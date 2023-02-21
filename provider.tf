terraform {
required_version = ">= 1.3.4"
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 1.42.0"
    }
  }
}

#  username     = "${var.username}"
 # password     = "${var.password}"
 # tenant_name  = "${var.tenant_name}"
 # region       = "${var.region}"
#variable "username" {}
#variable "password" {}
#variable "tenant_name" {}

#variable "region" {}
