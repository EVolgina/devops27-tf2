variable "vmdb_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "ubuntu version"
}

## instance vars
variable "vmdb_core" {
  type        = number
  default     = 2
  description = "core"
}

variable "vmdb_memo" {
  type        = number
  default     = 2
  description = "memory"
}

variable "vmdb_fr" {
  type        = number
  default     = 20
  description = "fraction"
}

