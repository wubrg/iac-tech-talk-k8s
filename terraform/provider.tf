provider "kubernetes" {
  host                     = "https://kubernetes.docker.internal:6443"
  config_context_auth_info = "docker-desktop"
  config_context_cluster   = "docker-desktop"
}
