variable "lb_name" {
  type = string
}

variable "security_groups" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "target_group_name" {
  type = string
}

variable "target_port" {
  type = number
}

variable "listener_port" {
  type = number
}

variable "vpc_id" {
  type = string
}
