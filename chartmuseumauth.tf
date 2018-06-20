resource "null_resource" "chartmuseumAuth_prepare" {
  provisioner "local-exec" {
    command = "cp -fv ${path.module}/templates/chartmuseumAuth.tpl ${path.module}/conf/chartmuseumAuth.yaml"
  }
}

data "template_file" "chartmuseumAuth_template" {
  template = "${file("${path.module}/conf/chartmuseumAuth.yaml")}"

  vars {
    admin_user     = "${var.admin_user}"
    admin_password = "${var.admin_password}"
    ip_lb          = "${data.template_file.dns.rendered}"
  }

  depends_on = [
    "null_resource.dns",
    "null_resource.chartmuseumAuth_prepare"
  ]
}

resource "null_resource" "chartmuseumAuth_render" {
  triggers {
    #template = "${data.template_file.file.rendered}"
    template = "${path.module}/templates/chartmuseumAuth.tpl"
  }

  provisioner "local-exec" {
    command = "echo \"${data.template_file.chartmuseumAuth_template.rendered}\" > ${path.module}/conf/chartmuseumAuth.yaml  "
  }

  provisioner "local-exec" {
    command = "sed -i '/^\\s*$/d' ${path.module}/conf/chartmuseumAuth.yaml"
  }

  provisioner "local-exec" {
    command = "mkdir -p ~/.jx ; cp -vf ${path.module}/conf/chartmuseumAuth.yaml ~/.jx/chartmuseumAuth.yaml"
  }

  provisioner "local-exec" {
    when        = "destroy"
    command     = "echo '' > ${path.module}/conf/chartmuseumAuth.yaml"
    interpreter = ["/bin/bash", "-c"]
  }
}
