resource "null_resource" "extraValues_prepare" {
  provisioner "local-exec" {
    command = "cp -fv ${path.module}/templates/extraValues.tpl ${path.module}/conf/extraValues.yaml"
  }
}

data "template_file" "extraValues_template" {
  template = "${file("${path.module}/conf/extraValues.yaml")}"

  vars {
    ip_lb = "${data.template_file.dns.rendered}"
  }

  depends_on = [
    "null_resource.dns",
    "null_resource.extraValues_prepare",
  ]
}

resource "null_resource" "extraValues_render" {
  triggers {
    #template = "${data.template_file.file.rendered}"
    template = "${path.module}/templates/extraValues.tpl"
  }

  provisioner "local-exec" {
    command = "echo \"${data.template_file.extraValues_template.rendered}\" > ${path.module}/conf/extraValues.yaml  "
  }

  provisioner "local-exec" {
    command = "sed -i '/^\\s*$/d' ${path.module}/conf/extraValues.yaml"
  }

  provisioner "local-exec" {
    command = "mkdir -p ~/.jx ; cp -vf ${path.module}/conf/extraValues.yaml ~/.jx/extraValues.yaml"
  }

  provisioner "local-exec" {
    when        = "destroy"
    command     = "echo '' > ${path.module}/conf/extraValues.yaml"
    interpreter = ["/bin/bash", "-c"]
  }

}
