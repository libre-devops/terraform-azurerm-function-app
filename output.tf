output "fnc_app_id" {
  value       = azurerm_function_app.function_app.id
  description = "The ID of the App Service."
}

output "fnc_app_name" {
  value       = azurerm_function_app.function_app.name
  description = "The name of the App Service."
}

output "outbound_ip_addresses" {
  value       = azurerm_function_app.function_app.outbound_ip_addresses
  description = "A comma separated list of outbound IP addresses"
}

output "possible_outbound_ip_addresses" {
  value       = azurerm_function_app.function_app.possible_outbound_ip_addresses
  description = "A comma separated list of outbound IP addresses. not all of which are necessarily in use"
}

output "fnc_identity" {
  description = "map with key `Function Id`, value `list of identity` created for the Virtual Machine."
  value       = zipmap(azurerm_function_app.function_app.id, azurerm_function_app.function_app.identity)
}

output "custom_domain_vertification_id" {
  value       = azurerm_function_app.function_app.custom_domain_verification_id
  description = "The identifier for DNS txt ownership"
}

output "default_hostname" {
  value       = azurerm_function_app.function_app.default_hostname
  description = "The default hostname for the function app"
}

output "site_credential" {
  value       = azurerm_function_app.function_app.site_credential
  description = "The output of any site credentials"
}

output "kind" {
  value       = azurerm_function_app.function_app.kind
  description = "The kind of the functionapp"
}
