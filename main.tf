resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.vmweb_image
}

locals {
  platform = {
    vm = {
      name = "netology-develop-platform-web"
    }
  }

  platform_db = {
    vm = {
      name = "netology-develop-platform-db"
    }
  }
}

resource "yandex_compute_instance" "platform" {
  name = local.platform.vm.name

  resources {
    cores         = var.vms_resources["platform"].cores
    memory        = var.vms_resources["platform"].memory
    core_fraction = var.vms_resources["platform"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = merge(var.vms_metadata, {
    ssh-keys = "ubuntu:${var.vms_ssh_root_key}"
  })
}

resource "yandex_compute_instance" "platform_db" {
  name = local.platform_db.vm.name

  resources {
    cores         = var.vms_resources["platform_db"].cores
    memory        = var.vms_resources["platform_db"].memory
    core_fraction = var.vms_resources["platform_db"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = merge(var.vms_metadata, {
    ssh-keys = "ubuntu:${var.vms_ssh_root_key}"
  })
}

