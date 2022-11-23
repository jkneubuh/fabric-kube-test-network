#!/usr/bin/env bash
#
# Copyright contributors to the Hyperledgendary Kubernetes Test Network project
#
# SPDX-License-Identifier: Apache-2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at:
#
# 	  http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
set -euo pipefail
. scripts/utils.sh

#
# Bind all org3 services to the "org3" namespace
#
export NAMESPACE=org3

#
# CA
#
print "starting org3 CA"

apply_template organizations/org3/org3-ca.yaml
sleep 5
wait_for ibpca ca

export CA_CERT=$(connection_profile_cert ca .tls.cert)

print "org3 CA_CERT: $CA_CERT"


#
# Network nodes
#
print "starting org3 peers"

apply_template organizations/org3/org3-peer1.yaml
sleep 5

wait_for ibppeer peer1


