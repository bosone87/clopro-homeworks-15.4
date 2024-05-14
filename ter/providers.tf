
# YC provider

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}
provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}
/* provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "yc-k8s-cluster"
} */