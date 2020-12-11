variable "ressource_group_name" {
  type    = string
  default = ""
}

variable "ressource_group_location" {
  type    = string
  default = "West Europe"
}

variable "app_service_name" {
  type    = string
  default = ""
}


variable "app_service_name2" {
  type    = string
  default = ""
}


variable "always_on" {
  type        = bool
  default     = true
  description = " Should the app be loaded at all times?"
}

variable "ftps_state" {
  type        = string
  default     = "FtpsOnly"
  description = "State of FTP / FTPS service for this App Service. Possible values include: AllAllowed, FtpsOnly and Disabled"
}

variable "https_only" {
  type        = bool
  default     = true
  description = "Can the App Service only be accessed via HTTPS?"
}

variable "app_service_php_version" {
  type        = string
  default     = "7.2"
  description = "The php version to use"
}

variable "plan_name" {
  type    = string
  default = ""
}
variable "plan_name2" {
  type    = string
  default = ""
}

variable "app_service_plan_id" {
  type        = string
  description = "Id of the app service plan"
}


variable "app_service_plan2_id" {
  type        = string
  description = "Id of the app service plan"
}

variable "sku_tier" {
  type        = string
  default     = "Standard"
  description = "Specifies the plan's pricing tier"
}

variable "sku_size" {
  type        = string
  default     = "S1"
  description = "Specifies the plan's instance size"
}

variable "sku_capacity" {
  type        = string
  default     = "2"
  description = "Specifies the number of workers associated with this app service plan"
}

variable "kind" {
  type        = string
  default     = "Windows"
  description = "The kind of the App Service Plan to create. Possible values are Windows (also available as App), Linux, elastic (for Premium Consumption) and FunctionApp (for a Consumption Plan). Defaults to Windows. Changing this forces a new resource to be created."
}

variable "mysql_server_name" {
  type    = string
  default = ""
}

variable "administrator_login" {
  type    = string
  default = "mysqladminun"
}

variable "administrator_login_password" {
  type    = string
  default = "H@Sh1CoR3"
}

variable "sku_name" {
  type    = string
  default = "B_Gen5_2"
}

variable "storage_mb" {
  type    = string
  default = "5120"
}

variable "version_sku" {
  type    = string
  default = "5.7"
}

variable "auto_grow_enabled" {
  type    = string
  default = "true"
}

variable "backup_retention_days" {
  type    = string
  default = "7"
}

variable "ssl_enforcement_enabled" {
  type    = string
  default = "true"
}

variable "public_network_access_enabled" {
  type    = string
  default = "true"
}

variable "ssl_minimal_tls_version_enforced" {
  type    = string
  default = "TLS1_2"
}
variable "name_database" {
  type    = string
  default = "DBSQL"
}

variable "charset" {
  type    = string
  default = "utf8"
}

variable "collation" {
  type    = string
  default = "utf8_unicode_ci"
}