module "vpc-dev" { #название модуля
  source       = "./vpc-dev" 
  env_name_network = "network" #параметры которые передаем
  env_name_subnet  = "subnet" #параметры которые передаем
  zone = "ru-central1-a"
  cidr = ["10.0.1.0/24"]
}

module "module-srv-master-vm01" {
  #source         = "git::https://github.com/olegveselov1984/yandex_compute_instance.git?ref=main"
  source         = "./module-srv-vm"
  network_id     = module.vpc-dev.network_id 
  subnet_zones   = ["ru-central1-a","ru-central1-b"]
  subnet_ids     = [module.vpc-dev.subnet_id] 
  instance_name  = "srv-master-vm01"
  env_name = "srv-master-vm01" # Имя одной конкретной ВМ. instance_count не учитывается
  image_family   = "ubuntu-2404-lts"
  public_ip      = true
#  security_group_ids = [
#  yandex_vpc_security_group.example.id 
#  ]
   labels = { 
     project = "srv-master-vm01"
      }
  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

module "module-srv-worker-vm01" {
  # source         = "git::https://github.com/olegveselov1984/yandex_compute_instance.git?ref=main"
  source         = "./module-srv-vm"
  network_id     = module.vpc-dev.network_id 
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.vpc-dev.subnet_id]
  instance_name  = "srv-vworker-vm01"
  env_name = "srv-worker-vm01"
  image_family   = "ubuntu-2404-lts"
  public_ip      = true
  #security_group_ids = [
  #yandex_vpc_security_group.example.id 
  #]
   labels = { 
     project = "srv-worker-vm01"
      }
  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

module "module-srv-worker-vm02" {
  # source         = "git::https://github.com/olegveselov1984/yandex_compute_instance.git?ref=main"
  source         = "./module-srv-vm" 
  network_id     = module.vpc-dev.network_id 
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.vpc-dev.subnet_id]
  instance_name  = "srv-worker-vm02"
  env_name = "srv-worker-vm02"
  image_family   = "ubuntu-2404-lts"
  public_ip      = true
  #security_group_ids = [
  #yandex_vpc_security_group.example.id 
  #]
   labels = { 
     project = "srv-worker-vm02"
      }
  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }
}

module "module-srv-worker-vm03" {
  # source         = "git::https://github.com/olegveselov1984/yandex_compute_instance.git?ref=main"
  source         = "./module-srv-vm"
  network_id     = module.vpc-dev.network_id 
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.vpc-dev.subnet_id]
  instance_name  = "srv-worker-vm03"
  env_name = "srv-worker-vm03"
  image_family   = "ubuntu-2404-lts"
  public_ip      = true
  #security_group_ids = [
  #yandex_vpc_security_group.example.id 
  #]
   labels = { 
     project = "srv-worker-vm03"
      }
  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }
}

module "module-srv-worker-vm04" {
  # source         = "git::https://github.com/olegveselov1984/yandex_compute_instance.git?ref=main"
  source         = "./module-srv-vm"
  network_id     = module.vpc-dev.network_id 
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.vpc-dev.subnet_id]
  instance_name  = "srv-worker-vm04"
  env_name = "srv-worker-vm04"
  image_family   = "ubuntu-2404-lts"
  public_ip      = true
  #security_group_ids = [
  #yandex_vpc_security_group.example.id 
  #]
   labels = { 
     project = "srv-worker-vm04"
      }
  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

#Пример передачи cloud-config в ВМ.(передали путь к yml файлу и переменную!_ssh_public_key)
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
   vars = {
     ssh_public_key = var.ssh_public_key
   }
}

