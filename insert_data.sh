#!/bin/bash
#This script shows how to insert data, supporting single insert and batch insert
# Record: Specify the whole record fields

#load global configs
source ./global.sh

#build insert request data, the whole record data
function build_insert_data() {
    cat <<EOF
{
    "Record": {
        "player_id":4,
        "player_name":"4",
        "player_email":"4",
        "game_server_id":4,
        "login_timestamp":[],
        "logout_timestamp":[],
        "is_online":false,
        "pay": {
            "pay_id": 4,
            "amount": 4,
            "method": 4
        }
    }
}
EOF
}

#build batch insert request data
#Note: RecordVersion is optional, combine with CHECK_POLICY parameter to check record version
function build_batch_insert_data() {
    cat <<EOF
{
    "MultiRecords": [{
            "RecordVersion": 1,
            "Record": {
                "player_id":5,
                "player_name":"5",
                "player_email":"5",
                "game_server_id":5,
                "login_timestamp":[],
                "logout_timestamp":[],
                "is_online":false,
                "pay": {
                    "pay_id": 5,
                    "amount": 5,
                    "method": 5
                }
            }
        }, {
            "RecordVersion": 1,
            "Record": {
                "player_id":5,
                "player_name":"5",
                "player_email":"55",
                "game_server_id":55,
                "login_timestamp":[],
                "logout_timestamp":[],
                "is_online":false,
                "pay": {
                    "pay_id": 55,
                    "amount": 55,
                    "method": 55
                }
            }
        },{
            "RecordVersion": 1,
            "Record": {
                "player_id":6,
                "player_name":"6",
                "player_email":"6",
                "game_server_id":6,
                "login_timestamp":[],
                "logout_timestamp":[],
                "is_online":false,
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


function insert_data() {
  target="Tcaplus.InsertRecord"
  build_headers "$target"
  curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_insert_data)"
  echo -e "\n"
}

function batch_insert_data(){
    target="Tcaplus.BatchInsertRecords"
    build_headers "$target"
    curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_batch_insert_data)"
    echo -e "\n"
}
#declare array variable
declare -a headers
#build request headers
build_headers
#insert one record
insert_data
#insert batch records
batch_insert_data
