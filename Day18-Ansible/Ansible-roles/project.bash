ansible-project/
├── inventory
├── site.yaml
├── roles/
│   ├── common/
│   │   └── tasks/main.yaml
│   ├── apache/
│   │   └── tasks/main.yaml
│   ├── users/
│   │   └── tasks/main.yaml
│   ├── updates/
│   │   └── tasks/main.yaml
│   └── monitoring/
│       └── tasks/main.yaml


inventory
[worker]
172.31.25.100


site.yaml

- hosts: worker
  become: true
  roles:
    - common
    - apache
    - users
    - updates
    - monitoring

#Common Role
roles/common/tasks/main.yaml

#Apache Role
roles/apache/tasks/main.yaml

#Users Role
roles/users/tasks/main.yaml

#Updates Role
roles/updates/tasks/main.yaml

#Monitoring Role
roles/monitoring/tasks/main.yaml

ansible-playbook -i inventory site.yaml