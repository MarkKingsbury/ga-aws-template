variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "mk-instance"
}

variable "environment_name" {
  description = "Name of the environment to deploy"
  type        = string
}