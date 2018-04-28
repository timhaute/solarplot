#/bin/bash
# extract data from sqlite database
#################

TEMPindex=/tmp/index.html
TEMP24=/tmp/last24.csv
TEMP48=/tmp/last48.csv
TEMPweek=/tmp/lastweek.csv

sqlite3 -csv /root/vbus-collector/data.db \
"SELECT datetime(time,'+2 hours'),temp1,temp2,temp3,temp4,temp6,pump1/3 FROM data WHERE data.time >= datetime('now','-1 day') AND data.temp4 > 0;" \
> $TEMP24

sqlite3 -csv /root/vbus-collector/data.db \
"SELECT datetime(time,'+2 hours'),temp1,temp2,temp3,temp4,temp6,pump1/3 FROM data WHERE data.time >= datetime('now','-2 day') AND data.temp4 > 0;" \
> $TEMP48

sqlite3 -csv /root/vbus-collector/data.db \
"SELECT datetime(time,'+2 hours'),temp1,temp2,temp3,temp4,temp6,pump1/3 FROM data WHERE data.time >= datetime('now','-7 day') AND data.temp4 > 0;" \
> $TEMPweek

INSERT=`tail -1 /tmp/last24.csv  | awk -F, '{print \
  "<table border=1>\
   <tr>\
    <th>date</th>\
    <th>Roof F1</th>\
    <th>F2</th>\
    <th>Tank bottom F3</th>\
    <th>F4</th>\
    <th>Tank top F6</th>\
    <th>Pump/3 %</th>\
   </tr>\
   <tr>\
    <td align=center>"$1"</td>\
    <td align=center>"$2"</td>\
    <td align=center>"$3"</td>\
    <td align=center>"$4"</td>\
    <td align=center>"$5"</td>\
    <td align=center>"$6"</td>\
    <td align=center>"$7"</td>\
   </tr>\
  </table>"\
}'`

sed "/<p>/a $INSERT" /root/bin/index.template > $TEMPindex
