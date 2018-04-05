#!/usr/bin/env bash

bosh init-release --dir ginkgo-package
cd ginkgo-package
go get github.com/onsi/ginkgo/ginkgo
bosh add-blob ~/go/bin/ginkgo ginkgo
bosh generate-package ginkgo
tree packages
cat <<"EOT" >> packages/ginkgo/packaging
cp ginkgo ${BOSH_INSTALL_TARGET} --preserve
EOT
cat <<EOT > packages/ginkgo/spec
---
name: ginkgo

files:
  - ginkgo

EOT
cat <<EOT > config/final.yml
---
name: ginkgo-package
blobstore:
  provider: local
  options:
    blobstore_path: /tmp/test-blobs

EOT
bosh upload-blobs

