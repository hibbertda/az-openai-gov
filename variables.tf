variable "location" {
  description = "The location/region where the resource group is created."
  type        = string
  default     = "eastus"
}

variable tags {
    owner       = "Daniel Hibbert"
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