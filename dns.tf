# waiting to get load balancer ip
resource "null_resource" "dns" {
  provisioner "local-exec" {
    command     = "${file("${path.module}/scripts/waiter_dns_lb.sh")}"
    interpreter = ["/bin/bash", "-c"]
  }

  provisioner "local-exec" {
    command     = "cp -f ~/.jx/ip_lb.txt ${path.module}/conf/ip_lb.txt"
    interpreter = ["/bin/bash", "-c"]
  }
  provisioner "local-exec" {
    when    = "destroy"
    command = "echo ' ' > ${path.module}/conf/ip_lb.txt"
  }
  depends_on = ["helm_release.ingress_init"]
}

data "template_file" "dns" {
  template   = "${file("${path.module}/conf/ip_lb.txt")}"
  depends_on = ["null_resource.dns"]
}
