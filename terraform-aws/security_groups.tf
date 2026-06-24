resource "aws_security_group" "eks_nodes_sg" {
  name        = "eks-node-group-sg"
  description = "Regole Firewall per i nodi worker EKS"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 30080
    to_port     = 30080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Traffico in uscita completamente libero
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds_sg" {

  name        = "eks-rds-postgres-sg"
  description = "Consenti traffico PostgreSQL solo dai nodi EKS"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.default.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  } 
}