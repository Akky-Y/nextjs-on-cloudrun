# Terraformで使用する変数を定義するファイル
# 各変数には、プロジェクトやリソースの設定に必要な値を指定します。

# プロジェクトID
variable "project_id" {
  description = "Google CloudのプロジェクトID"
  type        = string
}

# プロジェクト番号
variable "project_number" {
  description = "Google Cloudのプロジェクト番号"
  type        = string
}

# GitHub Personal Access Token (PAT)
variable "github_pat" {
  description = "GitHubのPersonal Access Token"
  type        = string
  sensitive   = true
}

# Secret ID
variable "secret_id" {
  description = "Secret Managerに保存するシークレットのID"
  type        = string
}

# Cloud Buildのリージョン
variable "region" {
  description = "Google Cloud Buildのリージョン"
  type        = string
  default     = "asia-northeast1"
}

# GitHub AppのインストールID
variable "installation_id" {
  description = "GitHub AppのインストールID"
  type        = string
}

# GitHub接続名
variable "connection_name" {
  description = "Cloud Buildで作成するGitHub接続名"
  type        = string
}

variable "repo_name" {
  description = "Cloud Buildで作成するGitHubリポジトリ名"
  type        = string
}

variable "repo_uri" {
  description = "Cloud Buildで作成するGitHubリポジトリURI"
  type        = string
}