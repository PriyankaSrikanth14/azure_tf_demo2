data "azurerm_resource_group" "dataexample" {
  name = "docker"
}


resource "azurerm_virtual_network" "demo" {
  name                = "test-vnet"
  location            =  data.azurerm_resource_group.dataexample.location
  resource_group_name =  data.azurerm_resource_group.dataexample.name
  address_space       = ["10.1.0.0/16"]

}