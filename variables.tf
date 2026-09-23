variable "firewalls" {
  type = map(object({
    ingress_rules = optional(list(object({
      protocol = string
      port_range = string
      source_addresses = optional(list(string))
      source_tags = optional(list(string))
      source_load_balancer_uids = optional(list(string))
      source_kubernetes_ids = optional(list(string))
    })))
    egress_rules = optional(list(object({
      protocol = string
      port_range = string
      destination_addresses = optional(list(string))
      destination_tags = optional(list(string))
      destination_load_balancer_uids = optional(list(string))
      destination_kubernetes_ids = optional(list(string))
    })))
    tags = optional(list(string))
  }))
  description = "Firewall definitions"
  default = {}
}

variable "project_name" {
  type = string
  description = "Project name to retrieve project ID"
  default = ""
}

variable "registries" {
  type = map(object({
    name = string
    region = string
    subscription_tier_slug = string
  }))
  default = {}
}

variable "ssh_keys_map" {
  type = map
  description = "SSH Public Keys"
  default = {}
}

variable "tags" {
  type = map
  description = "Digital Ocean tags"
  default = {}
}

variable "vpc_map" {
  description = "Map of VPC Data [region, CIDR]"
  default = {}
  type = map(object({
    name = string
    region = string
    cidr = optional(string)
    description = optional(string)
  }))
}
