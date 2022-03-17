terraform {
  backend "gcs" {
    bucket  = "backend-uimbkrhaxfaijvth"
    prefix  = "application_deployment/dev"
    credentials = "service-account.json
  }
}
