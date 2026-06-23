# IAM AWS Academy
data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "task-manager-cluster"
  
  # LabRole obbligatorio
  role_arn = data.aws_iam_role.lab_role.arn

  vpc_config {

    subnet_ids         = data.aws_subnets.default.ids
    security_group_ids = [aws_security_group.eks_nodes_sg.id]

  }
}

resource "aws_eks_node_group" "worker_nodes" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "task-manager-workers"
  
  node_role_arn   = data.aws_iam_role.lab_role.arn
  subnet_ids      = data.aws_subnets.default.ids
  instance_types  = ["t3.medium"]

  scaling_config {
    desired_size = 2  
    max_size     = 3  
    min_size     = 1
  }

  depends_on = [
    aws_eks_cluster.eks_cluster
  ]
}