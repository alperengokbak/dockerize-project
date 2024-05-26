#!/bin/sh
set -e
/usr/sbin/sshd
exec node index.js
