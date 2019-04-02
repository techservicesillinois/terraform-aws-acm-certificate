# acm-certificate 

Provides an ACM Certificate resource

Example Usage
-----------------

Route53 Hosted Domain
---------------------

This configuration creates an ACM certificate for `bar.example.com` with `foo.example.com` as a subject 
alternative name (SAN). This example will automatically create DNS validation records in the example.com 
Route53 zone.

```hcl
module "route53" {
    source = "git::git@github.com:techservicesillinois/terraform-aws-acm-certificate.git//?ref=v1.0.0"

    hostname = "bar"

    subject_alternative_names = [
      "foo"
    ]

    domain = "example.com"
}
```

Domain not hosted by Route53
-----------------------------

This configuration creates an ACM certificate for `authman.example.org` with `authbot.example.org` as a subject 
alternative name (SAN). This example requires manual creation of DNS records for certificat validations.



```hcl
module "external" {
    source = "git::git@github.com:techservicesillinois/terraform-aws-acm-certificate.git//?ref=v1.0.0"

    hostname = "authman"

    subject_alternative_names = [ 
      "authbot"
    ]

    domain = "example.org"
    skip_route53_validation = true

    tags { 
      environment = "test"
    }
}
```

Argument Reference
-----------------

The following arguments are supported:

* `domain` - (Required) Domain name of the certificate

* `hostname` - (Required) Hostname of the certificate

* `validation_method` - Which method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform.

* `subject_alternative_names` - A list of domains that should be SANs in the issued certificate

* `skip_route53_validation` - Set to true for zones not hosted in Route53

* `create_route53_record` - Set to false if Route53 record already exists

* `tags` - A mapping of tags

Attributes Reference
--------------------

The following attributes are exported:

* `domain_validation_options ` - A list of attributes to feed into other resources to complete certificate validation. 

Credits
--------------------

**Nota bene** the vast majority of the verbiage on this page was
taken directly from the Terraform manual, and in a few cases from
Amazon's documentation.

Import
--------------------

A certificate can be imported using its ARN:

```
terraform import aws_acm_certificate.default arn:aws:acm:us-east2-1:123456789012:certificate/7e7a28d2-163f-4b8f-b9cd-822f96c08d6a
```


Route53 Records can be imported using the ID of the record. The ID is made up as ZONEID_RECORDNAME_CNAME:

```
terraform import aws_route53_record.default ZE2XGDR9HNNCQ__6f02f830b9c923aca5a897d8ca5ba83b.multi-service.as-test.techservices.illinois.edu_CNAME
```


