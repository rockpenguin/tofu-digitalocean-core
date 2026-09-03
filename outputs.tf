output "container_registries" {
  value = {
    for key,val in digitalocean_container_registry.docr : key => val.id
  }
}

output "project_id" {
  value = data.digitalocean_project.current.id
}

output "ssh_keys_map" {
    value = {
        for key, val in digitalocean_ssh_key.ssh_keys : key => val.id
    }
}

output "vpcs_map" {
  value = {
    for key, val in digitalocean_vpc.vpcs : key => val.id
  }
}
