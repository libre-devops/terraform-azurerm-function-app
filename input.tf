variable "app_name" {
  description = "The name of the function app"
  type = string
}

variable "app_amount" {
  description = "The amount of apps to be created"
  type = number
}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "stack" {
  description = "Project stack name"
  type        = string
}

variable "storage_account_name" {
  description = "Name of storage account"
  type = string
}

variable "tags" {
  type        = map(string)
  description = "A map of the tags to use on the resources that are deployed with this module."
  default = {
    source = "terraform"
  }
}

variable "rg_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure location."
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

variable "function_app_version" {
  description = "Version of the function app runtime to use (Allowed values 2 or 3)"
  type        = number
  default     = 3
}

variable "storage_account_access_key" {
  description = "Access key the storage account to use. If null a new storage account is created"
  type        = string
  default     = null
}

variable "scm_subnets" {
  description = "Subnets for SCM"
  type = list(string)
}

variable "scm_cidrs" {
  description = "CIDRs for SCM"
  type = list(string)
}

variable "scm_service_tags" {
  description = "Service tags for SCM"
  type = list(string)
}

variable "storage_account_kind" {
  description = "Storage Account Kind"
  type        = string
  default     = "StorageV2"
}

variable "storage_account_min_tls_version" {
  description = "Storage Account minimal TLS version"
  type        = string
  default     = "TLS1_2"
}

variable "storage_account_enable_advanced_threat_protection" {
  description = "Boolean flag which controls if advanced threat protection is enabled, see [here](https://docs.microsoft.com/en-us/azure/storage/common/storage-advanced-threat-protection?tabs=azure-portal) for more information."
  type        = bool
  default     = false
}

variable "storage_account_enable_https_traffic_only" {
  description = "Boolean flag which controls if https traffic only is enabled."
  type        = bool
  default     = true
}

variable "app_service_plan_id" {
  description = "Id of the App Service Plan for Function App hosting"
  type        = string
}

variable "function_language_for_linux" {
  description = "Language of the Function App on Linux hosting, can be \"dotnet\", \"node\" or \"python\""
  type        = string
  default     = "dotnet"
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

variable "function_app_application_settings" {
  description = "Function App application settings"
  type        = map(string)
  default     = {}
}

variable "identity_type" {
  description = "Add an Identity (MSI) to the function app. Possible values are SystemAssigned or UserAssigned"
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "UserAssigned Identities ID to add to Function App. Mandatory if type is UserAssigned"
  type        = list(string)
  default     = null
}

variable "os_type" {
  description = "A string indicating the Operating System type for this function app."
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

variable "ip_restriction_headers" {
  description = "IPs restriction headers for Function. See documentation https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app#headers"
  type        = map(list(string))
  default     = null
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

variable "site_config" {
  description = "Site config for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#site_config. IP restriction attribute is not managed in this block."
  type        = any
  default     = {}
}

variable "https_only" {
  description = "Disable http procotol and keep only https"
  type        = bool
  default     = true
}

variable "application_zip_package_path" {
  description = "Local or remote path of a zip package to deploy on the Function App"
  type        = string
  default     = null
}