provider "azurerm" {
  features {
    
  }
}

resource "azurerm_resource_group" "RG-SPDomainController" {
  
  name = "RG-SPDomainController"
  location = "northeurope"
}

resource "azurerm_resource_group" "RG-SPNetworkComponents" {
  
  name = "RG-SPNetworkComponents"
  location = "northeurope"
}

resource "azurerm_resource_group" "RG-SPWebServers" {
  
  name = "RG-SPWebServers"
  location = "northeurope"
}

resource "azurerm_resource_group" "RG-SPAppServers" {
  
  name = "RG-SPAppServers"
  location = "northeurope"
}

resource "azurerm_resource_group" "RG-SPDBServers" {
  
  name = "RG-SPDBServers"
  location = "northeurope"
}

resource "azurerm_resource_group" "RG-SPStorageAccount" {
  
  name = "RG-SPStorageAccount"
  location = "northeurope"
}

resource "azurerm_resource_group" "RG-SPSearchServers" {
  
  name = "RG-SPSearchServers"
  location = "northeurope"
}

resource "azurerm_resource_group" "RG-SPSearchWebServers" {
  
  name = "RG-SPSearchWebServers"
  location = "northeurope"
}

resource "azurerm_virtual_network" "SP-Virtual-Network" {
  
  name = "SP-Virtual-Network"
  resource_group_name = azurerm_resource_group.RG-SPNetworkComponents.name
  location = azurerm_resource_group.RG-SPNetworkComponents.location
  address_space = ["10.0.0.0/16"]

}

resource "azurerm_subnet" "SP-Web-Server-Subnet" {
  
    name = "SP-Web-Server-Subnet"
    resource_group_name = azurerm_resource_group.RG-SPNetworkComponents.name
    address_prefix = "10.0.2.0/24"
    virtual_network_name = azurerm_virtual_network.SP-Virtual-Network.name

}

resource "azurerm_subnet" "SP-Domain-Controller-Subnet" {
    name = "SP-Domain-Controller-Subnet"
    address_prefix = "10.0.1.0/24"
    resource_group_name = azurerm_resource_group.RG-SPNetworkComponents.name
    virtual_network_name = azurerm_virtual_network.SP-Virtual-Network.name

  } 
  
  resource "azurerm_subnet" "SP-App-Server-Subnet" {
    name = "SP-App-Server-Subnet"
    address_prefix = "10.0.3.0/24"
    resource_group_name = azurerm_resource_group.RG-SPNetworkComponents.name
    virtual_network_name = azurerm_virtual_network.SP-Virtual-Network.name

  }
  resource "azurerm_subnet" "SP-Search-Server-Subnet" {
    name = "SP-Search-Server-Subnet"
    address_prefix = "10.0.4.0/24"
    resource_group_name = azurerm_resource_group.RG-SPNetworkComponents.name
    virtual_network_name = azurerm_virtual_network.SP-Virtual-Network.name

  } 
  resource "azurerm_subnet" "SP-Search-Web-Server-Subnet" {
    name = "SP-Search-Web-Server-Subnet"
    address_prefix = "10.0.5.0/24"
    resource_group_name = azurerm_resource_group.RG-SPNetworkComponents.name
    virtual_network_name = azurerm_virtual_network.SP-Virtual-Network.name

  } 
  resource "azurerm_subnet" "SP-DB-Server-Subnet" {
    name = "SP-DB-Server-Subnet"
    address_prefix = "10.0.6.0/24"
    resource_group_name = azurerm_resource_group.RG-SPNetworkComponents.name
    virtual_network_name = azurerm_virtual_network.SP-Virtual-Network.name

  } 

resource "azurerm_availability_set" "SP-Web-Server-Availability-Set" {
    name = "SP-Web-Server-Availability-Set"
    resource_group_name = azurerm_resource_group.RG-SPWebServers.name
    location = azurerm_resource_group.RG-SPWebServers.location
    platform_fault_domain_count = "3"
    platform_update_domain_count = "3"

}

resource "azurerm_availability_set" "SP-App-Server-Availability-Set" {
    name = "SP-Web-Server-Availability-Set"
    resource_group_name = azurerm_resource_group.RG-SPAppServers.name
    location = azurerm_resource_group.RG-SPAppServers.location
    platform_fault_domain_count = "3"
    platform_update_domain_count = "3"
    
}

resource "azurerm_availability_set" "SP-Search-Server-Availability-Set" {
    name = "SP-Web-Server-Availability-Set"
    resource_group_name = azurerm_resource_group.RG-SPSearchServers.name  
    location = azurerm_resource_group.RG-SPSearchServers.location
    platform_fault_domain_count = "2"
    platform_update_domain_count = "2"
    
}

resource "azurerm_availability_set" "SP-DC-Server-Availability-Set" {
    name = "SP-DC-Server-Availability-Set"
    resource_group_name = azurerm_resource_group.RG-SPDomainController.name
    location = azurerm_resource_group.RG-SPDomainController.location
    platform_fault_domain_count = "2"
    platform_update_domain_count = "2"
    
}

resource "azurerm_availability_set" "SP-DB-Server-Availability-Set" {
    name = "SP-DB-Server-Availability-Set"
    resource_group_name = azurerm_resource_group.RG-SPDBServers.name
    location = azurerm_resource_group.RG-SPDBServers.location
    platform_fault_domain_count = "2"
    platform_update_domain_count = "2"
    
}

resource "azurerm_availability_set" "SP-Search-Web-Server-Availability-Set" {
    name = "SP-Search-Web-Server-Availability-Set"
    resource_group_name = azurerm_resource_group.RG-SPSearchWebServers.name
    location = azurerm_resource_group.RG-SPSearchWebServers.location
    platform_fault_domain_count = "2"
    platform_update_domain_count = "2"
    
}

