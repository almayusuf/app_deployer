DIR=$(pwd)
cat << EOF > "$DIR/backend.tf"
terraform {
  backend "gcs" {
    bucket  = "`gsutil ls  | grep "backend-" | awk -F "/" '{print $3}'`"
    prefix  = "application_deployment/dev"
  }
}
EOF
cat "$DIR/backend.tf"
