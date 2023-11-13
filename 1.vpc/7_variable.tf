variable "region" {
  default = "us-east-2"
}

variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_cidr" {
  description = "CIDR block for the subnet"
  type        = list(string)
  default     = ["10.0.32.0/19", "10.0.96.0/19"]
}

variable "private_cidr" {
  description = "CIDR block for the subnet"
  type        = list(string)
  default     = ["10.0.64.0/19", "10.0.0.0/19"]
}

variable "availability_zone" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b"]
}