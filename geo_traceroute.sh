#!/bin/bash
#COUNTRY_CODE_SCRIPT_PATH="/home/administrator/Documents/country.sh"

#echo "Positional Parameters"
#echo '$0 = ' $0
##echo '$1 = ' $1
#echo '$2 = ' $2
#echo '$3 = ' $3



#tracert_result=$(traceroute $1)
#echo $tracert_result

traceroute $1 | sed 1d | while read line ;
do
  OUTPUT=$(echo $line | cut -d " " -f 3 | sed 's/[()]//g');
  #echo $OUTPUT;
  if [ "$OUTPUT" == "$0" ]; then
    continue;
  fi;
  echo $OUTPUT;
  #echo " ";
  COUNTRY_CODE=$(whois $OUTPUT |grep country -i -m 1 |cut -d ':' -f 2 |xargs);
  #echo $COUNTRY_CODE;
  if [ "$COUNTRY_CODE" == "ZZ" ]; then
    echo "Unknown or unspecified country";
    continue;
  fi;
  bash ./country.sh $COUNTRY_CODE;
  echo " ";
done

#whois 8.8.8.8 |grep country -i -m 1 |cut -d ':' -f 2 |xargs

