# Cloud BuildのGitHub接続を作成するモジュール

# GitHubとの接続を作成するリソース
resource "google_cloudbuildv2_connection" "my_connection" {
  location = var.region           # 接続を作成するリージョン（例: asia-northeast1）
  name     = var.connection_name  # 接続の名前（例: my-github-connection）

  # GitHubの接続設定
  github_config {
    app_installation_id = var.installation_id  # GitHub AppのインストールIDを指定
    authorizer_credential {
      # Secret Managerに保存したGitHubトークンのバージョンIDを指定
      oauth_token_secret_version = google_secret_manager_secret_version.github_token_secret_version.id
    }
  }

  # IAMポリシーの適用が完了してから実行する依存関係を設定
  depends_on = [google_secret_manager_secret_iam_policy.policy]
}

# GitHubリポジトリを接続に追加
resource "google_cloudbuildv2_repository" "github_repository" {
  project          = var.project_id             # プロジェクトID
  location         = var.region                 # リージョン（例: asia-northeast1）
  name             = var.repo_name              # リポジトリ名（例: my-repo）
  parent_connection = google_cloudbuildv2_connection.my_connection.name
  remote_uri       = var.repo_uri               # GitHubリポジトリのURI（例: https://github.com/myuser/myrepo.git）
}
