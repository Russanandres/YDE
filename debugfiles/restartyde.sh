#!/bin/bash
while sleep 1; do
ps -ax | grep runui | grep -v grep >> /dev/null
if [ $? == 1 ]; then
/usr/bin/runui
fi
done

