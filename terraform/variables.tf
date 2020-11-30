variable "hello_world_text" {
  type    = string
  default = "Hello from this terraformed service!"
}

variable "docker_image" {
  type    = string
  default = "docker.io/wubrgnc/kustomized"
}

variable "docker_image_version" {
  type    = string
  default = "0.0.1"
}

variable "project" {
  type    = string
  default = "terraform"
}

variable "service" {
  type    = string
  default = "hello-world"
}

variable "display_port" {
  type    = number
  default = 30081
}
