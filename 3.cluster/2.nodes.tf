#data block to read local vpc terraform.tfstate file
data "terraform_remote_state" "network" {
  backend = "local"
  config = {
    path = "../vpc/terraform.tfstate"
  }
}
#create node group in the created vpc using created node role
resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.demo.name
  node_group_name = "private-nodes"
  node_role_arn   = data.terraform_remote_state.network.outputs.demo_role

  subnet_ids = [
    #aws_subnet.public[0].id,aws_subnet.public[1].id,
    data.terraform_remote_state.network.outputs.private[0], data.terraform_remote_state.network.outputs.private[1]
  ]

  capacity_type  = "ON_DEMAND"
  instance_types = ["t2.medium"]

  scaling_config {
    desired_size = 2
    max_size     = 10
    min_size     = 0
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "devops"
  }

  #This tags are important if we are going to use on a 
  tags = {
    "k8s.io/cluster-autoscaler/demo"    = "owned"
    "k8s.io/cluster-autoscaler/enabled" = "true"
  }
}



