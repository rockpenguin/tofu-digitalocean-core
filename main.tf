#####################################################################
# TAGS
#####################################################################
resource "digitalocean_tag" "tag" {
  for_each = var.tags
  name = each.value
}

#####################################################################
# CONTAINER REGISTRIES
#####################################################################
resource "digitalocean_container_registry" "docr" {
  for_each = var.registries
  name                    = each.value.name
  region                  = each.value.region
  subscription_tier_slug  = each.value.subscription_tier_slug
}

#####################################################################
# SSH KEYS
#####################################################################
resource "digitalocean_ssh_key" "ssh_keys" {
  for_each = var.ssh_keys_map

  name = each.key
  public_key = each.value
}


#####################################################################
# NETWORKING
#####################################################################

##############################
# VPCs
##############################
resource "digitalocean_vpc" "vpcs" {
  for_each = var.vpc_map
  name = replace(each.key, "_", "-")
  region = each.value[0]
  ip_range = each.value[1]
}

##############################
# FIREWALLS
##############################
resource "digitalocean_firewall" "firewall" {
  for_each = var.firewalls
  name = replace( each.key, "_", "-" )

  tags = each.value.tags

  dynamic "inbound_rule" {
    for_each = var.firewalls[each.key].ingress_rules
    content {
      protocol = inbound_rule.value.protocol
      port_range = inbound_rule.value.port_range
      source_addresses = inbound_rule.value.source_addresses
    }
  }

  dynamic "outbound_rule" {
    for_each = var.firewalls[each.key].egress_rules
    content {
      protocol = outbound_rule.value.protocol
      port_range = outbound_rule.value.port_range
      destination_addresses = outbound_rule.value.destination_addresses
    }
  }
}
