resource "random_password" "proxy_secret_token" {
  length  = 32
  special = false
}

resource "helm_release" "velero" {
  name      = "velero"
  namespace = var.namespace

  repository = "https://vmware-tanzu.github.io/helm-charts"
  chart      = "velero"
  version    = "2.23.5"

  values = concat([
    file("${path.module}/values.yaml"),
  ], var.overrides)

  set {
    name  = "proxy.secretToken"
    value = random_password.proxy_secret_token.result
  }
}
