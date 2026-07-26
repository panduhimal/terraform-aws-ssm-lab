variable "region" {
  description = "The region where resources are deployed."
  type        = string
  default     = "ap-southeast-2"

  validation {
    condition     = contains(["ap-southeast-2", "us-east-1"], var.region)
    error_message = "The region must be either 'ap-southeast-2' or 'us-east-1'."
  }
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "The environment must be 'dev', 'staging', or 'prod'."
  }
}
variable "private_subnet_cidr" {
  description = "The CIDR block of the Private Subnet."
  type        = string
  default     = "172.31.48.0/20"

  validation {
    condition     = can(cidrhost(var.private_subnet_cidr, 0))
    error_message = "The CIDR range must be a valid IPv4 CIDR block (e.g., 10.0.0.0/24)."
  }
}

variable "private_endpoint_subnet_cidr" {
  description = "The CIDR block of the Private Endpoint Subnet."
  type        = string
  default     = "172.31.64.0/20"

  validation {
    condition     = can(cidrhost(var.private_subnet_cidr, 0))
    error_message = "The CIDR range must be a valid IPv4 CIDR block (e.g., 10.0.0.0/24)."
  }
}
