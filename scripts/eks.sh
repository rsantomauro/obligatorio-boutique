#!/bin/bash

REPO='imageTag'

if [ $# -lt 3 ]; then
    echo "-c for clustername    - created cluster name"
    echo "-n for namespace      - creation namespace"
    echo "-r for ecr            - created ECR"
    exit 1
fi

while getopts c:n:r: flag
do
    case "${flag}" in
        c) clustername=${OPTARG};;
        n) namespace=${OPTARG};;
        r) ecr=${OPTARG};;
    esac
done

aws eks update-kubeconfig --name $clustername

kubectl create namespace $namespace

kubectl config set-context --current --namespace=$namespace

cd ../src/

# Se cambia el ECR url por el brindado como argumento
sed -i "s|$REPO|$ecr:adservice|g" adservice/deployment/kubernetes-manifests.yaml
sed -i "s|$REPO|$ecr:cartservice|g" cartservice/deployment/kubernetes-manifests.yaml
sed -i "s|$REPO|$ecr:checkoutservice|g" checkoutservice/deployment/kubernetes-manifests.yaml
sed -i "s|$REPO|$ecr:currencyservice|g" currencyservice/deployment/kubernetes-manifests.yaml
sed -i "s|$REPO|$ecr:emailservice|g" emailservice/deployment/kubernetes-manifests.yaml
sed -i "s|$REPO|$ecr:frontend|g" frontend/deployment/kubernetes-manifests.yaml
sed -i "s|$REPO|$ecr:loadgenerator|g" loadgenerator/deployment/kubernetes-manifests.yaml
sed -i "s|$REPO|$ecr:paymentservice|g" paymentservice/deployment/kubernetes-manifests.yaml
sed -i "s|$REPO|$ecr:productcatalogservice|g" productcatalogservice/deployment/kubernetes-manifests.yaml
sed -i "s|$REPO|$ecr:recommendationservice|g" recommendationservice/deployment/kubernetes-manifests.yaml
sed -i "s|$REPO|$ecr:redis|g" redis/deployment/kubernetes-manifests.yaml
sed -i "s|$REPO|$ecr:shippingservice|g" shippingservice/deployment/kubernetes-manifests.yaml

read -p "Please create nodegroup in EKS. Press any key to resume ..."

# Se crea el deployment
kubectl create -f adservice/deployment/kubernetes-manifests.yaml
kubectl create -f cartservice/deployment/kubernetes-manifests.yaml
kubectl create -f checkoutservice/deployment/kubernetes-manifests.yaml
kubectl create -f currencyservice/deployment/kubernetes-manifests.yaml
kubectl create -f emailservice/deployment/kubernetes-manifests.yaml
kubectl create -f frontend/deployment/kubernetes-manifests.yaml
kubectl create -f loadgenerator/deployment/kubernetes-manifests.yaml
kubectl create -f paymentservice/deployment/kubernetes-manifests.yaml
kubectl create -f productcatalogservice/deployment/kubernetes-manifests.yaml
kubectl create -f recommendationservice/deployment/kubernetes-manifests.yaml
kubectl create -f redis/deployment/kubernetes-manifests.yaml
kubectl create -f shippingservice/deployment/kubernetes-manifests.yaml

# Para crear replicas en los dos nodos
# kubectl scale deployments/adservice --replicas=2 $namespace
# kubectl scale deployments/cartservice --replicas=2 $namespace
# kubectl scale deployments/checkoutservice --replicas=2 $namespace
# kubectl scale deployments/currencyservice --replicas=2 $namespace
# kubectl scale deployments/emailservice --replicas=2 $namespace
# kubectl scale deployments/frontend --replicas=2 $namespace
# kubectl scale deployments/loadgenerator --replicas=2 $namespace
# kubectl scale deployments/paymentservice --replicas=2 $namespace
# kubectl scale deployments/productcatalogservice --replicas=2 $namespace
# kubectl scale deployments/recommendationservice --replicas=2 $namespace
# kubectl scale deployments/redis --replicas=2 $namespace
# kubectl scale deployments/shippingservice --replicas=2 $namespace

# Se restaura el ECR url por el guardao en la constante
sed -i "s|$ecr:adservice|$REPO|g" adservice/deployment/kubernetes-manifests.yaml
sed -i "s|$ecr:cartservice|$REPO|g" cartservice/deployment/kubernetes-manifests.yaml
sed -i "s|$ecr:checkoutservice|$REPO|g" checkoutservice/deployment/kubernetes-manifests.yaml
sed -i "s|$ecr:currencyservice|$REPO|g" currencyservice/deployment/kubernetes-manifests.yaml
sed -i "s|$ecr:emailservice|$REPO|g" emailservice/deployment/kubernetes-manifests.yaml
sed -i "s|$ecr:frontend|$REPO|g" frontend/deployment/kubernetes-manifests.yaml
sed -i "s|$ecr:loadgenerator|$REPO|g" loadgenerator/deployment/kubernetes-manifests.yaml
sed -i "s|$ecr:paymentservice|$REPO|g" paymentservice/deployment/kubernetes-manifests.yaml
sed -i "s|$ecr:productcatalogservice|$REPO|g" productcatalogservice/deployment/kubernetes-manifests.yaml
sed -i "s|$ecr:recommendationservice|$REPO|g" recommendationservice/deployment/kubernetes-manifests.yaml
sed -i "s|$ecr:redis|$REPO|g" redis/deployment/kubernetes-manifests.yaml
sed -i "s|$ecr:shippingservice|$REPO|g" shippingservice/deployment/kubernetes-manifests.yaml

# kubectl get pods --kubeconfig ~/.kube/config

read -t 45 -p "Getting url..."
echo -e "\n"
kubectl get service | grep amazonaws.com | grep -Eo '\S*' | tail -n3 | head -n1

exit