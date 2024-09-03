locals {
  # Determine the default prefix and postfix based on the starter cache values
  starter_cache   = jsondecode(file("${var.starter_module_folder_path}/../../starter-cache.json"))
  default_prefix  = local.starter_cache.default_prefix
  default_postfix = local.starter_cache.default_postfix

  template_file_path = "${var.starter_module_folder_path}/../Common/template_architecture_definition/templates/${var.architecture_definition_name}.alz_architecture_definition.json.tftpl"
  enable_alz         = var.enable_alz

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
    root_archetypes = var.enable_alz ? "\"fsi_root\", \"root\"" : "\"fsi_root\""
    
    # sample snippet from architecture definition
    # "management_groups": [
    # {
    #   "archetypes":  [${root_archetypes}],
    #   "display_name": "Intermediate Root",
    #   "exists": false,
    #   "id": "${root_management_group_id}",
    #   "parent_id": null
    # },
  }
}
