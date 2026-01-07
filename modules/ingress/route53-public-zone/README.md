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
| [aws_route53_record.acm_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.external_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_records"></a> [acm\_records](#input\_acm\_records) | n/a | `list(object({ name = string, type = string, value = string }))` | `[]` | no |
| <a name="input_alb_dns_ready"></a> [alb\_dns\_ready](#input\_alb\_dns\_ready) | Flag to determine if the ALB Route 53 record should be created | `bool` | `false` | no |
| <a name="input_alb_hosted_zone_id"></a> [alb\_hosted\_zone\_id](#input\_alb\_hosted\_zone\_id) | The DNS ZONE name of the external ALB | `string` | `""` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name for the Route 53 record | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment (prod/non-prod) | `string` | n/a | yes |
| <a name="input_external_alb_dns"></a> [external\_alb\_dns](#input\_external\_alb\_dns) | The DNS name of the external ALB | `string` | `""` | no |
| <a name="input_external_ingress"></a> [external\_ingress](#input\_external\_ingress) | If false, do not create any external ingress resources | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to AWS resources | `map(string)` | n/a | yes |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | The tenant name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_records"></a> [acm\_records](#output\_acm\_records) | ACM DNS validation Route53 records created by this module. |
<!-- END_TF_DOCS -->