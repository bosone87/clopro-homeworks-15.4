# Домашнее задание к занятию «Кластеры. Ресурсы под управлением облачных провайдеров»

### Цели задания 

1. Организация кластера Kubernetes и кластера баз данных MySQL в отказоустойчивой архитектуре.
2. Размещение в private подсетях кластера БД, а в public — кластера Kubernetes.

---
## Задание 1. Yandex Cloud


1. Настроить с помощью Terraform кластер баз данных MySQL.

 - Используя настройки VPC из предыдущих домашних заданий, добавить дополнительно подсеть private в разных зонах, чтобы обеспечить отказоустойчивость. 
 - Разместить ноды кластера MySQL в разных подсетях.
 - Необходимо предусмотреть репликацию с произвольным временем технического обслуживания.
 - Использовать окружение Prestable, платформу Intel Broadwell с производительностью 50% CPU и размером диска 20 Гб.
 - Задать время начала резервного копирования — 23:59.
 - Включить защиту кластера от непреднамеренного удаления.
 - Создать БД с именем `netology_db`, логином и паролем.


2. Настроить с помощью Terraform кластер Kubernetes.

 - Используя настройки VPC из предыдущих домашних заданий, добавить дополнительно две подсети public в разных зонах, чтобы обеспечить отказоустойчивость.
 - Создать отдельный сервис-аккаунт с необходимыми правами. 
 - Создать региональный мастер Kubernetes с размещением нод в трёх разных подсетях.
 - Добавить возможность шифрования ключом из KMS, созданным в предыдущем домашнем задании.
 - Создать группу узлов, состояющую из трёх машин с автомасштабированием до шести.
 - Подключиться к кластеру с помощью `kubectl`.
 - *Запустить микросервис phpmyadmin и подключиться к ранее созданной БД.
 - *Создать сервис-типы Load Balancer и подключиться к phpmyadmin. Предоставить скриншот с публичным адресом и подключением к БД.


[**Terraform**](ter/)

[mysql.tf](ter/mysql.tf)
[k8s.tf](ter/k8s.tf)
[k8s_ng.tf](ter/k8s_ng.tf)
[network.tf](ter/network.tf)
[var.tf](ter/var.tf)
[output.tf](ter/output.tf)
[providers.tf](ter/providers.tf)
[locals.tf](ter/locals.tf)
[main.tf](ter/main.tf)
[sg.tf](ter/sg.tf)
[phpmyadmin.yml](ter/kuber/phpmyadmin.yml)


**Разворачиваем инфраструктуру**

<p align="center">
    <img width="1200 height="600" src="/img/res_ter_apply.png">
</p>

<p align="center">
    <img width="1200 height="600" src="/img/res_yc_all.png">
</p>

**Кластер MySQL**

<p align="center">
    <img width="1200 height="600" src="/img/res_yc_mysql.png">
</p>

<p align="center">
    <img width="1200 height="600" src="/img/res_yc_mysql_host.png">
</p>

<p align="center">
    <img width="1200 height="600" src="/img/res_mysql_db.png">
</p>

<p align="center">
    <img width="1200 height="600" src="/img/res_yc_mysql_user.png">
</p>

**Кластер k8s**

<p align="center">
    <img width="1200 height="600" src="/img/res_yc_k8s.png">
</p>

<p align="center">
    <img width="1200 height="600" src="/img/res_yc_k8s_ng.png">
</p>

<p align="center">
    <img width="1200 height="600" src="/img/res_yc_vmg.png">
</p>

**Network**

<p align="center">
    <img width="1200 height="600" src="/img/res_yc_vpc.png">
</p>

**Подключаемся к k8s**

<p align="center">
    <img width="1200 height="600" src="/img/res_k8s_info.png">
</p>

**Добавляем имя нашего хоста mysql, деплоим подготовленное приложение**

<p align="center">
    <img width="1200 height="600" src="/img/res_app_apply.png">
</p>

**Проверяем**

<p align="center">
    <img width="1200 height="600" src="/img/res_web_pma.png">
</p>


Полезные документы:

- [MySQL cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mysql_cluster).
- [Создание кластера Kubernetes](https://cloud.yandex.ru/docs/managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create)
- [K8S Cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_cluster).
- [K8S node group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_node_group).

--- 
## Задание 2*. Вариант с AWS (задание со звёздочкой)

Это необязательное задание. Его выполнение не влияет на получение зачёта по домашней работе.

**Что нужно сделать**

1. Настроить с помощью Terraform кластер EKS в три AZ региона, а также RDS на базе MySQL с поддержкой MultiAZ для репликации и создать два readreplica для работы.
 
 - Создать кластер RDS на базе MySQL.
 - Разместить в Private subnet и обеспечить доступ из public сети c помощью security group.
 - Настроить backup в семь дней и MultiAZ для обеспечения отказоустойчивости.
 - Настроить Read prelica в количестве двух штук на два AZ.

2. Создать кластер EKS на базе EC2.

 - С помощью Terraform установить кластер EKS на трёх EC2-инстансах в VPC в public сети.
 - Обеспечить доступ до БД RDS в private сети.
 - С помощью kubectl установить и запустить контейнер с phpmyadmin (образ взять из docker hub) и проверить подключение к БД RDS.
 - Подключить ELB (на выбор) к приложению, предоставить скрин.

Полезные документы:

- [Модуль EKS](https://learn.hashicorp.com/tutorials/terraform/eks).

### Правила приёма работы

Домашняя работа оформляется в своём Git репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
Файл README.md должен содержать скриншоты вывода необходимых команд, а также скриншоты результатов.
Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.
