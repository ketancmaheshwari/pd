#!/bin/bash

fname=$(openssl rand -base64 16 | tr -dc 'a-z0-9' | head -c 4)

echo "${*}" | tr '|' '\n' | awk 'NR==1{printf("%s >%s.out 2>%s.err\n", $1,$1,$1); prev=$1} NR>1{printf("%s <%s.out >%s.out 2>%s.err\n", $1,prev,$1,$1);prev=$1}' > $fname.sh

/bin/bash $fname.sh

