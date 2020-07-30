output "vm1" {
  value = var.deploy ? azurerm_linux_virtual_machine.VM1[0] : null
}

output "vm2" {
  value = var.deploy ? azurerm_linux_virtual_machine.VM2[0] : null
}

output "nic1-1" {
  value = var.deploy ? azurerm_network_interface.NIC1-1[0] : null
}

output "nic2-1" {
  value = var.deploy ? azurerm_network_interface.NIC2-1[0] : null
}

output "nic3-1" {
  value = var.deploy ? azurerm_network_interface.NIC3-1[0] : null
}

output "nic1-2" {
  value = var.deploy ? azurerm_network_interface.NIC1-2[0] : null
}

output "nic2-2" {
  value = var.deploy ? azurerm_network_interface.NIC2-2[0] : null
}

output "nic3-2" {
  value = var.deploy ? azurerm_network_interface.NIC3-2[0] : null
}

