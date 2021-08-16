variable "namespace" {
  description = "Namespace for velero deployment"
  type        = string
}

variable "overrides" {
  description = "velero helm chart list of overrides"
  type        = list(string)
  default     = []
}
