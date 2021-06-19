#!/usr/bin/env bash
docker pull v2ray/official && \
mkdir /etc/v2ray && \
cp /root/dev/v2ray/config.yaml /etc/v2ray/
