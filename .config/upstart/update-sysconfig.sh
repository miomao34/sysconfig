#!/bin/bash

cd ~
rm -rf ./sysconfig/
rm -rf ./.git

git clone --no-checkout git@github.com:miomao34/sysconfig.git
mv ./sysconfig/.git .
rm -rf ./sysconfig/

git checkout raspbian
