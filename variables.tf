variable "domain" {
  description = "Domain name of the certificate"
}

variable "hostname" {
  description = "Hostname of the certificate"
}

variable "validation_method" {
  description = "Which method to use for validation. DNS or EMAIL are valid."
  default     = "DNS"
}

variable "subject_alternative_names" {
  description = "A list of domains that should be SANs in the issued certificate"
  default     = []
}

variable "tags" {
  description = "A mapping of tags"
  default     = {}
}

variable "skip_route53_validation" {
  description = "Set to true for zones not hosted in Route53"
  default     = false
}
