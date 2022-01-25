The following are needed in `./vars/default.yml`:
```sh
---
user: <user>
copy_local_key: "{{ lookup('file', lookup('env','HOME') + '/.ssh/<key>.pub') }}"
sys_packages: [ 'curl', 'git', 'ufw']
db_user: <user>
db_name: <name>
db_password: <pass>
volume_name: <name>
vpc_range: <XX.XXX.X.X/XX>
```

You also need to add `./hosts` with:
```sh
XXX.XXX.X.XXX ansible_ssh_private_key_file=~/.ssh/<private-key>
```

Test connections:
`ansible all --inventory-file=./hosts -u <user> -m ping`

Use the following to run the playbooks:
`ansible-playbook playbook.yml --inventory-file=./hosts -u root`
`ansible-playbook postgres-playbook.yml --inventory-file=./hosts -u root`
`ansible-playbook apt-upgrade-playbook.yml --inventory-file=./hosts -u <user>`