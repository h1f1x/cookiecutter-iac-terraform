variable "project_name" {
  description = "Name of the project."
  type        = string
  default     = "{{cookiecutter.project_slug}}"

  validation {
    condition     = length(var.project_name) <= 256 && length(regexall("/[^a-zA-Z0-9-_.:/=+@]/", var.project_name)) == 0
    error_message = "The project name must be no more than 256 characters, and only contain letters, numbers, spaces representable in UTF-8, and the following characters: _ . : / = + - @!"
  }
}

variable "environment" {
  description = "Name of the environment."
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Owner of the stack."
  type        = string
  default     = ""
}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default     = {}
}