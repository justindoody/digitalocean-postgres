## Readme

This repo is for spinning up and configuring a small postgres server on DigitalOcean using Terraform and Ansible.

### Terraform vars

The following are needed in `./terraform.tfvars`:
```sh
do_token = "token-here"
pvt_key = "~/.ssh/your-private-key"
```
