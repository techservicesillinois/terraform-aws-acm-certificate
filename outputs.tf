output "id" {
  description = "The ARN of the certificate"
  value       = aws_acm_certificate.default.id
}

output "arn" {
  description = "The ARN of the certificate"
  value       = aws_acm_certificate.default.arn
}

output "domain_validation_options" {
  description = "A list of attributes to used to complete certificate validation."
  value       = aws_acm_certificate.default.domain_validation_options
}
