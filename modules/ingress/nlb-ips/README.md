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
| [aws_network_interface.external_nlb_ips](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/network_interface) | data source |
| [aws_network_interfaces.external_nlb_ifs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/network_interfaces) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apply_only"></a> [apply\_only](#input\_apply\_only) | Define the variable | `bool` | `false` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | The tenant name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_external_nlb_network_interface_ips"></a> [aws\_external\_nlb\_network\_interface\_ips](#output\_aws\_external\_nlb\_network\_interface\_ips) | n/a |
<!-- END_TF_DOCS -->