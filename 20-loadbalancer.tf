resource "azurerm_lb" "loadbalancer" {
  count                        = var.deploy ? 1 : 0
  name                = "${local.vm-name}-lb"
  location            = var.location
  resource_group_name = var.resource_group.name
  frontend_ip_configuration {
    name                          = "${local.vm-name}-lbfe"
    private_ip_address_allocation = "Static"
    private_ip_address            = var.lb_private_ip
    subnet_id                     = data.azurerm_subnet.subnet2.id # Client
  }
  sku = "Standard"
}

resource "azurerm_lb_probe" "loadbalancer-TCP9000-lbhp" {
  count                        = var.deploy ? 1 : 0
  resource_group_name = var.resource_group.name
  loadbalancer_id     = azurerm_lb.loadbalancer[0].id
  name                = "${local.vm-name}-TCP9000-lbhp"
  port                = 9000
}

resource "azurerm_lb_backend_address_pool" "loadbalancer-VPXServers-lbbp" {
  count                        = var.deploy ? 1 : 0
  resource_group_name = var.resource_group.name
  loadbalancer_id     = azurerm_lb.loadbalancer[0].id
  name                = "${local.vm-name}-VPXServers-lbbp"
}

resource "azurerm_lb_rule" "loadbalancer-TCP443-lbr" {
  count                        = var.deploy ? 1 : 0
  resource_group_name            = var.resource_group.name
  loadbalancer_id                = azurerm_lb.loadbalancer[0].id
  name                           = "${local.vm-name}-TCP443-lbr"
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  frontend_ip_configuration_name = "${local.vm-name}-lbfe"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.loadbalancer-VPXServers-lbbp[0].id
  probe_id                       = azurerm_lb_probe.loadbalancer-TCP9000-lbhp[0].id
  load_distribution              = "Default"
}

resource "azurerm_lb_rule" "loadbalancer-TCP80-lbr" {
  resource_group_name            = var.resource_group.name
  loadbalancer_id                = azurerm_lb.loadbalancer[0].id
  name                           = "${local.vm-name}-TCP80-lbr"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "${local.vm-name}-lbfe"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.loadbalancer-VPXServers-lbbp[0].id
  probe_id                       = azurerm_lb_probe.loadbalancer-TCP9000-lbhp[0].id
  load_distribution              = "Default"
}
