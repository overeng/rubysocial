# Настройка CI/CD и деплоя

Этот документ содержит дополнительные материалы, код и ссылки, упоминаемые в видео, которое можно найти тут.
Также здесь вы сможете найти некоторые пояснения к шагам, описанным в видео.

Итоговый код - в ветке [deployment](https://github.com/overeng/rubysocial/tree/deployment)

## Подготовительные шаги

### Операционка

Я использую в видео Mac OS. Если у вас Линукс, то проблем быть не должно, все команды в терминале
идентичны. Если же у вас Windows можете посмотреть отрывок из этого видео про настройку WSL: https://www.youtube.com/watch?v=aSGgsXSwSfI&t=143s

### VS Code

Я буду использовать VS Code в качестве редактора кода, поэтому можете его установить скачав версию для вашей
ОС [здесь](https://code.visualstudio.com/download), но это необязательно, можете использовать свой любимый текстовый редактор/IDE.

### Git

Вам потребуется установить Git, так как именно его мы будем использовать в качестве системы контроля
версий. Инструкции по установке вы найдете [здесь](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### GitHub

Вам нужно создать аккаунт на GitHub (тот самый сайт, где вы читаете эту инструкцию), если у вас его еще нет.

### Ruby

Мы будем деплоить Ruby On Rails приложение, и для некоторых шагов нам понадобится Ruby и некоторые
команды для управления зависимостями.
Инструкции по установке Ruby можно найти в [этом видео](https://www.youtube.com/watch?v=aSGgsXSwSfI&t=203s).

Также нам потребуется bundler, установить который можно просто набрав в терминале `gem install bundler`.

### psql - клиент для PostgeSQL сервера

Вам нужен будет psql для некоторых действий, обычно он устанавливается вместе с PostgreSQL сервером, инструкции можно найти [здесь](https://www.postgresql.org/download/)

Во многих ОС PostgreSQL установлен по умолчанию, выполните команду `psql --version`, чтобы проверить его наличие.

## Часть 1: Автотесты

Репозиторий для форка: https://github.com/overeng/rubysocial

Конфиг из видео:

https://github.com/overeng/rubysocial/blob/7aae1703917c69e05993ee219b8f3e7cb16ca3b5/.github/workflows/test.yml#L1-L30

Дока ГитХаба по событиям (эвентам), которые являются триггерами для workflows:

https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows

Ruby On Rails Getting Started: https://guides.rubyonrails.org/getting_started.html


## Часть 2: Релиз

Установка Docker: https://docs.docker.com/get-docker/

Содержимое Dockerfile из видео:

https://github.com/overeng/rubysocial/blob/7aae1703917c69e05993ee219b8f3e7cb16ca3b5/Dockerfile#L1-L25


Содержимое конфига из видео:

https://github.com/overeng/rubysocial/blob/7aae1703917c69e05993ee219b8f3e7cb16ca3b5/.github/workflows/release.yml#L1-L38

DockerHub: https://hub.docker.com/


## Часть 3: Деплой

AWS: https://aws.amazon.com/

Amazon Elastic Kubernetes Service: https://aws.amazon.com/eks/

Установка AWS CLI: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

Создание Kubernetes кластера в AWS: https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html

Установка eksctl: https://eksctl.io/introduction/#installation

Команда для создания кластера:

```
eksctl create cluster \
--name rubysocial \
--version 1.21 \
--region eu-central-1 \
--nodegroup-name linux-nodes \
--node-type t2.micro \
--nodes 4 \
--node-private-networking \
--ssh-access
```


Шаблон CloudFormation для bastion host:
https://github.com/overeng/rubysocial/blob/7aae1703917c69e05993ee219b8f3e7cb16ca3b5/deployment/cloudformation/bastion.yml#L1-L121

Команда для создания SSH-туннеля до базы данных:

```
ssh -i <путь к файлу с ключом для bastion host> -f -N -L 5432:<endpoint сервера PostgreSQL в AWS RDS> ec2-user@<адрес bastion host> -v
```

Установка kubectl: https://kubernetes.io/releases/download/

Конфиг для компонента Deployment:

https://github.com/overeng/rubysocial/blob/7aae1703917c69e05993ee219b8f3e7cb16ca3b5/deployment/kubernetes/rails-deployment.yml#L1-L29


Конфиг для компонента Service:

https://github.com/overeng/rubysocial/blob/7aae1703917c69e05993ee219b8f3e7cb16ca3b5/deployment/kubernetes/rails-service.yml#L1-L12


Фрагмент конфига Deployment с переменными окружения, необходимыми для установки соединения с базой данных:

https://github.com/overeng/rubysocial/blob/7aae1703917c69e05993ee219b8f3e7cb16ca3b5/deployment/kubernetes/rails-deployment.yml#L30-L38


Фрагмент release.yml, отвечающий за деплой css и js файлов:

https://github.com/overeng/rubysocial/blob/7aae1703917c69e05993ee219b8f3e7cb16ca3b5/.github/workflows/release.yml#L40-L56


Фрагмент конфига Deployment с переменными окружения, необходимыми для того чтобы подтянуть CSS и JS файлы из Amazon S3:

https://github.com/overeng/rubysocial/blob/7aae1703917c69e05993ee219b8f3e7cb16ca3b5/deployment/kubernetes/rails-deployment.yml#L39-L42


Установка Helm: https://helm.sh/docs/intro/install/

Workflow для Deployment на Kubernetes кластер:
https://github.com/overeng/rubysocial/blob/7aae1703917c69e05993ee219b8f3e7cb16ca3b5/.github/workflows/deploy-to-prod.yml#L1-L46
