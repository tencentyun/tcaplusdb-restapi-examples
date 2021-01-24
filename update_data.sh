#!/bin/bash
#This script shows how to update record, supporting single update and batch update.
# Note: The batch operation is non-atomic transaction, allowing partial succeed and partial fail

#load global configs
source ./global.sh

#build update request data
function build_update_data() {
    cat <<EOF
{
    "Record": {
        "player_id":4,
        "player_name":"4",
        "player_email":"4",
        "game_server_id":4,
        "login_timestamp":["123456"],
        "logout_timestamp":["123456"],
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

function build_batch_update_data() {
    cat <<EOF
{
    "MultiRecords": [{
            "RecordVersion": 1,
            "Record": {
                "player_id":5,
                "player_name":"5",
                "player_email":"5",
                "game_server_id":5,
                "login_timestamp":["123456"],
                "logout_timestamp":["123456"],
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
                "login_timestamp":["123456"],
                "logout_timestamp":["123456"],
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


function update_data() {
  target="Tcaplus.UpdateRecord"
  build_headers "$target"
  curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_update_data)"
  echo -e "\n"
}

function batch_update_data(){
    target="Tcaplus.BatchUpdateRecords"
    build_headers "$target"
    curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_batch_update_data)"
    echo -e "\n"
}
#declare array variable
declare -a headers

#update one record
update_data
#update batch records
batch_update_data
