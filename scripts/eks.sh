#!/bin/bash

if [ $# -lt 3 ]; then
    echo "-c for clustername  - created cluster name"
    echo "-n for nodename     - creation node name"
    echo "-s for namespace    - creation namespace"
    exit 1
fi

while getopts c:n:s: flag
do
    case "${flag}" in
        c) clustername=${OPTARG};;
        n) nodename=${OPTARG};;
        s) namespace=${OPTARG};;
    esac
done

aws eks update-kubeconfig --name $clustername

kubectl create namespace $namespace

kubectl config set-context --current --namespace=$namespace

read -p "Please create nodegroup. Press any key to resume ..."

kubectl create -f ../src/adservice/deployment/kubernetes-manifests.yaml
kubectl create -f ../src/cartservice/deployment/kubernetes-manifests.yaml
kubectl create -f ../src/checkoutservice/deployment/kubernetes-manifests.yaml
kubectl create -f ../src/currencyservice/deployment/kubernetes-manifests.yaml
kubectl create -f ../src/emailservice/deployment/kubernetes-manifests.yaml
kubectl create -f ../src/frontend/deployment/kubernetes-manifests.yaml
kubectl create -f ../src/loadgenerator/deployment/kubernetes-manifests.yaml
kubectl create -f ../src/paymentservice/deployment/kubernetes-manifests.yaml
kubectl create -f ../src/productcatalogservice/deployment/kubernetes-manifests.yaml
kubectl create -f ../src/recommendationservice/deployment/kubernetes-manifests.yaml
kubectl create -f ../src/redis/deployment/kubernetes-manifests.yaml
kubectl create -f ../src/shippingservice/deployment/kubernetes-manifests.yaml

# kubectl get pods --kubeconfig ~/.kube/config

read -t 45 -p "Getting url..."
echo -e "\n"
kubectl get service | grep amazonaws.com | grep -Eo '\S*' | tail -n3 | head -n1

exit