###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCvFga7bnTy7JYFUfXzhvYt/hWgu2BOL4A0MTn0ayXl4+9dhCvqrJT5ZteRU8QyPSKde90vDb2gIejdH9DL5i7WawOKSaTa3wHoef51eTVo3tjNVXIscHKnZOeZ+ttnBaT98Yjhu56ctDyPGVSLjnke6IURwuNQzsjAtiWvnPdzVIbONE8um2rgFc0U4CQYLjrEFRQL7rkdnK27Sj2ynPexxHJTyA6SYtGvJ/vBwEfRXUzZo7vsWiLnZvbyIhdEtd0XVITdSf+8N9kj1rmFeBybpEJtnNemjGf/B9ZU59kgCc723rkxnyPxcWM9P+qEfz4DyAU2eMopXuhGk9lshGzKTcKaOyaUMzr1V4JBzT0UKJoNHr0p7gN+PXms+vni30nppBougaC3ZgdwNMILGITVB5llB8XacLt0xTRc07FLGML196YlOBJap+SSjEAWRcYZtmxHLXWWHgVjDZS5cjFLlMI6eRsd4ih5SrPsHNcVyfv67JxUzvPOJ9b6t71Lkjc= devops@WORKBOOK"
  description = "ssh-keygen -t ed25519"
}

#yandex computer image vars

variable "vmweb_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "ubuntu version"
}

variable "vms_metadata" {
  type = map(string)
  default = {
    serial-port-enable = "1"
   
  }
}

variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  default = {
    platform = {
      cores         = 2
      memory        = 2
      core_fraction = 5
    }
    platform_db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
}


## instance vars 
#variable "vmweb_core" {
#  type        = number
#  default     = 2
#  description = "core"
#}

#variable "vmweb_memo" {
#  type        = number
#  default     = 2
#  description = "memory"
#}

#variable "vmweb_fr" {
#  type        = number
#  default     = 5
#  description = "fraction"
#}

