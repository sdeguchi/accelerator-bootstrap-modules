locals {
  # Determine the default prefix and postfix based on the starter cache values
  starter_cache   = jsondecode(file("${var.starter_module_folder_path}/../../starter-cache.json"))
  default_prefix  = local.starter_cache.default_prefix
  default_postfix = local.starter_cache.default_postfix

  template_file_path = "${var.starter_module_folder_path}/../Common/template_architecture_definition/templates/${var.architecture_definition_name}.alz_architecture_definition.json.tftpl"

  slz_architecture_definition_name = "slz"
  fsi_architecture_definition_name = "fsi"

  # SLZ archetypes
  slz_global = ["\"global\""]

  # FSI archetypes
  fsi_root = ["\"fsi_root\""]

  # ALZ archetypes
  alz_root           = ["\"root\""]
  alz_platform       = ["\"platform\""]
  alz_landing_zone   = ["\"landing_zone\""]
  alz_decommissioned = ["\"decommissioned\""]
  alz_sandboxes      = ["\"sandboxes\""]
  alz_corp           = ["\"corp\""]
  alz_online         = ["\"online\""]
  alz_management     = ["\"management\""]
  alz_connectivity   = ["\"connectivity\""]
  alz_identity       = ["\"identity\""]

  # management group layered archetypes
  root = (var.enable_alz ?
    (var.architecture_definition_name == local.slz_architecture_definition_name ? concat(local.slz_global, local.alz_root) : concat(local.fsi_root, local.alz_root))
  : (var.architecture_definition_name == local.fsi_architecture_definition_name ? local.fsi_root : local.slz_global))
  platform = var.enable_alz ? local.alz_platform : []
  landing_zone = var.enable_alz ? local.alz_landing_zone : []
  decommissioned = var.enable_alz ? local.alz_decommissioned :[]
  sandboxes = var.enable_alz ? local.alz_sandboxes :[]
  corp = var.enable_alz ? local.alz_corp :[]
  online = var.enable_alz ? local.alz_online :[]
  management = var.enable_alz ? local.alz_management :[]
  connectivity = var.enable_alz ? local.alz_connectivity :[]
  identity = var.enable_alz ? local.alz_identity :[]
  confidential_corp = var.enable_alz ? local.alz_corp :[]
  confidential_online = var.enable_alz ? local.alz_online :[]

  template_vars = {
    architecture_definition_name            = var.architecture_definition_name
    root_management_group_id                = "${local.default_prefix}${local.default_postfix}"
    platform_management_group_id            = "${local.default_prefix}-platform${local.default_postfix}"
    landing_zone_management_group_id        = "${local.default_prefix}-landingzones${local.default_postfix}"
    decommissioned_management_group_id      = "${local.default_prefix}-decommissioned${local.default_postfix}"
    sandboxes_management_group_id           = "${local.default_prefix}-sandbox${local.default_postfix}"
    corp_management_group_id                = "${local.default_prefix}-landingzones-corp${local.default_postfix}"
    online_management_group_id              = "${local.default_prefix}-landingzones-online${local.default_postfix}"
    management_management_group_id          = "${local.default_prefix}-platform-management${local.default_postfix}"
    connectivity_management_group_id        = "${local.default_prefix}-platform-connectivity${local.default_postfix}"
    identity_management_group_id            = "${local.default_prefix}-platform-identity${local.default_postfix}"
    confidential_corp_management_group_id   = "${local.default_prefix}-landingzones-confidential-corp${local.default_postfix}"
    confidential_online_management_group_id = "${local.default_prefix}-landingzones-confidential-online${local.default_postfix}"

    # example of how to add dynamic values to the template archetypes
    root_archetypes           = join(", ", local.root)
    platform_archetypes       = join(", ", local.platform)
    landing_zone_archetypes   = join(", ", local.landing_zone)
    decommissioned_archetypes = join(", ", local.decommissioned)
    sandboxes_archetypes      = join(", ", local.sandboxes)
    corp_archetypes           = join(", ", local.corp)
    online_archetypes         = join(", ", local.online)
    management_archetypes     = join(", ", local.management)
    connectivity_archetypes   = join(", ", local.connectivity)
    identity_archetypes       = join(", ", local.identity)
    confidential_corp_archetypes   = join(", ", local.confidential_corp)
    confidential_online_archetypes = join(", ", local.confidential_online)

    # sample snippet from architecture definition
    # {
    #   "name": "fsi",
    #   "management_groups": [
    #     {
    #       "archetypes": [${root_archetypes}],
    #       "display_name": "Intermediate Root",
    #       "exists": false,
    #       "id": "${root_management_group_id}",
    #       "parent_id": null
    #     },
    #     {
    #       "archetypes": [${landing_zone_archetypes}],
    #       "display_name": "Landing Zones",
    #       "exists": false,
    #       "id": "${landing_zone_management_group_id}",
    #       "parent_id": "${root_management_group_id}"
    #     }, 
    #     ...
  }
}