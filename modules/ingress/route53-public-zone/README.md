<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.acm_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.external_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.aws_r53_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [time_sleep.wait_30_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_records"></a> [acm\_records](#input\_acm\_records) | n/a | `list(object({ name = string, type = string, value = string }))` | `[]` | no |
| <a name="input_alb_dns_ready"></a> [alb\_dns\_ready](#input\_alb\_dns\_ready) | Flag to determine if the ALB Route 53 record should be created | `bool` | `false` | no |
| <a name="input_alb_hosted_zone_id"></a> [alb\_hosted\_zone\_id](#input\_alb\_hosted\_zone\_id) | The DNS ZONE name of the external ALB | `string` | `""` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name for the Route 53 record | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment (prod/non-prod) | `string` | n/a | yes |
| <a name="input_external_alb_dns"></a> [external\_alb\_dns](#input\_external\_alb\_dns) | The DNS name of the external ALB | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to AWS resources | `map(string)` | n/a | yes |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | The tenant name | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | The hosted zone ID for Route 53 | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hosted_zone_id"></a> [hosted\_zone\_id](#output\_hosted\_zone\_id) | Output the hosted zone ID |
<!-- END_TF_DOCS -->