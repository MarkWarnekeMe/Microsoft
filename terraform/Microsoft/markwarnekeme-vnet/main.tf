resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.main.name
  }

  byte_length = 10
}

locals {
  fixed_tags = {
    id        = random_id.randomId.hex
    terraform = "true"
  }

  tags = merge(var.tags, local.fixed_tags)
}


resource "azurerm_virtual_network" "main" {
  name                = format("%s%s", var.name, "-vnet")
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = ["192.168.0.0/16"]

  tags = local.tags
}

resource "azurerm_subnet" "backend" {
  name                 = format("%s%s", var.name, "-backend")
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["192.168.0.0/24"]
}

resource "azurerm_network_security_group" "deny" {
  name                = format("%s%s", var.name, "-deny-nsg")
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "restrict"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "backend-deny" {
  subnet_id                 = azurerm_subnet.backend.id
  network_security_group_id = azurerm_network_security_group.deny.id
}


resource "azurerm_subnet" "backend_virtual_node" {
  name                 = format("%s%s", var.name, "-backend-aci")
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["192.168.1.0/24"]

  delegation {
    name = "aciDelegation"
    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "backend-aci-deny" {
  subnet_id                 = azurerm_subnet.backend_virtual_node.id
  network_security_group_id = azurerm_network_security_group.deny.id
}

resource "azurerm_subnet" "frontend" {
  name                 = format("%s%s", var.name, "-frontend")
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["192.168.2.0/25"]
}

resource "azurerm_network_security_group" "allow80" {
  name                = format("%s%s", var.name, "-allow-nsg")
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "allow"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "80"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "frontend-allow80" {
  subnet_id                 = azurerm_subnet.frontend.id
  network_security_group_id = azurerm_network_security_group.allow80.id
}