resource "yandex_mdb_mysql_cluster" "my-mysql" {
    depends_on = [ 
        yandex_kubernetes_cluster.my-k8s-regional,
        yandex_vpc_network.network
    ]
    for_each = {for key, value in var.set_mysql: key => value}
    name                = each.value.name
    environment         = each.value.env
    network_id          = yandex_vpc_network.network.id
    version             = each.value.ver
    security_group_ids  = [ yandex_vpc_security_group.mysql-sg.id ]
    deletion_protection = each.value.prot

    resources {
        resource_preset_id = each.value.res_id
        disk_type_id       = each.value.d_type
        disk_size          = each.value.d_size
    }
    backup_window_start {
        hours   = each.value.bs_h
        minutes = each.value.bs_m
    }
    maintenance_window {
        type    = each.value.mw_type
        day     = each.value.mw_day
        hour    = each.value.mw_h
    }
    host {
        zone             = "${lookup(var.private["sub-a"],"zone")}"
        subnet_id        = "${yandex_vpc_subnet.private["sub-a"].id}"
        assign_public_ip = each.value.host_pub_ip
    }
/*     host {
        zone             = "${lookup(var.private["sub-b"],"zone")}"
        subnet_id        = "${yandex_vpc_subnet.private["sub-b"].id}"
    } */
}
resource "yandex_mdb_mysql_database" "my-db" {
    cluster_id = yandex_mdb_mysql_cluster.my-mysql[0].id
    for_each = {for key, value in var.db_mysql: key => value}
    name       = each.value.db_name
}
resource "yandex_mdb_mysql_user" "user1" {
    depends_on = [yandex_mdb_mysql_database.my-db]
    cluster_id = yandex_mdb_mysql_cluster.my-mysql[0].id
    for_each = {for key, value in var.db_mysql: key => value}
    name       = each.value.u_name
    password   = each.value.u_pass
    permission {
        database_name = each.value.db_name
        roles  = [ each.value.u_role ]
  }
}

