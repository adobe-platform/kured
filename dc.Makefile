.PHONY: 

DH_ORG=weaveworks
VERSION=1.9.2-dc

build.docker:
	docker build -t docker-dc-micro-release.dr.corp.adobe.com/$(DH_ORG)/kured:$(VERSION) -f dc.Dockerfile --build-arg VERSION=$(VERSION) .

