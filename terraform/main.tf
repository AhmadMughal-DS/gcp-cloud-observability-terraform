locals {
  name_prefix = var.project_name
}

module "observability" {
  source      = "./modules/observability"
  name_prefix = local.name_prefix
  environment = var.environment
  alert_email = var.alert_email
}
