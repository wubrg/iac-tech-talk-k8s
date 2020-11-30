
resource "kubernetes_deployment" "terraform" {
  metadata {
    name = "${var.project}-${var.service}"
    labels = {
      project = var.project
      service = var.service
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        project = var.project
        service = var.service
      }
    }
    template {
      metadata {
        labels = {
          project = var.project
          service = var.service
        }
      }
      spec {
        container {
          image = "${var.docker_image}:${var.docker_image_version}"
          name  = "${var.project}-${var.service}"

          port {
            container_port = 80
          }

          env {
            name  = "HELLO_WORLD_TEXT"
            value = var.hello_world_text
          }

          resources {
            limits {
              cpu    = "0.5"
              memory = "128Mi"
            }
            requests {
              cpu    = "125m"
              memory = "25Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "terraform" {
  metadata {
    name = "${var.project}-${var.service}"
  }
  spec {
    selector = {
      project = kubernetes_deployment.terraform.spec.0.template.0.metadata[0].labels.project
    }
    port {
      port      = 80
      node_port = var.display_port
    }

    type = "NodePort"
  }
}
