# Azure OpenAI access for Azure Gov

The Azure OpenAI service is not at the time of this writing is only available in Azure public regions, and not Azure Government. This process outlines an option for creating private access from an Azure Government subscription to access the Azure OpenAI service running in Azure Public.

## Requirements

Access to both Azure Public and Azure Government is required, with the ability to route private network traffic betweent the two environments. This could be a direct VPN connection betweent the two, or other similar capability.

- Azure Public and Azure Government subscriptions
- New or existing network connectivity between Azure Public and Azure Gov.

## Template

The template to deploy the Azure OpenAI service with a Private Endpoint is run in the Azure Public subscription.

### Variables

```yaml
variable "location" {
  description = "The location/region where the resource group is created."
  type        = string
  default     = "eastus"
}

variable tags {
    owner       = "POC"
    projectName = "OpenAI-Private-Endpoint"
}

variable "pe_subnet_reference" {
  description = "The subnet to deploy the private endpoint to."
  type = object({
    subnet_name          = string
    virtual_network_name = string
    resource_group_name  = string
  })
}
```

|Variable|Description|
|---|---|
|location|Azure Region (Public)|
|tags|Azure resource tags. Important if there are required tags for creation of Resource Groups|
|pe_subnet_reference|Reference for a subnet to deploy the Private Endpoint network interface resource. Network must allow HTTPS/443 access from the Azure Government network.|