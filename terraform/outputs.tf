output "logging_metric" {
  description = "Log-based error-count metric"
  value       = google_logging_metric.errors.name
}

output "notification_channel" {
  description = "Email notification channel ID"
  value       = google_monitoring_notification_channel.email.id
}

output "alert_policy" {
  description = "Alert policy name"
  value       = google_monitoring_alert_policy.errors.name
}
