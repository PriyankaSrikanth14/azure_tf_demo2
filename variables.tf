variable "prefix" {
	description = "Prefix for all the resources"
}

variable "region" {
  
  description = "Location where the resource group and resources are created"
}

variable "vnet_cidr" {
    default = "10.0.0.0/16"
    
}

variable "vm_size" {
    default = "Standard_B1s"
}

variable "vm_username" {
    default = "adminuser"
}

variable "vm_count" {
    default = 1
    description = "Number of VMs"

}
