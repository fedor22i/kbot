APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=tony22i
VERSHION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
TARGETARCH=amd64

format:
	gofmt -s -w ./

get:
	go get

lint:
	golint

test:
	go test -v

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/fedor22i/kbot/cmd.appVersion=${VERSHION}

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSHION}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSHION}-${TARGETARCH}

clean:
	rm -rf kbot
