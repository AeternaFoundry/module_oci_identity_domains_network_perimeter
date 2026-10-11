resource "oci_identity_domains_network_perimeter" "identity_domains_network_perimeters" {
  for_each = var.identity_domains_network_perimeters

  idcs_endpoint                = each.value.idcs_endpoint
  name                         = each.value.name
  schemas                      = each.value.schemas
  attribute_sets               = each.value.attribute_sets
  attributes                   = each.value.attributes
  authorization                = each.value.authorization
  description                  = each.value.description
  external_id                  = each.value.external_id
  ocid                         = each.value.ocid
  resource_type_schema_version = each.value.resource_type_schema_version

  dynamic "ip_addresses" {
    for_each = each.value.ip_addresses
    content {
      type    = ip_addresses.value.type
      value   = ip_addresses.value.value
      version = ip_addresses.value.version
    }
  }

  dynamic "tags" {
    for_each = each.value.tags != null ? each.value.tags : []
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

