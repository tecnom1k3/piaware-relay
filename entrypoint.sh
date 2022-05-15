#!/bin/bash

set -e

piaware-config -start
service lighttpd start
piaware-status
tail -f /var/log/piaware.log
