#!/bin/bash
set -euo pipefail

sudo cp ./radeon-profile-daemon/target/radeon-profile-daemon /usr/local/bin/radeon-profile-daemon
sudo chown root:root /usr/local/bin/radeon-profile-daemon
sudo chmod 755 /usr/local/bin/radeon-profile-daemon

sudo cp radeon-profile-daemon.service /usr/lib/systemd/system/radeon-profile-daemon.service

sudo systemctl daemon-reload 
sudo systemctl enable radeon-profile-daemon 
sudo systemctl start  radeon-profile-daemon 
sudo systemctl status radeon-profile-daemon
 
