#!/bin/bash

echo "Running in `pwd` as $USER"
/usr/bin/kill `cat /tmp/.X99-lock`
/usr/bin/rm -f /tmp/.X99-lock
/usr/bin/xvfb-run -e /tmp/xvfb_err /usr/bin/spotify || /usr/bin/cat /tmp/xvfb_err
