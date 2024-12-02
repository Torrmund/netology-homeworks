terraform {
  backend "s3" {
    shared_credentials_files = [ "~/.aws/credentials" ]
    profile = "default"
    region = "ru-central1"

    bucket = "terraform-state-emav"
    key = "production/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id = true
    skip_s3_checksum = true

    endpoints = {
      dynamodb = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gmlu2hfoi2rdhigrb4/etnvajc87bgtrmsssin9"
      s3 = "https://storage.yandexcloud.net"
    }

    dynamodb_table = "tfstate-lock-production"
  }
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}
