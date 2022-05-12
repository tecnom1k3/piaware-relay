#!/bin/bash

set -e

piaware-config -start
tail -f /var/log/piaware.log
