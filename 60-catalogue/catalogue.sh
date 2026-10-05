#!/bin/bash
set -e

component="${1:?Usage: bootstrap.sh <component>}"

dnf install -y git ansible
ansible-pull -U https://github.com/KondaSandhya/ansible-roboshop-roles -e "component=${component}" main.yaml
