#!/bin/bash

#load global configs
source ./global.sh


function build_traverse_data(){
    cat <<EOF
{
    "Limit": 100,
    "TraveseSession": "0.0",
    "Select": ["gamesvrid"]
}
EOF
}
function build_traverse_loop_data(){
    cat <<EOF
{
    "Limit": 1,
    "TraveseSession": "$1",
    "Select": ["gamesvrid"]
}
EOF
}

#traverse all records of table, specify `Limit` attr to limit numbers of record of response
function traverse() {
  target="Tcaplus.ListTraverse"
  build_list_headers "$target"
  curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_traverse_data)"
  echo -e "\n"
}
function traverse_loop() {
  target="Tcaplus.ListTraverse"
  build_list_headers "$target"
  complete="False"
  limit=1
  traverse_session="0.0"
  total_num=0
  while [ "$complete" == "False" ];do 
      ret=$(curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_traverse_loop_data $traverse_session)" | grep -v HTTP | grep -v "json-1.0" | grep -v "content-length" | grep -v "^$" )
      echo "$ret"
      
      complete=$( echo "$ret" | python3 -c "import sys, json; print(json.load(sys.stdin)['Complete'])" )
      traverse_session=$( echo "$ret" | python3 -c "import sys, json; print(json.load(sys.stdin)['TraveseSession'])" )

      if [ "$complete" == "False" ];then

          total_num=$(($total_num+1))
      fi
      
  done
  echo "TotalRecords:$total_num"
}

#declare array variable
declare -a headers

traverse
#traverse_loop
