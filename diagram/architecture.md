# Architecture Diagram — GCP Cloud Observability Stack

## Lucid diagram

- **View:** https://lucid.app/lucidchart/1f01fa13-2283-4dfc-9546-93caec2e1bdd/view
- **Edit:** https://lucid.app/lucidchart/1f01fa13-2283-4dfc-9546-93caec2e1bdd/edit

## Lucid prompt (reusable)

```
Create a GCP monitoring diagram titled "GCP Cloud Observability Stack".
Cloud Logging feeds a Log-based Metric; the metric drives both an Alert Policy and a
Dashboard. When the Alert Policy fires it notifies an Email Channel which reaches the
on-call person. Label the arrows. Clean, professional Google Cloud colors.
```

## Mermaid source

```mermaid
flowchart LR
    Logs([Cloud Logging])
    Metric[Log-based Metric]
    Alert[Alert Policy]
    Dash[Dashboard]
    Chan[Email Channel]
    Email([On-call])
    Logs --> Metric
    Metric --> Alert
    Metric --> Dash
    Alert -->|fires| Chan
    Chan --> Email
```
