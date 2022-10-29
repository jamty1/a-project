#!/bin/bash

terraform init
read -p "Enter database username [user]: " user
user=${user:-user}
read -p "Enter database password [password]: " password
password=${password:-password}
terraform apply -var 'db_user'=$user -var 'db_password'=$password