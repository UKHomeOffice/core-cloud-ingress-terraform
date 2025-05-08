<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.cert_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.cert_validation_records](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_validation_enabled"></a> [acm\_validation\_enabled](#input\_acm\_validation\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name for the ACM certificate | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment (prod/non-prod) | `string` | n/a | yes |
| <a name="input_hosted_zone_id"></a> [hosted\_zone\_id](#input\_hosted\_zone\_id) | The zone id | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to AWS resources | `map(string)` | n/a | yes |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | The tenant name | `string` | n/a | yes |
| <a name="input_workload"></a> [workload](#input\_workload) | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_certificate_arn"></a> [acm\_certificate\_arn](#output\_acm\_certificate\_arn) | The ARN of the ACM certificate |
| <a name="output_acm_validation_records"></a> [acm\_validation\_records](#output\_acm\_validation\_records) | ACM Certificate DNS Validation Records |
<!-- END_TF_DOCS -->