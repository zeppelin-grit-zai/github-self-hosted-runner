IMAGE ?= github-self-hosted-runner:local

.PHONY: build scan

build:
	docker build --platform linux/amd64 --tag "$(IMAGE)" docker/linux

scan: build
	trivy image \
		--format table \
		--exit-code 1 \
		--ignore-unfixed \
		--pkg-types os,library \
		--scanners vuln \
		--severity HIGH,CRITICAL \
		"$(IMAGE)"
