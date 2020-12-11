provider "azurerm" {
  version = "2.25.0"
  features {}
}

resource "random_id" "server" {
  keepers = {
    azi_id = 1
  }

  byte_length = 8
}

resource "azurerm_resource_group" "rg" {
  name     = var.ressource_group_name
  location = var.ressource_group_location
}

resource "azurerm_app_service" "webapp" {
  name                = var.app_service_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
  https_only          = var.https_only
  site_config {
    php_version = var.app_service_php_version
    always_on   = var.always_on
    ftps_state  = var.ftps_state
  }
}
/*
resource "azurerm_app_service" "webapp2" {
  name                = var.app_service_name2
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan2.id
  https_only          = var.https_only
  site_config {
    php_version = var.app_service_php_version
    always_on   = var.always_on
    ftps_state  = var.ftps_state
  }
}*/


resource "azurerm_app_service_plan" "app_service_plan" {
  name                = var.plan_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  kind                = var.kind
  sku {
    tier     = var.sku_tier
    size     = var.sku_size
    capacity = var.sku_capacity
  }
}

/*
resource "azurerm_app_service_plan" "app_service_plan2" {
  name                = var.plan_name2
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  kind                = var.kind
  sku {
    tier     = var.sku_tier
    size     = var.sku_size
    capacity = var.sku_capacity
  }
}*/



resource "azurerm_traffic_manager_profile" "example" {
  name                = "trafik"
  resource_group_name = azurerm_resource_group.rg.name

  traffic_routing_method = "Priority"

  dns_config {
    relative_name = "traffik"
    ttl           = 100
  }

  monitor_config {
    protocol                     = "https"
    port                         = 443
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }

}


resource "azurerm_traffic_manager_endpoint" "primary_endpoint" {
  name                = "Primary Endpoint"
  resource_group_name = azurerm_resource_group.rg.name
  profile_name        = azurerm_traffic_manager_profile.example.name
  target              = azurerm_app_service.webapp.name
  target_resource_id  = azurerm_app_service.webapp.id
  type                = "azureEndpoints"
  priority            = 1
}

/*
resource "azurerm_traffic_manager_endpoint" "failure_endpoint" {
  name                = "Secondary Endpoint"
  resource_group_name = azurerm_resource_group.rg.name
  profile_name        = azurerm_traffic_manager_profile.example.name
  target              = azurerm_app_service.webapp2.name
  target_resource_id  = azurerm_app_service.webapp2.id
  type                = "azureEndpoints"
  weight              = 2
}
*/

resource "azurerm_api_management" "FIRSTAPIM" {
  name                = "APIM-Marchestp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_name      = "ESGI"
  publisher_email     = "esgi@myges.fr"

  sku_name = "Developer_1"
}
/*
resource "azurerm_api_management_api" "example" {
  name                = "MapremiereAPI1"
  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.FIRSTAPIM.name
  revision            = "1"
  display_name        = "FirstAPI"
  path                = "test"
  protocols           = ["https"]

  import {
    content_format = "swagger-link-json"
    content_value  = "http://traffik.trafficmanager.net"
  }
}
*/
resource "azurerm_mysql_server" "rg" {
  name                = var.mysql_server_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  sku_name   = var.sku_name
  storage_mb = var.storage_mb
  version    = var.version_sku

  auto_grow_enabled                = var.auto_grow_enabled
  backup_retention_days            = var.backup_retention_days
  ssl_enforcement_enabled          = var.ssl_enforcement_enabled
  public_network_access_enabled    = var.public_network_access_enabled
  ssl_minimal_tls_version_enforced = var.ssl_minimal_tls_version_enforced
}

resource "azurerm_mysql_database" "dbrg" {
  name                = var.name_database
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_server.rg.name
  charset             = var.charset
  collation           = var.collation
}
resource "azurerm_storage_account" "example" {
  name                     = "hdinsightstor111220"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "example" {
  name                  = "hdinsight"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

resource "azurerm_hdinsight_hadoop_cluster" "example" {
  name                = "projet-hdicluster"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  cluster_version     = "3.6"
  tier                = "Standard"

  component_version {
    hadoop = "2.7"
  }

  gateway {
    enabled  = true
    username = "acctestusrgw"
    password = "TerrAform123!"
  }

  storage_account {
    storage_container_id = azurerm_storage_container.example.id
    storage_account_key  = azurerm_storage_account.example.primary_access_key
    is_default           = true
  }

  roles {
    head_node {
      vm_size  = "Standard_D3_V2"
      username = "acctestusrvm"
      password = "AccTestvdSC4daf986!"
    }

    worker_node {
      vm_size               = "Standard_D4_V2"
      username              = "acctestusrvm"
      password              = "AccTestvdSC4daf986!"
      target_instance_count = 3
    }

    zookeeper_node {
      vm_size  = "Standard_D3_V2"
      username = "acctestusrvm"
      password = "AccTestvdSC4daf986!"
    }
  }
}
