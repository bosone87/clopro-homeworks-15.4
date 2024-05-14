resource "yandex_kubernetes_node_group" "k8s-ng" {
  depends_on = [ yandex_kubernetes_cluster.my-k8s-regional ]
  cluster_id = yandex_kubernetes_cluster.my-k8s-regional[0].id
  for_each = {for key, value in var.res_node: key => value}
  name       = "${each.value.name}"
  version = var.v_k8s
  instance_template {
    platform_id = var.vms_zone
    network_interface {
      nat        = each.value.nat
      subnet_ids = [ yandex_vpc_subnet.public["sub-a"].id ]
    }
    resources {
      memory = each.value.ram
      cores  = each.value.cpu
      core_fraction = each.value.cf
    }

    boot_disk {
      type = each.value.d_type
      size = each.value.d_size
    }

    scheduling_policy {
      preemptible = each.value.s_policy
    }

    container_runtime {
      type = each.value.c_type
    }
    metadata = local.metadata
  }
  scale_policy {
    auto_scale {
      min     = each.value.sp_min
      max     = each.value.sp_max
      initial = each.value.sp_initial
    }
  }
  allocation_policy {
    location {
      zone = var.default_zone
    }
  }
}