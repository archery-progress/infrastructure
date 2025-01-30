terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.12.0"
    }
  }
}

resource "google_secret_manager_secret" "secret" {
  secret_id = "${upper(var.project_name)}-${var.secret_name}-${upper(var.environment)}"
  project   = var.project_id

  labels = {
    env     = var.environment
    project = var.project_name
  }

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "secret_version" {
  secret      = google_secret_manager_secret.secret.id
  secret_data = var.value
}