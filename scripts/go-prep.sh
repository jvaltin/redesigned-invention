#!/bin/bash
#
# This script runs inside of a Docker container

go get -u gopkg.in/alecthomas/gometalinter.v1
gometalinter.v1 --install
go get -u github.com/golang/dep/cmd/dep
go get -u github.com/stretchr/testify
go get -u github.com/vektra/mockery/cmd/mockery
go get golang.org/x/tools/cmd/goimports
go get -u github.com/jteeuwen/go-bindata/...
