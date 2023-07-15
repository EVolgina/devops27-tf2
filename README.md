# Чеклист готовности к домашнему заданию
- Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
- Установлен инструмент Yandex Cli.
- Исходный код для выполнения задания расположен в директории 02/src.
# Задание 0
- Ознакомьтесь с документацией к security-groups в Yandex Cloud.
- Запросите preview доступ к данному функционалу в ЛК Yandex Cloud. Обычно его выдают в течении 24-х часов. https://console.cloud.yandex.ru/folders/<ваш - cloud_id>/vpc/security-groups.(На конференции Yandex Scale 2022 мы представили сервис Yandex Cloud Apps. Доступ к нему можно было получить по запросу. Теперь Yandex Cloud Apps в стадии Preview доступен для всех пользователей, запрашивать доступ не нужно) [Link1](https://cloud.yandex.ru/blog/posts/2023/04/cloud-apps-update)
- Этот функционал понадобится к следующей лекции.
# Задание 1
В качестве ответа всегда полностью прикладываете ваш terraform-код в git!
- Изучите проект. В файле variables.tf объявлены переменные для yandex provider.
- Переименуйте файл personal.auto.tfvars_example в personal.auto.tfvars. Заполните переменные (идентификаторы облака, токен доступа). Благодаря .gitignore этот файл не попадет в публичный репозиторий. Вы можете выбрать иной способ безопасно передать секретные данные в terraform.
- Сгенерируйте или используйте свой текущий ssh ключ. Запишите его открытую часть в переменную vms_ssh_root_key.
- Инициализируйте проект, выполните код. Исправьте намеренное допущенные ошибки. Ответьте в чем заключается их суть?
- Ответьте, как в процессе обучения могут пригодиться параметры preemptible = true и core_fraction=5 в параметрах ВМ? Ответ в документации Yandex cloud.
В качестве решения приложите:
- скриншот ЛК Yandex Cloud с созданной ВМ,
- скриншот успешного подключения к консоли ВМ через ssh,
- ответы на вопросы.
![main]()
```
  vagrant@sysadm-fs:~/tf/ter-homeworks/02/src$ sudo terraform apply
data.yandex_compute_image.ubuntu: Reading...
yandex_vpc_network.develop: Refreshing state... [id=enp2ajs7g3foubrskual]
data.yandex_compute_image.ubuntu: Read complete after 4s [id=fd85f37uh98ldl1omk30]
yandex_vpc_subnet.develop: Refreshing state... [id=e9bajttna35me0p5im2k]
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create
Terraform will perform the following actions:
  # yandex_compute_instance.platform will be created
  + resource "yandex_compute_instance" "platform" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "serial-port-enable" = "1"
          + "ssh-keys"           = "ubuntu:SHA256:fuKsbDbpEtTja7rn54qRtwSvguoSSks4RyBtmo64oSw vagrant@sysadm-fs"
        }
      + name                      = "netology-develop-platform-web"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd85f37uh98ldl1omk30"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = "e9bajttna35me0p5im2k"
        }

      + resources {
          + core_fraction = 5
          + cores         = 2
          + memory        = 2
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.
  Enter a value: yes
yandex_compute_instance.platform: Creating...
yandex_compute_instance.platform: Still creating... [10s elapsed]
yandex_compute_instance.platform: Still creating... [20s elapsed]
yandex_compute_instance.platform: Still creating... [30s elapsed]
yandex_compute_instance.platform: Still creating... [40s elapsed]
yandex_compute_instance.platform: Creation complete after 44s [id=fhm02988ffpqs1u3kv2q]
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```
![yc]()
#### Ответ:
- ошибки в том что в файле main.tf было указано одно ядро, для разворачивания ВМ на Yandex Cloud минимальное количество ядер для ВМ 2
- Если необходимо определеить является ли данная ВМ прерываемой или нет, то должны быть строчки: preemptible = true
- core_fraction	Базовый уровень производительности vCPU. (Виртуальные машины с уровнем производительности 100% имеют непрерывный доступ (100% времени) к вычислительной мощности физических ядер. Такие ВМ предназначены для запуска приложений, требующих высокой производительности на протяжении всего времени работы.)

# Задание 2
Изучите файлы проекта.
Замените все "хардкод" значения для ресурсов yandex_compute_image и yandex_compute_instance на отдельные переменные. К названиям переменных ВМ добавьте в начало префикс vm_web_ . Пример: vm_web_name.
Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их default прежними значениями из main.tf.
Проверьте terraform plan (изменений быть не должно).
#### Ответ:
```

``` 
# Задание 3
- Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.
- Скопируйте блок ресурса и создайте с его помощью вторую ВМ(в файле main.tf): "netology-develop-platform-db" , cores = 2, memory = 2, core_fraction = 20. Объявите ее переменные с префиксом vm_db_ в том же файле('vms_platform.tf').
- Примените изменения.
#### Ответ:
# Задание 4
- Объявите в файле outputs.tf output типа map, содержащий { instance_name = external_ip } для каждой из ВМ.
- Примените изменения.
- В качестве решения приложите вывод значений ip-адресов команды terraform output
#### Ответ:
# Задание 5
- В файле locals.tf опишите в одном local-блоке имя каждой ВМ, используйте интерполяцию ${..} с несколькими переменными по примеру из лекции.
- Замените переменные с именами ВМ из файла variables.tf на созданные вами local переменные.
- Примените изменения.
#### Ответ:
# Задание 6
- Вместо использования 3-х переменных ".._cores",".._memory",".._core_fraction" в блоке resources {...}, объедените их в переменные типа map с именами "vm_web_resources" и "vm_db_resources". В качестве продвинутой практики попробуйте создать одну map переменную vms_resources и уже внутри нее конфиги обеих ВМ(вложенный map).
- Так же поступите с блоком metadata {serial-port-enable, ssh-keys}, эта переменная должна быть общая для всех ваших ВМ.
- Найдите и удалите все более не используемые переменные проекта.
- Проверьте terraform plan (изменений быть не должно).
#### Ответ:
