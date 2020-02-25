#!/usr/bin/env bash

curl -s https://api.github.com/repos/grpc-ecosystem/grpc-health-probe/releases/latest \
  | grep browser_download_url \
  | grep linux-amd64 \
  | cut -d '"' -f 4 \
  | wget -O /bin/grpc-health-probe -qi -

chmod +x /bin/grpc-health-probe