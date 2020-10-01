#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

vim +PlugInstall +PlugClean! +qall
