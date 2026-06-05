.PHONY: build generate test install-protoc

export GOBIN ?= $(PWD)/bin

PROTOC_GEN_VERSION=1.33.0
PROTOC_GEN_GO_GRPC_VERSION=1.5.1
PROTOC_GEN_GRPC_GATEWAY_VERSION=2.22.0

install-protoc:
	@echo "Installing protoc-gen-go v$(PROTOC_GEN_VERSION)..."
	@$(GOBIN)/protoc-gen-go --version | grep -q $(PROTOC_GEN_VERSION) || go install google.golang.org/protobuf/cmd/protoc-gen-go@v${PROTOC_GEN_VERSION}
	@echo "Installing protoc-gen-go-grpc v$(PROTOC_GEN_GO_GRPC_VERSION)..."
	@$(GOBIN)/protoc-gen-go-grpc --version | grep -q $(PROTOC_GEN_GO_GRPC_VERSION) || go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v${PROTOC_GEN_GO_GRPC_VERSION}
	@echo "Installing protoc-gen-grpc-gateway v$(PROTOC_GEN_GRPC_GATEWAY_VERSION)..."
	@$(GOBIN)/protoc-gen-grpc-gateway --version | grep -q $(PROTOC_GEN_GRPC_GATEWAY_VERSION) || go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@v${PROTOC_GEN_GRPC_GATEWAY_VERSION}

build:
	mkdir -p ./bin
	go build -o bin/protoc-gen-grpc-gateway-client ./protoc-gen-grpc-gateway-client

generate:
	buf generate

test: build generate
	go test ./...
