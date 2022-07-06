#!/bin/bash

rm -rf dist
npm run build
tar -czvf dist.tar.gz dist
scp dist.tar.gz deploy@stldevs.com:~
ssh deploy@stldevs.com << EOF
  tar zxf dist.tar.gz -C /opt/justone/www
  rm dist.tar.gz
EOF
