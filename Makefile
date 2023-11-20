BUF_VERSION=v1.28.0
TAG=protobuf-v0.1.5
guard-%:
	@ if [ "${${*}}" = "" ]; then \
        echo "Environment variable $* not set"; \
        exit 1; \
    fi

install-buf:
	go install github.com/bufbuild/buf/cmd/buf@${BUF_VERSION}

lint: guard-GOPATH
	cd protobuf && ${GOPATH}/bin/buf lint

gen-go: install-buf guard-GOPATH
	${GOPATH}/bin/buf generate --template protobuf/buf.gen.go.yaml

gen-go-server: install-buf guard-GOPATH
	${GOPATH}/bin/buf generate --template protobuf/buf.gen.yaml
push-tag:
	cd protobuf && buf push --tag=${TAG}
