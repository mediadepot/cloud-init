#!/bin/bash
IP_ADDRESS=$(ip route get 1 | sed -n 's/^.*src \([0-9.]*\) .*$/\1/p')

cat >/etc/sysconfig/mediadepot <<EOL
DEPOT_SERVER_IP=${IP_ADDRESS}
EOL


cat >/etc/systemd/system/docker.service.d/docker-opts.conf <<EOL
[Service]
Environment=DOCKER_OPTS="--dns=${IP_ADDRESS}"
EOL
