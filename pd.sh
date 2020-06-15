#!/bin/bash

sid=$(openssl rand -base64 16 | tr -dc 'a-z0-9' | head -c 6)

echo $* | tr '|' '\n' | awk -v sid="$sid" 'BEGIN { 
                                             printf("#!/bin/bash\n"); printf("mkdir %s\n",sid) 
                                           } 
                                           NR == 1 { 
                                             printf("%s > ./%s/%s.out 2> ./%s/%s.err \n echo %s. Exit status of %s is $?\n", $0, sid, NR, sid, NR, NR, $0) 
                                           } 
                                           NR>1 { 
                                             printf("%s < ./%s/%s.out > %s/%s.out 2> ./%s/%s.err \n echo %s. Exit status of %s is $?\n", $0, sid, NR-1, sid, NR, sid, NR, NR, $0) 
                                           } 
                                           END {
                                             printf("echo The stdouts and stderrs are in ./%s dir\n",sid) 
                                           }' > $sid.sh

echo "To run: chmod +x $sid.sh; ./$sid.sh"

