resource "null_resource" "adminSecrets_prepare" {
  provisioner "local-exec" {
    command = "cp -fv ${path.module}/templates/adminSecrets.tpl ${path.module}/conf/adminSecrets.yaml"
  }
}

data "template_file" "adminSecrets_template" {
  template = "${file("${path.module}/conf/adminSecrets.yaml")}"

  vars {
    admin_user                 = "${var.admin_user}"
    admin_password             = "${var.admin_password}"
    admin_password_jxbasicauth = "${var.admin_password_jxbasicauth}"
    user_home                  = "{user.home}"
  }

  depends_on = ["null_resource.adminSecrets_prepare"]
}

resource "null_resource" "adminSecrets_render" {
  triggers {
    #template = "${data.template_file.file.rendered}"
    template = "${path.module}/templates/adminSecrets.tpl"
  }

  provisioner "local-exec" {
    command = "echo \"${data.template_file.adminSecrets_template.rendered}\" > ${path.module}/conf/adminSecrets.yaml  "
  }

  #${user_home}
  provisioner "local-exec" {
    command = "sed -i \"s/REPLACE1/$/g\"  ${path.module}/conf/adminSecrets.yaml  "
  }

  provisioner "local-exec" {
    command = "sed -i 's/REPLACE2/{user_home}/g'  ${path.module}/conf/adminSecrets.yaml  "
  }

  provisioner "local-exec" {
    command = "sed -i '/^\\s*$/d' ${path.module}/conf/adminSecrets.yaml"
  }

  provisioner "local-exec" {
    command = "mkdir -p ~/.jx ; cp -vf ${path.module}/conf/adminSecrets.yaml ~/.jx/adminSecrets.yaml"
  }

  provisioner "local-exec" {
    when        = "destroy"
    command     = "echo '' > ${path.module}/conf/adminSecrets.yaml "
    interpreter = ["/bin/bash", "-c"]
  }
}
