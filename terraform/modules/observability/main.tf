resource "google_logging_metric" "errors" {
  name   = "${var.name_prefix}-error-count"
  filter = "severity>=ERROR"
  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
    unit        = "1"
  }
}

resource "google_monitoring_notification_channel" "email" {
  display_name = "${var.name_prefix}-ops-email"
  type         = "email"
  labels = {
    email_address = var.alert_email
  }
}

resource "google_monitoring_alert_policy" "errors" {
  display_name = "${var.name_prefix}-error-alert"
  combiner     = "OR"

  conditions {
    display_name = "Error logs detected"
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/${google_logging_metric.errors.name}\" AND resource.type=\"global\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "0s"
      aggregations {
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_DELTA"
      }
    }
  }

  notification_channels = [google_monitoring_notification_channel.email.id]
}

resource "google_monitoring_dashboard" "this" {
  dashboard_json = jsonencode({
    displayName = "${var.name_prefix}-dashboard"
    gridLayout = {
      widgets = [
        {
          title = "Error log count"
          xyChart = {
            dataSets = [
              {
                timeSeriesQuery = {
                  timeSeriesFilter = {
                    filter = "metric.type=\"logging.googleapis.com/user/${google_logging_metric.errors.name}\""
                    aggregation = {
                      alignmentPeriod  = "300s"
                      perSeriesAligner = "ALIGN_DELTA"
                    }
                  }
                }
              }
            ]
          }
        }
      ]
    }
  })
}
