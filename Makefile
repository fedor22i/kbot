APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=ghcr.io/fedor22i
VERSION=v1.0.7-aec4886
TARGETOS=linux
TARGETARCH=amd64
CLUSTER_NAME=dev-cluster

format:
	gofmt -s -w ./

get:
	go get

lint:
	golint

test:
	go test -v

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/fedor22i/kbot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

clean:
	rm -rf kbot

create-cluster:
	k3d cluster create $(CLUSTER_NAME) --config k3d-config.yaml

delete-cluster:
	k3d cluster delete $(CLUSTER_NAME)

install-argocd:
	kubectl create namespace argocd || true
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
	kubectl wait --for=condition=available --timeout=180s deployment/argocd-server -n argocd

port-forward-argocd:
	kubectl port-forward svc/argocd-server -n argocd 8081:443

get-argocd-password:
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d