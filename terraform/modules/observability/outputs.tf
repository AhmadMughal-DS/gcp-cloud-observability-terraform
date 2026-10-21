output "logging_metric" {
  value = google_logging_metric.errors.name
}
output "notification_channel" {
  value = google_monitoring_notification_channel.email.id
}
output "alert_policy" {
  value = google_monitoring_alert_policy.errors.name
}
