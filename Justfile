# print help message
default:
	@just -l

# install kustomize
download-kustomize:
	curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
	sudo chmod +x kustomize
	sudo mv kustomize /usr/local/bin

## deploy airflow
deploy env:
	kubectl kustomize overlays/{{env}} --enable-helm | kubectl apply -f -

## stop airflow
stop env:
	kubectl kustomize overlays/{{env}} --enable-helm | kubectl delete -f -

## deploy airflow to argocd
argo-deploy env:
	kubectl apply -k cd/overlays/{{env}}

