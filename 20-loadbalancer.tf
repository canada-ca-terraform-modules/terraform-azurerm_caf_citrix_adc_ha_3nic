# Loadbalancer PAZ

resource "azurerm_lb" "loadbalancer_paz" {
  count                        = var.deploy ? 1 : 0
  name                = "${local.vm-name}_paz-lb"
  location            = var.location
  resource_group_name = var.resource_group.name
  frontend_ip_configuration {
    name                          = "${local.vm-name}_paz-lbfe"
    private_ip_address_allocation = "Static"
    private_ip_address            = var.lb_private_ip_paz
    subnet_id                     = data.azurerm_subnet.subnet2.id # Client
  }
  sku = "Standard"
}

resource "azurerm_lb_probe" "loadbalancer_paz-TCP9000-lbhp" {
  count                        = var.deploy ? 1 : 0
  resource_group_name = var.resource_group.name
  loadbalancer_id     = azurerm_lb.loadbalancer_paz[0].id
  name                = "${local.vm-name}_paz-TCP9000-lbhp"
  port                = 9000
}

resource "azurerm_lb_backend_address_pool" "loadbalancer-VPXServers_paz-lbbp" {
  count                        = var.deploy ? 1 : 0
  resource_group_name = var.resource_group.name
  loadbalancer_id     = azurerm_lb.loadbalancer_paz[0].id
  name                = "${local.vm-name}_paz-VPXServers-lbbp"
}

resource "azurerm_lb_rule" "loadbalancer_paz-TCP443-lbr" {
  count                        = var.deploy ? 1 : 0
  resource_group_name            = var.resource_group.name
  loadbalancer_id                = azurerm_lb.loadbalancer_paz[0].id
  name                           = "${local.vm-name}_paz-TCP443-lbr"
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  frontend_ip_configuration_name = "${local.vm-name}_paz-lbfe"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.loadbalancer-VPXServers_paz-lbbp[0].id
  probe_id                       = azurerm_lb_probe.loadbalancer_paz-TCP9000-lbhp[0].id
  load_distribution              = "Default"
}

resource "azurerm_lb_rule" "loadbalancer_paz-TCP80-lbr" {
  resource_group_name            = var.resource_group.name
  loadbalancer_id                = azurerm_lb.loadbalancer_paz[0].id
  name                           = "${local.vm-name}_paz-TCP80-lbr"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "${local.vm-name}_paz-lbfe"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.loadbalancer-VPXServers_paz-lbbp[0].id
  probe_id                       = azurerm_lb_probe.loadbalancer_paz-TCP9000-lbhp[0].id
  load_distribution              = "Default"
}

# Loadbalancer OZ

resource "azurerm_lb" "loadbalancer_oz" {
  count                        = var.deploy ? 1 : 0
  name                = "${local.vm-name}_oz-lb"
  location            = var.location
  resource_group_name = var.resource_group.name
  frontend_ip_configuration {
    name                          = "${local.vm-name}_oz-lbfe"
    private_ip_address_allocation = "Static"
    private_ip_address            = var.lb_private_ip_oz
    subnet_id                     = data.azurerm_subnet.subnet3.id # Client
  }
  sku = "Standard"
}

resource "azurerm_lb_probe" "loadbalancer_oz-TCP9000-lbhp" {
  count                        = var.deploy ? 1 : 0
  resource_group_name = var.resource_group.name
  loadbalancer_id     = azurerm_lb.loadbalancer_oz[0].id
  name                = "${local.vm-name}_oz-TCP9000-lbhp"
  port                = 9000
}

resource "azurerm_lb_backend_address_pool" "loadbalancer-VPXServers_oz-lbbp" {
  count                        = var.deploy ? 1 : 0
  resource_group_name = var.resource_group.name
  loadbalancer_id     = azurerm_lb.loadbalancer_oz[0].id
  name                = "${local.vm-name}_oz-VPXServers-lbbp"
}

resource "azurerm_lb_rule" "loadbalancer_oz-TCP443-lbr" {
  count                        = var.deploy ? 1 : 0
  resource_group_name            = var.resource_group.name
  loadbalancer_id                = azurerm_lb.loadbalancer_oz[0].id
  name                           = "${local.vm-name}_oz-TCP443-lbr"
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  frontend_ip_configuration_name = "${local.vm-name}_oz-lbfe"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.loadbalancer-VPXServers_oz-lbbp[0].id
  probe_id                       = azurerm_lb_probe.loadbalancer_oz-TCP9000-lbhp[0].id
  load_distribution              = "Default"
}

resource "azurerm_lb_rule" "loadbalancer_oz-TCP80-lbr" {
  resource_group_name            = var.resource_group.name
  loadbalancer_id                = azurerm_lb.loadbalancer_oz[0].id
  name                           = "${local.vm-name}_oz-TCP80-lbr"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "${local.vm-name}_oz-lbfe"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.loadbalancer-VPXServers_oz-lbbp[0].id
  probe_id                       = azurerm_lb_probe.loadbalancer_oz-TCP9000-lbhp[0].id
  load_distribution              = "Default"
}
