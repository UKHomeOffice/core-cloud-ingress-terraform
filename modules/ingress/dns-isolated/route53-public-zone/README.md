# Configures Wildcard DNS records pointing to NLB
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
| [aws_route53_record.external_nlb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name for the Route 53 record | `string` | n/a | yes |
| <a name="input_nlb_name"></a> [nlb\_name](#input\_nlb\_name) | nlb name | `string` | n/a | yes |
| <a name="input_nlb_zone"></a> [nlb\_zone](#input\_nlb\_zone) | nlb dns zone | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->