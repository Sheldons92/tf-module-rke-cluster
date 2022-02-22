resource rke_cluster "cluster" {
  ssh_agent_auth     = true
  cluster_name = var.rke.cluster_name
  dind = var.rke.dind
    
  dynamic nodes {
    for_each = var.rke_nodes
    content {
      user = nodes.value.user
      address = nodes.value.public_ip
      internal_address = nodes.value.private_ip
      role    = nodes.value.roles
    }
  }
  cloud_provider {
    name = var.rke.cloud_provider
  }
  upgrade_strategy {
    drain                        = false
    max_unavailable_controlplane = "1"
    max_unavailable_worker       = "10%"
  }

  kubernetes_version = var.rke.kubernetes_version
 }   

  resource "local_file" "kube_cluster_yaml" {
    filename = "${path.root}/kube_config_cluster.yml"
    content  = rke_cluster.cluster.kube_config_yaml
}