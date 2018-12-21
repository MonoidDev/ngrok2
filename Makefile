.PHONY: default server client deps fmt clean all release-all assets client-assets server-assets contributors

TAGS = release
DATA_FILES := $(shell find assets | sed 's/ /\\ /g')
GENERATED := pkg/client/assets/assets.go pkg/server/assets/assets.go

default: all

deps: bindata
	go mod tidy

server: deps
	go build -tags '$(TAGS)' github.com/traefix/ngrok2/cmd/nrklet

fmt:
	go fmt github.com/traefix/ngrok2/...

client: deps
	go build -tags '$(TAGS)' github.com/traefix/ngrok2/cmd/nrk

bindata: $(GENERATED)

pkg/client/assets/assets.go: $(DATA_FILES)
	rm -rf pkg/client/assets/
	go-bindata -nomemcopy -pkg=assets -tags=$(TAGS) \
         -debug=$(if $(findstring debug,$(TAGS)),true,false) \
         -o=$@ assets/client/...

pkg/server/assets/assets.go: $(DATA_FILES)
	rm -rf pkg/server/assets/
	go-bindata -nomemcopy -pkg=assets  -tags=$(TAGS) \
         -debug=$(if $(findstring debug,$(TAGS)),true,false) \
         -o=$@ assets/server/...

release-client: TAGS=release
release-client: client

release-server: TAGS=release
release-server: server

release-all: fmt release-client release-server

all: fmt client server

clean:
	go clean -r github.com/traefix/ngrok2/...
	rm -rf nrk nrklet

distclean: clean
	rm -rf pkg/client/assets/ pkg/server/assets/

contributors:
	echo "Contributors to ngrok, both large and small:\n" > CONTRIBUTORS
	git log --raw | grep "^Author: " | sort | uniq | cut -d ' ' -f2- | sed 's/^/- /' | cut -d '<' -f1 >> CONTRIBUTORS
