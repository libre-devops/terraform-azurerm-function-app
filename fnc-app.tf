resource "azurerm_function_app" "function_app" {
  count                      = var.app_amount
  name                       = "${var.app_name}${format("%02d", count.index + 1)}"
  app_service_plan_id        = var.app_service_plan_id
  location                   = var.location
  resource_group_name        = var.rg_name
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  os_type                    = var.os_type
  https_only                 = var.https_only
  app_settings = var.function_app_application_settings

  dynamic "site_config" {
    for_each = lookup(var.settings, "site_config", {}) != {} ? [1] : []

    content {
      always_on                        = lookup(var.settings.site_config, "always_on", false)
      app_scale_limit                  = lookup(var.settings.site_config, "app_scale_limit", null)
      elastic_instance_minimum         = lookup(var.settings.site_config, "elastic_instance_minimum", null)
      health_check_path                = lookup(var.settings.site_config, "health_check_path", null)
      min_tls_version                  = lookup(var.settings.site_config, "min_tls_version", null)
      pre_warmed_instance_count        = lookup(var.settings.site_config, "pre_warmed_instance_count", null)
      runtime_scale_monitoring_enabled = lookup(var.settings.site_config, "runtime_scale_monitoring_enabled", null)
      dotnet_framework_version         = lookup(var.settings.site_config, "dotnet_framework_version", null)
      ftps_state                       = lookup(var.settings.site_config, "ftps_state", null)
      http2_enabled                    = lookup(var.settings.site_config, "http2_enabled", null)
      java_version                     = lookup(var.settings.site_config, "java_version", null)
      linux_fx_version                 = lookup(var.settings.site_config, "linux_fx_version", null)
      use_32_bit_worker_process        = lookup(var.settings.site_config, "use_32_bit_worker_process", null)
      websockets_enabled               = lookup(var.settings.site_config, "websockets_enabled", null)
      scm_type                         = lookup(var.settings.site_config, "scm_type", null)
      scm_use_main_ip_restriction      = lookup(var.settings.site_config, "scm_use_main_ip_restriction", null)
      vnet_route_all_enabled           = lookup(var.settings.site_config, "vnet_route_all_enabled", null)

      dynamic "cors" {
        for_each = lookup(site_config.value, "cors", []) != [] ? ["fake"] : []
        content {
          allowed_origins     = lookup(site_config.value.cors, "allowed_origins", [])
          support_credentials = lookup(site_config.value.cors, "support_credentials", false)
        }
      }

       dynamic "ip_restriction" {
        for_each = try(var.settings.site_config.ip_restriction, {})

        content {
          ip_address                = lookup(ip_restriction, "ip_address", null)
          virtual_network_subnet_id = lookup(ip_restriction, "virtual_network_subnet_id", null)
        }
      }
      dynamic "scm_ip_restriction" {
        for_each = try(var.settings.site_config.scm_ip_restriction, {})

        content {
          ip_address                = lookup(scm_ip_restriction, "ip_address", null)
          service_tag               = lookup(scm_ip_restriction, "service_tag", null)
          virtual_network_subnet_id = lookup(scm_ip_restriction, "virtual_network_subnet_id", null)
          name                      = lookup(scm_ip_restriction, "name", null)
          priority                  = lookup(scm_ip_restriction, "priority", null)
          action                    = lookup(scm_ip_restriction, "action", null)
          dynamic "headers" {
            for_each = try(scm_ip_restriction.headers, {})

            content {
              x_azure_fdid      = lookup(headers, "x_azure_fdid", null)
              x_fd_health_probe = lookup(headers, "x_fd_health_probe", null)
              x_forwarded_for   = lookup(headers, "x_forwarded_for", null)
              x_forwarded_host  = lookup(headers, "x_forwarded_host", null)
            }
          }
        }
      }
    }
  }

   dynamic "auth_settings" {
    for_each = lookup(var.settings, "auth_settings", {}) != {} ? [1] : []

    content {
      enabled                        = lookup(var.settings.auth_settings, "enabled", false)
      additional_login_params        = lookup(var.settings.auth_settings, "additional_login_params", null)
      allowed_external_redirect_urls = lookup(var.settings.auth_settings, "allowed_external_redirect_urls", null)
      default_provider               = lookup(var.settings.auth_settings, "default_provider", null)
      issuer                         = lookup(var.settings.auth_settings, "issuer", null)
      runtime_version                = lookup(var.settings.auth_settings, "runtime_version", null)
      token_refresh_extension_hours  = lookup(var.settings.auth_settings, "token_refresh_extension_hours", null)
      token_store_enabled            = lookup(var.settings.auth_settings, "token_store_enabled", null)
      unauthenticated_client_action  = lookup(var.settings.auth_settings, "unauthenticated_client_action", null)

      dynamic "active_directory" {
        for_each = lookup(var.settings.auth_settings, "active_directory", {}) != {} ? [1] : []

        content {
          client_id         = var.settings.auth_settings.active_directory.client_id
          client_secret     = lookup(var.settings.auth_settings.active_directory, "client_secret", null)
          allowed_audiences = lookup(var.settings.auth_settings.active_directory, "allowed_audiences", null)
        }
      }

      dynamic "facebook" {
        for_each = lookup(var.settings.auth_settings, "facebook", {}) != {} ? [1] : []

        content {
          app_id       = var.settings.auth_settings.facebook.app_id
          app_secret   = var.settings.auth_settings.facebook.app_secret
          oauth_scopes = lookup(var.settings.auth_settings.facebook, "oauth_scopes", null)
        }
      }

      dynamic "google" {
        for_each = lookup(var.settings.auth_settings, "google", {}) != {} ? [1] : []

        content {
          client_id     = var.settings.auth_settings.google.client_id
          client_secret = var.settings.auth_settings.google.client_secret
          oauth_scopes  = lookup(var.settings.auth_settings.google, "oauth_scopes", null)
        }
      }

      dynamic "microsoft" {
        for_each = lookup(var.settings.auth_settings, "microsoft", {}) != {} ? [1] : []

        content {
          client_id     = var.settings.auth_settings.microsoft.client_id
          client_secret = var.settings.auth_settings.microsoft.client_secret
          oauth_scopes  = lookup(var.settings.auth_settings.microsoft, "oauth_scopes", null)
        }
      }

      dynamic "twitter" {
        for_each = lookup(var.settings.auth_settings, "twitter", {}) != {} ? [1] : []

        content {
          consumer_key    = var.settings.auth_settings.twitter.consumer_key
          consumer_secret = var.settings.auth_settings.twitter.consumer_secret
        }
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

  dynamic "source_control" {
    for_each = lookup(var.settings, "source_control", {}) != {} ? [1] : []

    content {
      repo_url           = var.settings.source_control.repo_url
      branch             = lookup(var.settings.source_control, "branch", null)
      manual_integration = lookup(var.settings.source_control, "manual_integration", null)
      rollback_enabled   = lookup(var.settings.source_control, "rollback_enabled", null)
      use_mercurial      = lookup(var.settings.source_control, "use_mercurial", null)
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

  version = var.function_app_version

  tags = var.tags
}

resource "azurerm_app_service_virtual_network_swift_connection" "function_vnet_integration" {
  count = var.function_app_vnet_integration_enabled ? 1 : 0

  app_service_id = azurerm_function_app.function_app.id
  subnet_id      = var.function_app_vnet_integration_subnet_id
}