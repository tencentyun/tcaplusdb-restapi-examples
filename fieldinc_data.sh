#!/bin/bash
#This script shows how to increase the value of numeric field of record.
#FieldPath: Specify the fields that need to be increased
#Record: Specify the primary key fields and increased fields of record
#For example, `game_server_id` old value is 5, when calling this api and increase 1, the new value will be 6


#load global configs
source ./global.sh

#build fieldinc request data
function build_fieldinc_data() {
    cat <<EOF
{
    "FieldPath": ["game_server_id"],
    "Record": {
        "player_id":5,
        "player_name":"5",
        "player_email":"5",
        "game_server_id": 1

    }
}
EOF
}


#increase the value of numeric fields that specified by `FieldPath`, e.g, old value: 5, increase value: 1, new value: 6
function fieldinc_data() {
  target="Tcaplus.FieldIncRecord"
  build_headers "$target"
  curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_fieldinc_data)"
  echo -e "\n"
}


#declare array variable
declare -a headers


fieldinc_data

