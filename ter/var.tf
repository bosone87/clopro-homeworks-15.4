
# YC

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

# YC zones

variable "default_region" {
  type        = string
  default     = "ru-central1"
}
variable "vms_zone" {
  type        = string
  default     = "standard-v1"
}
variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
}

# VPC

variable "network_name" {
  type = string
  default = "network"
}
variable "public" {
   type = map(any)
   default = {
      sub-a = {
         name = "public-a"
         zone = "ru-central1-a"
         cidr = "10.0.1.0/24"
      }
      sub-b = {
         name = "public-b"
         zone = "ru-central1-b"
         cidr = "10.0.2.0/24"
      }
      sub-c = {
         name = "public-c"
         zone = "ru-central1-c"
         cidr = "10.0.3.0/24"
      }
   }
}
variable "private" {
   type = map(any)
   default = {
      sub-a = {
         name = "private-a"
         zone = "ru-central1-a"
         cidr = "10.0.4.0/24"
      }
/*       sub-b = {
         name = "private-b"
         zone = "ru-central1-b"
         cidr = "10.0.5.0/24"
      } */
   }
}

# Cluster k8s

variable "v_k8s" {
  type    = string
  default = "1.28"
}
variable "set_k8s" {
  type = list(object({ 
      name   = string,
      rc     = string,
      m_pub_ip = bool
    }))
  default = [ 
      {
      name   = "my-k8s-regional"
      rc     = "STABLE"
      m_pub_ip = true
      }
  ]
  description = "k8s settings"
}
variable "res_node" {
   type = list(object({ 
      name = string,
      cpu        = number,
      cf         = number, 
      ram        = number, 
      d_size     = number,
      d_type     = string,
      s_policy   = bool,
      c_type     = string,
      sp_min     = number,
      sp_max     = number,
      sp_initial = number,
      nat        = bool
    }))
  default = [ 
      {
      name       = "ng"
      cpu        = 2
      cf         = 5
      ram        = 2
      d_size     = 30
      d_type     = "network-ssd"
      s_policy   = true
      c_type     = "containerd"
      sp_min     = 3
      sp_max     = 6
      sp_initial = 3
      nat        = true
      }
  ]
  description = "node resources"
}

# Cluster MySQL

variable "set_mysql" {
  type = list(object({ 
      name        = string,
      env         = string,
      ver         = string, 
      prot        = bool, 
      res_id      = string,
      d_type      = string,
      d_size      = number,
      bs_h        = number,
      bs_m        = number,
      mw_type     = string,
      mw_day      = string,
      mw_h        = number,
      host_pub_ip = bool
    }))
  default = [ 
      {
      name       = "my-mysql"
      env        = "PRESTABLE"
      ver        = "8.0"
      prot       = true
      res_id     = "b1.medium"
      d_type     = "network-ssd"
      d_size     = 20
      bs_h       = 23
      bs_m       = 59
      mw_type    = "WEEKLY"
      mw_day     = "MON"
      mw_h       = 03
      host_pub_ip  = true
      }
  ]
  description = "mysql settings"
}
variable "db_mysql" {
  type = list(object({ 
      db_name = string,
      u_name  = string,
      u_pass  = string,
      u_role  = string
    }))
  default = [ 
      {
      db_name = "my-db"
      u_name  = "user1"
      u_pass  = "netology1"
      u_role = "ALL"
      }
  ]
}