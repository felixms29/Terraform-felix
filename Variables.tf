variable "cidr" {
  description = "pass the cidr value of vpc"
  type        = string
  default     = "192.168.0.0/24"
}

variable "enable_dns" {
  description = "enable dns support"
  type        = bool
  default     = true
}