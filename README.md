# Домашнее задание к занятию «Установка Kubernetes»

### Цель задания

Установить кластер K8s.

### Чеклист готовности к домашнему заданию

1. Развёрнутые ВМ с ОС Ubuntu 20.04-lts.


### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Инструкция по установке kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/).
2. [Документация kubespray](https://kubespray.io/).

-----

### Задание 1. Установить кластер k8s с 1 master node

1. Подготовка работы кластера из 5 нод: 1 мастер и 4 рабочие ноды.
2. В качестве CRI — containerd.
3. Запуск etcd производить на мастере.
4. Способ установки выбрать самостоятельно.

Решение:  
Создал 5 ВМ через terraform в YC
<img width="1572" height="296" alt="image" src="https://github.com/user-attachments/assets/4ca4aec5-b423-4312-b5c2-58fcb31f3ff9" />

<img width="1445" height="832" alt="image" src="https://github.com/user-attachments/assets/1217967a-c504-40f7-a84f-f142fedff98f" />

Установка через Kubespray:

Установил зависимости:  

```
sudo apt update
sudo apt install python3.12-venv python3.12-dev -y
sudo apt install ansible
sudo apt install python3-pip
```

```
python3 -m pip install --upgrade --user ansible
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install -y python3.11

Переключаемся с версии 8 на версию 11

```
247  python3 --version  
  248  python3.11 --version  
  249  sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1  
  250  sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 2  
sudo update-alternatives --config python3  
```

Устанавливаем и обновляем версию ansible
python3 -m pip install --user ansible-core==2.18.6
python3 -m pip install --upgrade --user ansible
```

Подключился к каждой из ВМ  


<img width="475" height="125" alt="image" src="https://github.com/user-attachments/assets/dc7d8f74-fae0-418b-bdff-bfeca2e47e4e" />  

```
 1109  ssh -l ubuntu 89.169.135.79
 1110  ssh -l ubuntu 89.169.155.18
 1111  ssh -l ubuntu 89.169.143.185
 1112  ssh -l ubuntu 51.250.93.198
 1113  ssh -l ubuntu 158.160.44.99
```

Склонировал к себе репозиторий:  
```
git clone https://github.com/kubernetes-sigs/kubespray
```

Установил зависимости  
```
sudo pip3 install -r requirements.txt
```
Копирование примера в папку с вашей конфигурацией  
```
cp -rfp inventory/sample inventory/mycluster
```


Понизил версию ansible иначе не работал скрипт  

```
python3 -m pip install --user ansible-core==2.17.5
```

Перенес приватный ключь, для подключения к ВМ в файл ~/.ssh/yan
Запустил скрипт  

```
ansible-playbook -i inventory/mycluster/inventory.ini cluster.yml -b -v --key-file "~/.ssh/yan"
```

<img width="1072" height="860" alt="image" src="https://github.com/user-attachments/assets/558828da-6c93-4508-a932-1b00f05956f4" />


<img width="521" height="164" alt="image" src="https://github.com/user-attachments/assets/8eb2528c-de19-4d6a-a1f8-c78317641419" />



## Дополнительные задания (со звёздочкой)

**Настоятельно рекомендуем выполнять все задания под звёздочкой.** Их выполнение поможет глубже разобраться в материале.   
Задания под звёздочкой необязательные к выполнению и не повлияют на получение зачёта по этому домашнему заданию. 

------
### Задание 2*. Установить HA кластер

1. Установить кластер в режиме HA.
2. Использовать нечётное количество Master-node.
3. Для cluster ip использовать keepalived или другой способ.

### Правила приёма работы

1. Домашняя работа оформляется в своем Git-репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
2. Файл README.md должен содержать скриншоты вывода необходимых команд `kubectl get nodes`, а также скриншоты результатов.
3. Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.
