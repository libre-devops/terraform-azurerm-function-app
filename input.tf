variable "active_directory_auth_setttings" {
  description = "Acitve directory authentication provider settings for app service"
  type        = any
  default     = {}
}

variable "app_amount" {
  description = "The amount of apps to be created"
  type        = number
}

variable "app_name" {
  description = "The name of the function app"
  type        = string
}

variable "app_service_plan_id" {
  description = "Id of the App Service Plan for Function App hosting"
  type        = string
}

variable "application_insights_enabled" {
  description = "Enable or disable the Application Insights deployment"
  type        = bool
  default     = true
}

variable "application_insights_id" {
  description = "ID of the existing Application Insights to use instead of deploying a new one."
  type        = string
  default     = null
}

variable "application_insights_type" {
  description = "Application Insights type if need to be generated"
  type        = string
  default     = "web"
}

variable "application_zip_package_path" {
  description = "Local or remote path of a zip package to deploy on the Function App"
  type        = string
  default     = null
}

variable "authorized_ips" {
  description = "IPs restriction for Function. See documentation https://www.terraform.io/docs/providers/azurerm/r/function_app.html#ip_restriction"
  type        = list(string)
  default     = []
}

variable "authorized_subnet_ids" {
  description = "Subnets restriction for Function. See documentation https://www.terraform.io/docs/providers/azurerm/r/function_app.html#ip_restriction"
  type        = list(string)
  default     = []
}

variable "backup_settings" {
  description = "Backup settings for App service"
  type = object({
    name                     = string
    enabled                  = bool
    storage_account_url      = optional(string)
    frequency_interval       = number
    frequency_unit           = optional(string)
    retention_period_in_days = optional(number)
    start_time               = optional(string)
  })
  default = {
    enabled                  = false
    name                     = "DefaultBackup"
    frequency_interval       = 1
    frequency_unit           = "Day"
    retention_period_in_days = 1
  }
}

variable "connection_strings" {
  description = "Connection strings for App Service"
  type        = list(map(string))
  default     = []
}

variable "custom_domains" {
  description = "Custom domains with SSL binding and SSL certificates for the App Service. Getting the SSL certificate from an Azure Keyvault Certificate Secret or a file is possible."
  type        = map(map(string))
  default     = null
}

variable "default_auth_provider" {
  description = "The default provider to use when multiple providers have been set up. Possible values are `AzureActiveDirectory`, `Facebook`, `Google`, `MicrosoftAccount` and `Twitter`"
  default     = "AzureActiveDirectory"
}

variable "disable_ip_masking" {
  description = "By default the real client ip is masked as `0.0.0.0` in the logs. Use this argument to disable masking and log the real client ip"
  default     = false
}

variable "enable_backup" {
  description = "bool to to setup backup for app service "
  default     = false
}

variable "enable_client_affinity" {
  description = "Should the App Service send session affinity cookies, which route client requests in the same session to the same instance?"
  default     = false
}

variable "enable_client_certificate" {
  description = "Does the App Service require client certificates for incoming requests"
  default     = false
}

variable "enable_https" {
  description = "Can the App Service only be accessed via HTTPS?"
  default     = false
}

variable "function_app_application_settings" {
  description = "Function App application settings"
  type        = map(string)
  default     = {}
}

variable "function_app_version" {
  description = "Version of the function app runtime to use (Allowed values 2 or 3)"
  type        = string
  default     = "~3"
}

variable "function_app_vnet_integration_enabled" {
  description = "Enable VNET integration with the Function App. `function_app_vnet_integration_subnet_id` is mandatory if enabled"
  type        = bool
  default     = false
}

variable "function_app_vnet_integration_subnet_id" {
  description = "ID of the subnet to associate with the Function App (VNet integration)"
  type        = string
  default     = null
}

# SCM parameters

variable "function_language_for_linux" {
  description = "Language of the Function App on Linux hosting, can be \"dotnet\", \"node\" or \"python\""
  type        = string
  default     = "dotnet"
}

variable "https_only" {
  description = "Disable http procotol and keep only https"
  type        = bool
  default     = true
}

variable "identity_ids" {
  description = "UserAssigned Identities ID to add to Function App. Mandatory if type is UserAssigned"
  type        = list(string)
  default     = null
}

variable "identity_type" {
  description = "Add an Identity (MSI) to the function app. Possible values are SystemAssigned or UserAssigned"
  type        = string
  default     = "SystemAssigned"
}

variable "ip_restriction_headers" {
  description = "IPs restriction headers for Function. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app#headers"
  type        = map(list(string))
  default     = null
}

variable "location" {
  description = "Azure location."
  type        = string
}

variable "os_type" {
  description = "A string indicating the Operating System type for this function app."
  type        = string
  default     = null
}

variable "password_end_date" {
  description = "The relative duration or RFC3339 rotation timestamp after which the password expire"
  default     = null
}

variable "password_rotation_in_years" {
  description = "Number of years to add to the base timestamp to configure the password rotation timestamp. Conflicts with password_end_date and either one is specified and not the both"
  default     = 2
}

variable "retention_in_days" {
  description = "Specifies the retention period in days. Possible values are `30`, `60`, `90`, `120`, `180`, `270`, `365`, `550` or `730`"
  default     = 90
}

variable "rg_name" {
  description = "Resource group name"
  type        = string
}

variable "scm_authorized_ips" {
  description = "SCM IPs restriction for Function. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app#scm_ip_restriction"
  type        = list(string)
  default     = []
}

variable "scm_authorized_subnet_ids" {
  description = "SCM subnets restriction for Function. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app#scm_ip_restriction"
  type        = list(string)
  default     = []
}

variable "scm_ip_restriction_headers" {
  description = "IPs restriction headers for Function. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app#scm_ip_restriction"
  type        = map(list(string))
  default     = null
}

variable "scm_subnets" {
  description = "Subnets for SCM"
  type        = list(string)
}

variable "settings" {
  description = "Specifies the Authenication enabled or not"
  default     = false
}

variable "site_config" {
  description = "Site config for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#site_config. IP restriction attribute is not managed in this block."
  type        = any
  default     = {}
}

variable "storage_account_access_key" {
  description = "Access key the storage account to use. If null a new storage account is created"
  type        = string
  default     = null
}

variable "storage_account_name" {
  description = "Name of storage account"
  type        = string
}

variable "storage_container_name" {
  description = "The name of the storage container to keep backups"
  default     = null
}

variable "storage_mounts" {
  description = "Storage account mount points for App Service"
  type        = list(map(string))
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "A map of the tags to use on the resources that are deployed with this module."
  default = {
    source = "terraform"
  }
}

variable "token_store_enabled" {
  description = "If enabled the module will durably store platform-specific security tokens that are obtained during login flows"
  default     = false
}

variable "unauthenticated_client_action" {
  description = "The action to take when an unauthenticated client attempts to access the app. Possible values are `AllowAnonymous` and `RedirectToLoginPage`"
  default     = "RedirectToLoginPage"
}
