ressource_group_name     = "ESGI-RG"
ressource_group_location = "West Europe"
app_service_name         = "mysuperfirstwebapp"
always_on                = true
ftps_state               = "FtpsOnly"
https_only               = false
app_service_php_version  = "7.2"
plan_name                = "MyAppServicePlan"
sku_tier                 = "Standard"
sku_size                 = "S1"
sku_capacity             = "2"
kind                     = "Windows"
app_service_plan_id      = "15"


plan_name2           = "MySecondAppServicePlan"
app_service_name2    = "mysecondesuperwebapp"
app_service_plan2_id = "16"
mysql_server_name                = "rgprojetsqlserver"
administrator_login              = "mysqladminun"
administrator_login_password     = "H@Sh1CoR3!"
version_sku                      = "5.7"
auto_grow_enabled                = true
backup_retention_days            = 7
ssl_enforcement_enabled          = true
public_network_access_enabled    = true
ssl_minimal_tls_version_enforced = "TLS1_2"
name_database                    = "TEstDB"
charset                          = "utf8"
collation                        = "utf8_unicode_ci"
storage_mb                       = 5120
sku_name                         = "B_Gen5_2"