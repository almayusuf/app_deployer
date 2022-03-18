provider "google" {
  credentials = "service-account.json"
}
provider "helm" {
  kubernetes {
    config_path = "config"
  }
}
