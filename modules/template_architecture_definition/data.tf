data "template_file" "populated_architecture_definition_json" {
  template = file(local.template_file_path)
  vars     = local.template_vars
}