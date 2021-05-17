


module "multipass" {
  source = "./multipass"
  name        = each.key
  for_each    = local.server
  cpu         = try(local.server[each.key].cpu != "", false) ? local.server[each.key].cpu : var.cpu
  mem         = try(local.server[each.key].mem != "", false) ? local.server[each.key].mem : var.mem
  disk        = try(local.server[each.key].disk != "", false) ? local.server[each.key].disk : var.disk
  domain_name = try(local.server[each.key].domain_name != "", false) ? local.server[each.key].domain_name : var.domain_name
  image = try(local.server[each.key].image != "", false) ? local.server[each.key].image : var.image
}



locals{
server=yamldecode(file("config.yaml")).servers
}

output "ip" {
    value = module.multipass[*]
}
