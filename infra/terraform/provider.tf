# Terraformの設定を行うブロック
# 必要なプロバイダーを指定（この場合、Google Cloud用のプロバイダーを使用）
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"   # Google Cloud用プロバイダーのソース
      version = "6.12.0"             # 使用するプロバイダーのバージョンを指定
    }
  }
}

# Google Cloudのプロバイダー設定
# 共通の設定としてプロジェクトIDとリージョンを指定
provider "google" {
  project = var.project_id  # 使用するGoogle CloudプロジェクトのIDを変数から取得
  region  = var.region      # 使用するGoogle Cloudのリージョンを変数から取得
}
