resource "aws_acm_certificate" "default" {
  domain_name               = "${local.fqdn}"
  subject_alternative_names = "${local.san}"
  validation_method         = "${var.validation_method}"

  lifecycle {
    create_before_destroy = true
  }

  tags = "${var.tags}"
}

locals {
  fqdn                    = "${var.hostname != "" ? format("%s.%s", var.hostname, var.domain) : var.domain}"
  san                     = ["${formatlist("%s.%s", var.subject_alternative_names, var.domain)}"]
  skip_route53_validation = "${var.validation_method == "EMAIL" ? true : var.skip_route53_validation}"
}

data "aws_route53_zone" "default" {
  count = "${local.skip_route53_validation ? 0 : 1}"

  name         = "${var.domain}."
  private_zone = false
}

resource "aws_route53_record" "default" {
  count = "${local.skip_route53_validation ? 0 : length(var.subject_alternative_names)+1}"

  name    = "${lookup(aws_acm_certificate.default.domain_validation_options[count.index], "resource_record_name")}"
  type    = "${lookup(aws_acm_certificate.default.domain_validation_options[count.index], "resource_record_type")}"
  zone_id = "${data.aws_route53_zone.default.0.id}"
  ttl     = 60
  records = ["${lookup(aws_acm_certificate.default.domain_validation_options[count.index], "resource_record_value")}"]
}

resource "aws_acm_certificate_validation" "default" {
  count = "${local.skip_route53_validation ? 0 : 1}"

  certificate_arn         = "${aws_acm_certificate.default.arn}"
  validation_record_fqdns = ["${aws_route53_record.default.*.fqdn}"]
}
