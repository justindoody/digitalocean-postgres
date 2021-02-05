resource "digitalocean_volume" "postgres-data" {
  region                  = "nyc3"
  name                    = "postgres"
  size                    = 10
  initial_filesystem_type = "ext4"
  description             = "general purpose postgres database for various small apps"
}

resource "digitalocean_droplet" "postgres" {
  image = "ubuntu-20-04-x64"
  name = "postgres"
  region = "nyc3"
  size = "s-1vcpu-1gb"
  monitoring = true
  private_networking = true
  ssh_keys = [
    data.digitalocean_ssh_key.macbook.id
  ]
  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
  }
}

resource "digitalocean_volume_attachment" "postgres-data" {
  droplet_id = digitalocean_droplet.postgres.id
  volume_id  = digitalocean_volume.postgres-data.id
}

resource "digitalocean_firewall" "postgres" {
  name = "only-22"

  droplet_ids = [digitalocean_droplet.postgres.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
