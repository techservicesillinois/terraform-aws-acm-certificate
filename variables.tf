variable "domain" {
  description = "Domain name of the certificate"
}

variable "hostname" {
  description = "Hostname of the certificate"
  default     = ""
}

variable "validation_method" {
  description = "Which method to use for validation. DNS or EMAIL are valid."
  default     = "DNS"
}

variable "subject_alternative_names" {
  description = "A list of domains that should be SANs in the issued certificate"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags"
  type        = map(string)
  default     = {}
}

variable "skip_route53_validation" {
  description = "Set to true for zones not hosted in Route53"
  default     = false
}

variable "create_route53_record" {
  description = "Set to false if Route53 record already exists"
  default     = true
}
