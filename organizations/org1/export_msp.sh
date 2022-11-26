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
# Bind all org1 services to the "org1" namespace
#
export NAMESPACE=org1

print "Exporting org1 channel MSP"

#
# Prepare a folder structure containing the organization's MSP certificates
# necessary to join the consortium.
#
ORG_DIR=channel-config/organizations/peerOrganizations/media2.fyre.ibm.com

write_pem ca .ca.signcerts $ORG_DIR/msp/cacerts/ca-signcert.pem
write_pem ca .tlsca.signcerts $ORG_DIR/msp/tlscacerts/tlsca-signcert.pem
write_msp_config ca ca-signcert.pem $ORG_DIR/msp


#
# Extract the orderer TLS certificates.  These will be used by osnadmin for
# TLS connections to the orderers when joining orgs to a channel.
#
ORG_DIR=channel-config/organizations/ordererOrganizations/media2.fyre.ibm.com

write_pem orderernode1 .tls.signcerts $ORG_DIR/orderers/orderernode1/tls/signcerts/tls-cert.pem