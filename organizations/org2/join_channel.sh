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
# Bind all org2 services to the "org2" namespace
#
export NAMESPACE=org2


function join_orderer() {
  local orderer=$1
  print "joining orderer $orderer to $CHANNEL_NAME"

  # orderer URL and TLS certificate:
  local orderer_admin_endpoint=org2-${orderer}-admin.media3.fyre.ibm.com
  local ca_file=channel-config/organizations/ordererOrganizations/media3.fyre.ibm.com/orderers/${orderer}/tls/signcerts/tls-cert.pem

  # mTLS client key pair enrolled the org2 TLS CA:
  local client_cert=organizations/org2/enrollments/org2admin/tls/signcerts/cert.pem
  local client_key=organizations/org2/enrollments/org2admin/tls/keystore/key.pem

  osnadmin channel join \
    --orderer-address $orderer_admin_endpoint \
    --ca-file         $ca_file \
    --client-cert     $client_cert \
    --client-key      $client_key \
    --channelID       $CHANNEL_NAME \
    --config-block    channel-config/${CHANNEL_NAME}_genesis_block.pb
}

join_orderer orderernode1













#
# Join peer1 to the channel
#
print "joining org2 peer1 to $CHANNEL_NAME"
appear_as Org2MSP org2 peer1
peer channel join --blockpath channel-config/${CHANNEL_NAME}_genesis_block.pb

#
# Join peer2 to the channel
#
print "joining org2 peer2 to $CHANNEL_NAME"
appear_as Org2MSP org2 peer2
peer channel join --blockpath channel-config/${CHANNEL_NAME}_genesis_block.pb
