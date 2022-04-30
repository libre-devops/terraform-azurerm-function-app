resource "azurerm_function_app" "function_app" {
  count = var.app_amount
  name = "${var.app_name}${format("%02d", count.index + 1)}"
  app_service_plan_id        = var.app_service_plan_id
  location                   = var.location
  resource_group_name        = var.rg_name
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  os_type                    = var.os_type
  https_only = var.https_only

  app_settings = var.function_app_application_settings

  dynamic "site_config" {
    for_each = [var.site_config]
    content {
      always_on                   = lookup(site_config.value, "always_on", null)
      ftps_state                  = lookup(site_config.value, "ftps_state", null)
      http2_enabled               = lookup(site_config.value, "http2_enabled", null)
      ip_restriction              = lookup(site_config.value, "ip_restriction", null)
      linux_fx_version            = lookup(site_config.value, "linux_fx_version", null)
      min_tls_version             = lookup(site_config.value, "min_tls_version", null)
      pre_warmed_instance_count   = lookup(site_config.value, "pre_warmed_instance_count", null)
      scm_use_main_ip_restriction = var.scm_authorized_ips != [] || var.scm_authorized_subnet_ids != null || lookup(site_config.value, "scm_ip_restriction", null) != null ? false : true
      scm_ip_restriction          = concat(var.scm_subnets, var.scm_cidrs, var.scm_service_tags, lookup(site_config.value, "scm_ip_restriction", []))
      scm_type                    = lookup(site_config.value, "scm_type", null)
      use_32_bit_worker_process   = lookup(site_config.value, "use_32_bit_worker_process", null)
      websockets_enabled          = lookup(site_config.value, "websockets_enabled", null)

      dynamic "cors" {
        for_each = lookup(site_config.value, "cors", []) != [] ? ["fake"] : []
        content {
          allowed_origins     = lookup(site_config.value.cors, "allowed_origins", [])
          support_credentials = lookup(site_config.value.cors, "support_credentials", false)
        }
      }
    }
  }

   auth_settings {
    enabled                        = var.enable_auth_settings
    default_provider               = var.default_auth_provider
    allowed_external_redirect_urls = []
    issuer                         = format("https://sts.windows.net/%s/", data.azurerm_client_config.main.tenant_id)
    unauthenticated_client_action  = var.unauthenticated_client_action
    token_store_enabled            = var.token_store_enabled

    dynamic "active_directory" {
      for_each = var.active_directory_auth_setttings
      content {
        client_id         = lookup(active_directory_auth_setttings.value, "client_id", null)
        client_secret     = lookup(active_directory_auth_setttings.value, "client_secret", null)
        allowed_audiences = concat(formatlist("https://%s", [format("%s.azurewebsites.net", var.app_service_name)]), [])
      }
    }
  }

  dynamic "backup" {
    for_each = var.enable_backup ? [{}] : []
    content {
      name                = coalesce(var.backup_settings.name, "DefaultBackup")
      enabled             = var.backup_settings.enabled
      storage_account_url = format("https://${data.azurerm_storage_account.storeacc.0.name}.blob.core.windows.net/${azurerm_storage_container.storcont.0.name}%s", data.azurerm_storage_account_blob_container_sas.main.0.sas)
      schedule {
        frequency_interval       = var.backup_settings.frequency_interval
        frequency_unit           = var.backup_settings.frequency_unit
        retention_period_in_days = var.backup_settings.retention_period_in_days
        start_time               = var.backup_settings.start_time
      }
    }
  }

  dynamic "connection_string" {
    for_each = var.connection_strings
    content {
      name  = lookup(connection_string.value, "name", null)
      type  = lookup(connection_string.value, "type", null)
      value = lookup(connection_string.value, "value", null)
    }
  }

  identity {
    type         = var.identity_ids != null ? "SystemAssigned, UserAssigned" : "SystemAssigned"
    identity_ids = var.identity_ids
  }

  dynamic "storage_account" {
    for_each = var.storage_mounts
    content {
      name         = lookup(storage_account.value, "name")
      type         = lookup(storage_account.value, "type", "AzureFiles")
      account_name = lookup(storage_account.value, "account_name", null)
      share_name   = lookup(storage_account.value, "share_name", null)
      access_key   = lookup(storage_account.value, "access_key", null)
      mount_path   = lookup(storage_account.value, "mount_path", null)
    }
  }

  lifecycle {
    ignore_changes = [
      app_settings.WEBSITE_RUN_FROM_ZIP,
      app_settings.WEBSITE_RUN_FROM_PACKAGE,
      app_settings.MACHINEKEY_DecryptionKey,
      app_settings.WEBSITE_CONTENTAZUREFILECONNECTIONSTRING,
      app_settings.WEBSITE_CONTENTSHARE
    ]
  }

  dynamic "identity" {
    for_each = length(var.identity_ids) == 0 && var.identity_type == "SystemAssigned" ? [var.identity_type] : []
    content {
      type = var.identity_type
    }
  }

  dynamic "identity" {
    for_each = length(var.identity_ids) > 0 || var.identity_type == "UserAssigned" ? [var.identity_type] : []
    content {
      type         = var.identity_type
      identity_ids = length(var.identity_ids) > 0 ? var.identity_ids : []
    }
  }

  version = "~${var.function_app_version}"

  tags = var.tags
}

resource "azurerm_app_service_virtual_network_swift_connection" "function_vnet_integration" {
  count = var.function_app_vnet_integration_enabled ? 1 : 0

  app_service_id = azurerm_function_app.function_app.id
  subnet_id      = var.function_app_vnet_integration_subnet_id
}