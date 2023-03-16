locals {
  rg_name         = "rg-openai-pe-${var.location}"
  cogOpenAI_name  = "cog-openai-pe-${var.location}"
}


# data source azure subnet
data "azurerm_subnet" "private_endpoint" {
  name                 = var.pe_subnet_reference.subnet_name
  virtual_network_name = var.pe_subnet_reference.virtual_network_name
  resource_group_name  = var.pe_subnet_reference.resource_group_name
}

# create resource group
resource "azurerm_resource_group" "openai" {
  name     = local.rg_name
  location = var.location
  tags     = var.tags
}

# Deploy Azure openai cognitive service
resource "azurerm_cognitive_account" "openai" {
  name                    = local.cogOpenAI_name
  location                = azurerm_resource_group.openai.location
  resource_group_name     = azurerm_resource_group.openai.name
  kind                    = "OpenAI"
  sku_name                = "S0"
  custom_subdomain_name   = "openai-pet"
  tags                    = var.tags
}

# private endpoint for openai cognitive service
resource "azurerm_private_endpoint" "openai" {
  name                = "pe-${local.cogOpenAI_name}"
  location            = azurerm_resource_group.openai.location
  resource_group_name = azurerm_resource_group.openai.name
  subnet_id           = data.azurerm_subnet.private_endpoint.id
  private_service_connection {
    name                           = "openai-pet"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_cognitive_account.openai.id
    subresource_names              = ["account"]
  }
}