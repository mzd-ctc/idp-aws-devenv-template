# EKS 모듈 출력값 정의

output "cluster_id" {
  description = "The ID of the EKS cluster"
  value       = aws_eks_cluster.main.id
}

output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_certificate_authority_data" {
  description = "The certificate authority data for the EKS cluster"
  value       = aws_eks_cluster.main.certificate_authority[0].data
}

output "cluster_oidc_issuer_url" {
  description = "The OIDC issuer URL for the EKS cluster"
  value       = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

output "cluster_oidc_provider_arn" {
  description = "The OIDC provider ARN for the EKS cluster"
  value       = replace(aws_eks_cluster.main.identity[0].oidc[0].issuer, "https://", "")
}

output "node_group_id" {
  description = "The ID of the EKS node group"
  value       = aws_eks_node_group.main.id
}

output "node_group_arn" {
  description = "The ARN of the EKS node group"
  value       = aws_eks_node_group.main.arn
}

output "node_group_resources" {
  description = "List of objects containing information about underlying resources"
  value       = aws_eks_node_group.main.resources
}

output "cluster_security_group_id" {
  description = "The ID of the EKS cluster security group"
  value       = aws_security_group.eks_cluster.id
}

output "node_security_group_id" {
  description = "The ID of the EKS node security group"
  value       = aws_security_group.eks_nodes.id
}

output "cluster_role_arn" {
  description = "The ARN of the EKS cluster IAM role"
  value       = aws_iam_role.eks_cluster.arn
}

output "node_group_role_arn" {
  description = "The ARN of the EKS node group IAM role"
  value       = aws_iam_role.eks_node_group.arn
}

output "kubeconfig" {
  description = "Kubeconfig for the EKS cluster"
  value = yamlencode({
    apiVersion      = "v1"
    kind           = "Config"
    current-context = aws_eks_cluster.main.name
    contexts = [
      {
        name = aws_eks_cluster.main.name
        context = {
          cluster = aws_eks_cluster.main.name
          user    = aws_eks_cluster.main.name
        }
      }
    ]
    clusters = [
      {
        name = aws_eks_cluster.main.name
        cluster = {
          server                   = aws_eks_cluster.main.endpoint
          certificate-authority-data = aws_eks_cluster.main.certificate_authority[0].data
        }
      }
    ]
    users = [
      {
        name = aws_eks_cluster.main.name
        user = {
          exec = {
            apiVersion = "client.authentication.k8s.io/v1beta1"
            command    = "aws"
            args = [
              "eks",
              "get-token",
              "--cluster-name",
              aws_eks_cluster.main.name,
              "--region",
              data.aws_region.current.name
            ]
          }
        }
      }
    ]
  })
  sensitive = true
} 