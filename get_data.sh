#!/bin/bash
#This script shows how to get records , supporting single get, batch get and get by index of primary key
# Support specifying partial fields to return by `Select` attribute, similar with `FieldGetRecord` API
# Record: Specify the primary key of record
# Select: Specify the fields that need to return

#load global configs
source ./global.sh

#build get request data
function build_get_data() {
    cat <<EOF
{
    "Record": {
        "player_id":5,
        "player_name":"5",
        "player_email":"5"
    },
    "Select":["game_server_id", "is_online", "pay"]
}
EOF
}

#build batchget request data
function build_batch_get_data(){
     cat <<EOF
{
    "MultiRecords": [{
        "RecordVersion": 1,
        "Record": {
            "player_id":5,
            "player_name":"5",
            "player_email":"5"
        }
    }, {
        "RecordVersion": 1,
        "Record": {
            "player_id":6,
            "player_name":"6",
            "player_email":"6"
        }
    }]
}
EOF
}

#build get request data
function build_get_by_partkey_data() {
    cat <<EOF
{
    "Record": {
        "player_id":5,
        "player_name":"5"
    },
    "Select":["game_server_id", "is_online", "pay"]
}
EOF
}


function get_data() {
  target="Tcaplus.GetRecord"
  build_headers "$target"
  curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_get_data)"
  echo -e "\n"
}

function batch_get_data(){
    target="Tcaplus.BatchGetRecords"
    build_headers "$target"
    curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_batch_get_data)"
    echo -e "\n"
}

function get_by_partkey_data(){
    target="Tcaplus.GetRecordByPartKey"
    build_headers "$target"
    curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_get_by_partkey_data)"
    echo -e "\n"
}
#declare array variable
declare -a headers

#get one record
get_data
#get batch records
batch_get_data
#get records by index of primary key
get_by_partkey_data
