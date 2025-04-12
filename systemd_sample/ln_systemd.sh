#!/bin/bash
sudo ln -sf `pwd`/openhands.service /etc/systemd/system/openhands.service
sudo systemctl daemon-reload
