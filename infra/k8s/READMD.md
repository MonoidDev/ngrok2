# K8s Deployment

- source
  - https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/

## Create

### Cert Manager

```shell
helm repo add jetstack https://charts.jetstack.io --force-update
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.15.3 \
  --set crds.enabled=true
```

### Ngrok Server

#### Azure Container Registry (ACR)

- Prerequisites

```shell
# Login to Azure Container Registry (ACR)
az acr login --name pixiunextterminal.azurecr.io

# AKS attach to Azure Container Registry (ACR)
az aks update --name next-terminal-aks --resource-group next-terminal-aks --attach-acr pixiunextterminal
```

- Run

```shell
# Build image locally
docker build ../../ --file ../../Dockerfile.server --tag monoid/ngrok-server:latest

# Push to existing ACR
docker tag monoid/ngrok-server:latest pixiunextterminal.azurecr.io/monoid/ngrok-server:latest
docker push pixiunextterminal.azurecr.io/monoid/ngrok-server:latest
```

#### Azure Kubernetes Service (AKS)

```shell
AKS_NAMESPACE=ngrok-server
kubectl create namespace ${AKS_NAMESPACE}

# Install by helm
helm install ngrok-server ./helm/ngrok-server

# Get service IP
# Wait for the service "loadbalancer" to have ingress.
kubectl wait --for=jsonpath='{.status.loadBalancer.ingress}' service/ngrok-server --namespace=${AKS_NAMESPACE}
NGROK_SERVER_SVC_IP=$(kubectl get service/ngrok-server --namespace=${AKS_NAMESPACE} \
                                                    --output jsonpath="{.status.loadBalancer.ingress[0].ip}")
echo $NGROK_SERVER_SVC_IP
```

## Test

```shell
# Compile Ngrok Client
make -C ../.. client
sed -i '' -E -e "s|<NGROK_SERVER_SVC_IP>|${NGROK_SERVER_SVC_IP}|" client.config.test.yaml
../../nrk -config=client.config.test.yaml -hostname=${NGROK_SERVER_SVC_IP} 3000

# Start dummy http
go run ../../examples/dummy_http.go

# Visit endpoint
curl "http://${NGROK_SERVER_SVC_IP}/ping"  # pong
```

## Destroy

### Docker

```shell
docker image rm monoid/ngrok-server pixiunextterminal.azurecr.io/monoid/ngrok-server
```

### AKS

```shell
AKS_NAMESPACE=ngrok-server
kubectl delete namespace ${AKS_NAMESPACE}
kubectl delete namespace cert-manager
```
