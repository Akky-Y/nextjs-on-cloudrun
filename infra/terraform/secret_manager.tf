# Secret Managerのリソースを作成するモジュール

# Secret ManagerにGitHubのPersonal Access Token (PAT)を保存するリソース
resource "google_secret_manager_secret" "github_token_secret" {
  secret_id = var.secret_id  # SecretのIDを指定（GitHubトークン用の識別子）

  # リソースのレプリケーション設定
  # 指定したリージョンにレプリカを配置
  replication {
    user_managed {  # ユーザー管理型のレプリケーションを使用
      replicas {
        location = var.region  # レプリカの配置先リージョンを変数から取得
      }
    }
  }
}

# Secret Managerに保存する具体的なトークンデータを定義
resource "google_secret_manager_secret_version" "github_token_secret_version" {
  secret      = google_secret_manager_secret.github_token_secret.id  # 上で作成したSecretのIDを指定
  secret_data = var.github_pat                                       # GitHub PAT（Personal Access Token）を変数から取得
}

# IAMポリシーを定義するためのデータ取得
# Secret Managerへのアクセス権限を設定するIAMポリシーを生成
data "google_iam_policy" "serviceagent_secretAccessor" {
  binding {
    role    = "roles/secretmanager.secretAccessor"  # Secret Managerにアクセスできる権限
    # Cloud BuildのサービスエージェントアカウントをIAMポリシーのメンバーとして指定
    members = ["serviceAccount:service-${var.project_number}@gcp-sa-cloudbuild.iam.gserviceaccount.com"]
  }
}

# 上記で作成したIAMポリシーをSecret Managerに適用
resource "google_secret_manager_secret_iam_policy" "policy" {
  secret_id   = google_secret_manager_secret.github_token_secret.secret_id  # Secret ManagerのリソースID
  # データ取得で生成したIAMポリシーデータを適用
  policy_data = data.google_iam_policy.serviceagent_secretAccessor.policy_data
}