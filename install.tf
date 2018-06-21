data "template_file" "jx_install_create" {
  template = "${file("${path.module}/templates/resource-jx_install-create.tpl")}"

  vars {
    admin_user        = "${var.admin_user}"
    admin_password    = "${var.admin_password}"
    jx_provider       = "kubernetes"
    git_provider_url  = "https://github.com"
    git_owner         = "opstricks"
    git_user          = "opstricks"
    git_token         = "${var.git_token}"
  }

  depends_on = []
}

resource "null_resource" "jx_install_create" {
  triggers {
    template = "${data.template_file.jx_install_create.rendered}"
    #template = "${path.module}/templates/jx_install.tpl"
  }

  provisioner "local-exec" {
    command = "${data.template_file.jx_install_create.rendered}"
  }

  provisioner "local-exec" {
    command = "${file("${path.module}/scripts/waiter_check_jenkins-x.sh")}"
  }

}

data "template_file" "jx_install_destroy" {
  template = "${file("${path.module}/templates/resource-jx_install-destroy.tpl")}"

  vars {
    admin_user        = "${var.admin_user}"
    admin_password    = "${var.admin_password}"
    jx_provider       = "kubernetes"
    git_provider_url  = "https://github.com"
    git_owner         = "opstricks"
    git_user          = "opstricks"
    git_token         = "${var.git_token}"
  }

  depends_on = []
}

resource "null_resource" "jx_install_destroy" {
  triggers {
    template = "${data.template_file.jx_install_destroy.rendered}"
  }
  provisioner "local-exec" {
    when    = "destroy"
    command = "${data.template_file.jx_install_destroy.rendered}"
  }

}
