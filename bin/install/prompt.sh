#!/bin/bash

git clone https://github.com/StenSipma/myprompt.git
cd myprompt
cargo install --path .
cd ..
rm -rf myprompt
