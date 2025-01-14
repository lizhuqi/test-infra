#!/usr/bin/env bash
# Copyright 2021 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# this script runs tslint against the repo using docker
#
# TODO: we should be using eslint instead now, but this repo is also
# on a rather old version of node, first we get the build system migrated.

set -o errexit
set -o nounset
set -o pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd -P)"
cd "${REPO_ROOT}"

# ensure deps are installed
# TODO: move out into make dependency step?
hack/build/ensure-node_modules.sh

# TODO: make sure this matches bazel version
hack/run-in-node-container.sh \
    node_modules/tslint/bin/tslint -c tslint.json --project .
