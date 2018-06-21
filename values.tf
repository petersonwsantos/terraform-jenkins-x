resource "null_resource" "values_prepare" {
  provisioner "local-exec" {
    command = "cp -fv ${path.module}/templates/values.tpl ${path.module}/conf/values.yaml"
  }
}

data "template_file" "values_template" {
  template = "${file("${path.module}/conf/values.yaml")}"

  vars {
    admin_user     = "${var.admin_user}"
    admin_password = "${var.admin_password}"
    admin_password_jxbasicauth_values = "${var.admin_password_jxbasicauth_values}"
    asterisk = "$"
  }
  depends_on = [
    "null_resource.dns",
    "null_resource.values_prepare"
  ]
}

resource "null_resource" "values_render" {
  triggers {
    #template = "${data.template_file.file.rendered}"
    template = "${path.module}/templates/values.tpl"
  }

  provisioner "local-exec" {
    command = "echo \"${data.template_file.values_template.rendered}\" > ${path.module}/conf/values.yaml  "
  }

  provisioner "local-exec" {
    command = "sed -i '/^\\s*$/d' ${path.module}/conf/values.yaml"
  }

  provisioner "local-exec" {
    command = "mkdir -p ~/.jx ; cp -vf ${path.module}/conf/values.yaml ~/.jx/values.yaml"
  }

  provisioner "local-exec" {
    when        = "destroy"
    command     = "echo '' > ${path.module}/conf/values.yaml"
    interpreter = ["/bin/bash", "-c"]
  }
}
