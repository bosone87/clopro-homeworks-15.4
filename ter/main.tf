data "template_file" "cloudinit" {
 template = file("./cc.yml")
  vars = {
    ssh_public_key   = file("~/.ssh/id_ed25519.pub")
  }
}