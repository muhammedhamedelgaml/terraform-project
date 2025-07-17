# cider_Blocks
# variable "cidr_block_vpc-1" {
#     description = "CIDR block for VPC-1"
#     type        = string
#     default     = "10.0.0.0/16"
# }



# variable "cidr_block_public1_subnet" {
#     description = "CIDR block for public1 subnet"
#     type        = string
#     default     = "10.0.0.0/24"
# }
# variable "cidr_block_private1_subnet" {
#     description = "CIDR block for private1 subnet"
#     type        = string
#     default     = "10.0.1.0/24"
# }

# variable "cidr_block_public2_subnet" {
#     description = "CIDR block for public2 subnet"
#     type        = string
#     default     = "10.0.2.0/24"
# }
# variable "cidr_block_private2_subnet" {
#     description = "CIDR block for private subnet2"
#     type        = string
#     default     = "10.0.3.0/24"
# }
variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "public_subnets" { default = ["10.0.0.0/24", "10.0.2.0/24"] }
variable "private_subnets" { default = ["10.0.1.0/24", "10.0.3.0/24"] }
variable "availability_zones" { default = ["us-east-1a", "us-east-1b"] }


variable "destination_cidr_block" {
    description = "Destination CIDR block for the route"
    type        = string
    default     = "0.0.0.0/0"
  
}












# EC2 vars
variable "ami_id" {
    description = "AMI ID for the EC2 instances"
    type        = string
    default     = "ami-05ffe3c48a9991133" 
}
variable "instance_type" {
    description = "Instance type for the EC2 instances"
    type        = string
    default     = "t2.micro"
}

variable "public_ec2_instance_name" {
    description = "Name for the public EC2 instance"
    type        = string
    default     = "pub-ec2-instance"
}
variable "private_ec2_instance_name" {
    description = "Name for the private EC2 instance"
    type        = string
    default     = "private-ec2-instance"
}




# Security Group vars
variable "ec2_security_group_name" {
    description = "Name for the ec2 security group"
    type        = string    
    default     = "ec2-sg"
}
variable "ec2_security_group_description" {
    description = "Description for the ec2 security group"
    type        = string
    default     = "Allow HTTP & SSH traffic"
}
variable "allowed_cidr_block" {
    description = "CIDR block to allow in the security group"
    type        = string
    default     = "0.0.0.0/0"
}





# Key Pair vars
variable "key_name" {
  description = "Name for the EC2 key pair"
  type        = string
  default     = "tf_key"
}

variable "public_key_path" {
  description = "Path to the public key used for EC2 SSH access"
  type        = string
  default = "./ec2_key.pub"
}