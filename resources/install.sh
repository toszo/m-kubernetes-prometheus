export KUBECONFIG="$1"

echo "Install prometheus-community/prometheus"
helm install prometheus-community/prometheus --generate-name
