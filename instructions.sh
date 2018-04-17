#!/usr/bin/env bash

bosh init-release --dir ginkgo-package
cd ginkgo-package
go get github.com/onsi/ginkgo/ginkgo
bosh add-blob ~/go/bin/ginkgo ginkgo
bosh generate-package ginkgo
tree packages
echo -e "cp ginkgo ${BOSH_INSTALL_TARGET} --preserve" >> packages/ginkgo/packaging
echo -e "--- \nname: ginkgo \nfiles: \n\t- ginkgo" > packages/ginkgo/spec
echo -e "--- \nname: ginkgo-package \nblobstore: \n\tprovider: local \n\toptions: \n\t\tblobstore_path: /tmp/test-blobs" > config/final.yml
bosh upload-blobs

