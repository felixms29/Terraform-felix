variable "cidr" {
  description = "pass the cidr value of vpc"
  type        = string
  default     = "192.168.0.0/24"
}


variable "internet_ip" {
  description = "allow connection to internet"
  type        = string
  default     = "0.0.0.0/0"
}

variable "vpc_tags" {
  description = "the standard name of vpc"
  type = object({
    Name        = string
    environment = string
  })
  default = ({
    Name        = "Add"
    environment = "b12"
  })
}

variable "zone" {
  description = "availability which are used"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
}

variable "subnet_tags" {
  description = "the standard name of public subnet"
  type = object({
    Name        = string
    environment = string
  })
  default = ({
    Name        = "pub-1"
    environment = "dev"
  })
}
