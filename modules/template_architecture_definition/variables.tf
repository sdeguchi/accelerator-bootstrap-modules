variable "starter_module_folder_path" {
  type        = string
  description = "The folder for the starter modules"
}

variable "architecture_definition_name" {
  type        = string
  description = "The name of the architecture definition"
}

variable "enable_alz" {
  description = "Enable the ALZ archetypes in the architecture definition"
  type        = bool
  default     = false
}
