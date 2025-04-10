#!/usr/bin/env bash

# Proxmoxサーバーの情報は、環境変数で設定されている想定。.envをsourceしておくこと

# 認証トークンを取得
TICKET=$(curl -s -k -d "username=$USERNAME" -d "password=$PASSWORD" https://$HOST:8006/api2/json/access/ticket | jq -r '.data.ticket')

# 動作中のVMリストを取得
VMS=$(curl -s -k -b "PVEAuthCookie=$TICKET" https://$HOST:8006/api2/json/cluster/resources | jq -r '.data[] | select(.type=="qemu" and .status=="running") | [.vmid, .name, .node] | join(" ")')

# 各VMのIPアドレスを取得
echo "Running VMs and their IP addresses:"
while read -r vmid name node; do
  IP=$(curl -s -k -b "PVEAuthCookie=$TICKET" https://$HOST:8006/api2/json/nodes/$node/qemu/$vmid/agent/network-get-interfaces | jq -r '.data.result[] | select(.["ip-addresses"]?) | .["ip-addresses"][] | select(.["ip-address-type"]=="ipv4" and .["ip-address"]!="127.0.0.1" and .["ip-address"]!="172.17.0.1") | .["ip-address"]')
  echo "VMID: $vmid, Name: $name, IP: $IP"
done <<< "$VMS"
