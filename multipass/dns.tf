
resource "null_resource" "dns" {
  triggers = {
    name = var.name
    ip   = shell_script.github_repository.output.ip
    domain_name=var.domain_name
  }
  provisioner "local-exec" {
    command     = "echo ${shell_script.github_repository.output.ip} ${var.name}.${var.domain_name} | sudo tee -a /etc/hosts > /dev/null"
    interpreter = ["bash", "-c"]
  }
  provisioner "local-exec" {
    when    = destroy
    command = "sudo sed  -i '/${self.triggers.name}.${self.triggers.domain_name}/d' /etc/hosts"
  }
}
