#!/bin/bash

TMP_DIR='/tmp/myprompt'

git clone https://github.com/StenSipma/myprompt.git $TMP_DIR
pushd $TMP_DIR
cargo install --path .
popd
rm -rf $TMP_DIR
