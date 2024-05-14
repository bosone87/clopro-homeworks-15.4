
# O
output "mysql_host" {
  value = yandex_mdb_mysql_cluster.my-mysql[0].host.*.fqdn[0]
}
output "k8s_id" {
  value       = yandex_kubernetes_cluster.my-k8s-regional[0].id
}