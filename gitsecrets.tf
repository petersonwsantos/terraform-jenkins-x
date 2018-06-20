resource "null_resource" "gitSecrets_prepare" {
  provisioner "local-exec" {
    command = "cp -fv ${path.module}/templates/gitSecrets.tpl ${path.module}/conf/gitSecrets.yaml"
  }
}

data "template_file" "gitSecrets_template" {
  template = "${file("${path.module}/conf/gitSecrets.yaml")}"

  vars {
    git_user  = "${var.git_user}"
    git_token = "${var.git_token}"
  }

  depends_on = [
    "null_resource.dns",
    "null_resource.gitSecrets_prepare",
  ]
}

resource "null_resource" "gitSecrets_render" {
  triggers {
    #template = "${data.template_file.file.rendered}"
    template = "${path.module}/templates/gitSecrets.tpl"
  }

  provisioner "local-exec" {
    command = "echo \"${data.template_file.gitSecrets_template.rendered}\" > ${path.module}/conf/gitSecrets.yaml"
  }

  provisioner "local-exec" {
    command = "mkdir -p ~/.jx ; cp -vf ${path.module}/conf/gitSecrets.yaml ~/.jx/gitSecrets.yaml"
  }

  provisioner "local-exec" {
    when        = "destroy"
    command     = "echo '' > ${path.module}/conf/gitSecrets.yaml"
    interpreter = ["/bin/bash", "-c"]
  }
}
