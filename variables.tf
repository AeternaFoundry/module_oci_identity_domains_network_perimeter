variable "identity_domains_network_perimeters" {
  description = <<EOT
Map of identity_domains_network_perimeters, attributes below
Required:
    - idcs_endpoint
    - name
    - schemas
    - ip_addresses (block):
        - type (optional)
        - value (required)
        - version (optional)
Optional:
    - attribute_sets
    - attributes
    - authorization
    - description
    - external_id
    - ocid
    - resource_type_schema_version
    - tags (block):
        - key (required)
        - value (required)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    idcs_endpoint                = string
    name                         = string
    schemas                      = list(string)
    attribute_sets               = optional(list(string))
    attributes                   = optional(string)
    authorization                = optional(string)
    description                  = optional(string)
    external_id                  = optional(string)
    ocid                         = optional(string)
    resource_type_schema_version = optional(string)
    ip_addresses = list(object({
      type    = optional(string)
      value   = string
      version = optional(string)
    }))
    tags = optional(list(object({
      key   = string
      value = string
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.identity_domains_network_perimeters : (
        length(v.ip_addresses) >= 1
      )
    ])
    error_message = "Each ip_addresses list must contain at least 1 items"
  }
}

