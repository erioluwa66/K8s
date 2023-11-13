# K8s
This repository is about my attempt at deploying EKS with terraform on AWS
# How to create EKS using Terraform
# VPC
VPC: - Must have a minimun of 2-4 subnets in different AZs. 2 public, 2 private
        - VPC must be tagged
# Subnets
 Subnet: Subnets have to be tagged for alb

      tags = {
        Name = "public"
        "kubernetes.io/role/elb" = "1"
        "kubernete.io/cluster/demo" = "owned" or "shared"
      }
   - VPC needs DNS host name support
   - VPC needs DNS resolution
# Cluster IAM roles
 Cluster IAM roles:
   - eks makes api calls to other services, Iam with AmazonEKSClusterPolicy is attached.
   - the role needs to have the principal as eks.amazonaws.com service to assume it.
 
 resource "aws_iam_role" "demo" {
   name = "eks-cluster-demo"

   assume_role_policy = <<POLICY
   {
   "Version": "2012-10-17",
    "Statement": [
    {
    "Effect": "Allow",
    "Principal": {
    "Service": "eks.amazonaws.com"
    },
    "Action": "sts:AssumeRole"
    }
    ]
    }
     POLICY
      }
- 2 other policies need to be attached to this role. 
 = The policies must be amazon managed policies and not customer managed policies.

  resource "aws_iam_role_policy_attachment" "demo-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.demo.name
  }

resource "aws_iam_role_policy_attachment" "main-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.demo.name
 }

===========================================================================================

# Node groups
 Node groups:
  - role for creating nodes with permissions
  - policies attached to the role MUST be amazon managed policies.
  The principal to assume the role must be ec2.amazonaws.com as a service.
- 4 policies must be attached to the role.

resource "aws_iam_role" "nodes" {
   name = "eks-nodes-demo"

   assume_role_policy = <<POLICY
   {
   "Version": "2012-10-17",
    "Statement": [
    {
    "Effect": "Allow",
    "Principal": {
    "Service": "ec2.amazonaws.com"
    },
    "Action": "sts:AssumeRole"
    }
    ]
    }
     POLICY
      }

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "main-node-AmazonEC2FullAccess" {
policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
role       = aws_iam_role.nodes.name
}

# The credentials used to provision the EKS are the authorized credentials to modify or edit the configMap. aws-auth cm

============================================================
- The credentials used to provision the EKS are the authorized credentials to modify or edit the configMap. aws-auth cm

============================================================
Creating and adding users to EKS:
1. Create a clusterrole and clussterrolebinding
    - reader
    - deploy,cm,pods,secrets,services = resources
    - verbs - get,list,watch
2. Go to aws IAM, create a role and policies to be attached to a group.
3. Create a group called developer and attache the role to the group.
4. Create a user called developer1 and add the user to the developer group.
5. Generate IAM credentials for the user (secret/access) = aws configure --profile developer1
- Update kubeconfig file => 
aws eks update-kubeconfig --region us-east-1 --name demo --profile developer1

6. Modify the aws-auth cm in the kube-system ns.
  mapUsers: |
      - userarn: arn:aws:iam::<>:user/developer1
        username: developer1
        groups:
         - reader

  kubectl auth can-i get * - to validate correct configuration of RBAC.