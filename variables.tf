variable "rke_nodes" {
  type = list(object({
    public_ip = string
    private_ip = string
    hostname = string
    roles = list(string)
    user = string
    ssh_key = string
  }))
  description = "Node info to install RKE cluster"
}

variable "rke" {
  type = object({
    cluster_name = string
    dind = bool
    kubernetes_version = string
    cloud_provider = string
  })
  default = {
    cluster_name = "rancher-server"
    dind = false
    kubernetes_version = ""
    cloud_provider = ""
  }
  description = "RKE configuration"
}