resource "azurerm_network_security_group" "SP-Web-Server-NSG" {
    name = "SP-Web-Server-NSG"
    resource_group_name = azurerm_resource_group.RG-SPNetworkComponents.name
    location = azurerm_resource_group.RG-SPNetworkComponents.location
      
}

resource "azurerm_subnet_network_security_group_association" "Web-Server-Asg" {
    network_security_group_id = azurerm_network_security_group.SP-Web-Server-NSG.id
    subnet_id = azurerm_subnet.SP-Web-Server-Subnet.id
  
}


resource "azurerm_network_security_group" "SP-App-Server-NSG" {
    name = "SP-App-Server-NSG"
    resource_group_name = azurerm_resource_group.RG-SPNetworkComponents.name
    location = azurerm_resource_group.RG-SPNetworkComponents.location
}


resource "azurerm_subnet_network_security_group_association" "App-Server-Asg" {
    network_security_group_id = azurerm_network_security_group.SP-App-Server-NSG.id
    subnet_id = azurerm_subnet.SP-App-Server-Subnet.id
  
}


resource "azurerm_network_security_group" "SP-Search-Server-NSG" {
    name = "SP-Search-Server-NSG"
    resource_group_name = azurerm_resource_group.RG-SPNetworkComponents.name
    location = azurerm_resource_group.RG-SPNetworkComponents.location
}

resource "azurerm_subnet_network_security_group_association" "Search-Server-Asg" {
    network_security_group_id = azurerm_network_security_group.SP-Search-Server-NSG.id
    subnet_id = azurerm_subnet.SP-Search-Server-Subnet.id
  
}


resource "azurerm_network_security_group" "SP-Search-Web-Server-NSG" {
    name = "SP-Search-Web-Server-NSG"
    resource_group_name = azurerm_resource_group.RG-SPNetworkComponents.name
    location = azurerm_resource_group.RG-SPNetworkComponents.location
}


resource "azurerm_subnet_network_security_group_association" "Search-Web-Server-Asg" {
    network_security_group_id = azurerm_network_security_group.SP-Search-Web-Server-NSG.id
    subnet_id = azurerm_subnet.SP-Search-Web-Server-Subnet.id
  
}


resource "azurerm_network_security_group" "SP-DC-Server-NSG" {
    name = "SP-DC-Server-NSG"
    resource_group_name = azurerm_resource_group.RG-SPNetworkComponents.name
    location = azurerm_resource_group.RG-SPNetworkComponents.location
}


resource "azurerm_subnet_network_security_group_association" "DC-Server-Asg" {
    network_security_group_id = azurerm_network_security_group.SP-DC-Server-NSG.id
    subnet_id = azurerm_subnet.SP-Domain-Controller-Subnet.id
  
}


resource "azurerm_network_security_group" "SP-DB-Server-NSG" {
    name = "SP-DB-Server-NSG"
    resource_group_name = azurerm_resource_group.RG-SPNetworkComponents.name
    location = azurerm_resource_group.RG-SPNetworkComponents.location
}

resource "azurerm_subnet_network_security_group_association" "DB-Server-Asg" {
    network_security_group_id = azurerm_network_security_group.SP-DB-Server-NSG.id
    subnet_id = azurerm_subnet.SP-DB-Server-Subnet.id
  
}


resource "azurerm_network_interface" "SP-Web-Server-01-NIC" {
  name = "SP-Web-Server-01-NIC"
  location = azurerm_resource_group.RG-SPWebServers.location
  resource_group_name = azurerm_resource_group.RG-SPWebServers.name
  ip_configuration {
    name = "SP-Web-Server-01-NIC-IP-Config"
    subnet_id = azurerm_subnet.SP-Web-Server-Subnet.id
    private_ip_address_allocation = "Dynamic"
    

  }
  
}

resource "azurerm_virtual_machine" "WebServer01" {
    name = "WebServer01"
    resource_group_name = azurerm_resource_group.RG-SPWebServers.name
    location = azurerm_resource_group.RG-SPWebServers.location
    availability_set_id = azurerm_availability_set.SP-Web-Server-Availability-Set.id
    network_interface_ids = [azurerm_network_interface.SP-Web-Server-01-NIC.id]
    vm_size = "Standard_B1s"
    
    os_profile {
      computer_name = "WebServer01"
      admin_username = "chiragmehta"
      admin_password = "Housenumber@1234"
    }

    storage_image_reference {
      publisher                   = "MicrosoftWindowsServer"
      offer                       = "WindowsServerSemiAnnual"
      sku                         = "Datacenter-Core-1709-smalldisk"
      version                     = "latest"
    }
  
    storage_os_disk {
      name      = "myosdisk1"
      caching   = "ReadWrite"
      managed_disk_type = "Premium_LRS"
      create_option = "FromImage"
    }
    os_profile_windows_config {
      
     }
    
  
  
}


resource "azurerm_public_ip" "Public-IP-LB" {
  name = "Public-IP-LB"
  allocation_method = "Static"
  resource_group_name = azurerm_resource_group.RG-SPNetworkComponents.name
  location = azurerm_resource_group.RG-SPNetworkComponents.location
  
}

resource "azurerm_lb" "SP-Web-Server-LB" {
  name = "SP-Web-Server-LB"
  location = azurerm_resource_group.RG-SPNetworkComponents.location
  resource_group_name = azurerm_resource_group.RG-SPNetworkComponents.name
  sku = "Standard"
  sku_tier = "Regional"
  frontend_ip_configuration {
    name = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.Public-IP-LB.id

  }
}
