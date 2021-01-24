#!/bin/bash
#This script shows how to replace records, supporting single replace and batch replace. If the record exists, the operation will replace it, if the record does not exist, the operation will insert new record.


#load global configs
source ./global.sh

#build replace request data
function build_replace_data() {
    cat <<EOF
{
    "Record": {
        "player_id":4,
        "player_name":"4",
        "player_email":"4",
        "game_server_id":4,
        "login_timestamp":["123456","234"],
        "logout_timestamp":["123456","234"],
        "is_online":true,
        "pay": {
            "pay_id": 4,
            "amount": 4,
            "method": 4
        }
    }
}
EOF
}

function build_batch_replace_data() {
    cat <<EOF
{
    "MultiRecords": [{
            "RecordVersion": 1,
            "Record": {
                "player_id":5,
                "player_name":"5",
                "player_email":"5",
                "game_server_id":5,
                "login_timestamp":["123456","234"],
                "logout_timestamp":["123456","234"],
                "is_online":true,
                "pay": {
                    "pay_id": 5,
                    "amount": 5,
                    "method": 5
                }
            }
        }, {
            "RecordVersion": 1,
            "Record": {
                "player_id":6,
                "player_name":"6",
                "player_email":"6",
                "game_server_id":6,
                "login_timestamp":["123456","234"],
                "logout_timestamp":["123456","234"],
                "is_online":true,
                "pay": {
                    "pay_id": 6,
                    "amount": 6,
                    "method": 6
                }
            }
        }]
}
EOF
}


function replace_data() {
  target="Tcaplus.ReplaceRecord"
  build_headers "$target"
  curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_replace_data)"
  echo -e "\n"
}

function batch_replace_data(){
    target="Tcaplus.BatchReplaceRecords"
    build_headers "$target"
    curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_batch_replace_data)"
    echo -e "\n"
}
#declare array variable
declare -a headers

#replace one record
replace_data
#replace batch records
batch_replace_data
