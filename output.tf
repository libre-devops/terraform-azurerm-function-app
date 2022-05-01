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
