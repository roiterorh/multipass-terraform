


resource "shell_script" "github_repository" {
  lifecycle_commands {
    create = "scripts/create.py"
    // read   = "scripts/read.py"
    // update = file("${path.module}/scripts/update.sh")
    delete = "scripts/delete.py"
  }

  environment = {
    MULTIPASS_NAME  = var.name
    MULTIPASS_MEM   = var.mem
    MULTIPASS_DISK  = var.disk
    MULTIPASS_CPU   = var.cpu
    MULTIPASS_IMAGE = var.image
    #recreates on cloud init change
    cloud_init            = base64encode(local_file.cloud_init.content) 

  }


  interpreter = ["/usr/bin/python3", ]

  depends_on = [local_file.cloud_init]
}


output "ip" {

    value=shell_script.github_repository.output.ip
}



data "template_file" "user_data" {
  template = file("scripts/cloud-init.yaml")
  vars = {
    ssh_public_key = file("~/.ssh/id_rsa.pub")
    hostname       = var.name
    fqdn           = "${var.name}.${var.domain_name}"
  }
}

resource "local_file" "cloud_init" {
  content  = data.template_file.user_data.rendered
  filename = "scripts/init/cloud_init_${var.name}.yaml"
}