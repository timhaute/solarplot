#/bin/bash

REMOTE=xx.xx.xx.xx

#Copy plots
for i in 24 48 week
do
scp /tmp/output$i.png matthieu@$REMOTE:/data/solar/
done

#Copy latest data
scp /tmp/index.html matthieu@$REMOTE:/data/solar/
