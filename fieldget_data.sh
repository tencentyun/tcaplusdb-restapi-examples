#!/bin/bash
#This script shows how to get partial fields of record, supporting get partial fields of one record, and get partial fields of multi-records with primary key
#FieldPath: Specify the fields' name that need to be return
#Record: Specify the primary key of the specified record

#load global configs
source ./global.sh

#build fieldget request data
function build_fieldget_data() {
    cat <<EOF
{
    "FieldPath": ["game_server_id", "pay"],
    "Record": {
        "player_id":5,
        "player_name":"5",
        "player_email":"5"
    }
}
EOF
}

#build batchfieldget request data
function build_batch_fieldget_data(){
     cat <<EOF
{
    "FieldPath": ["game_server_id", "pay"],
    "MultiRecords": [{
        "Record": {
            "player_id":5,
            "player_name":"5",
            "player_email":"5"
        }
    }, {
        "Record": {
            "player_id":6,
            "player_name":"6",
            "player_email":"6"
        }
    }]
}
EOF
}

#get partial field of one record, use `FieldPath` to specify the field that  need to return
function fieldget_data() {
  target="Tcaplus.FieldGetRecord"
  build_headers "$target"
  curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_fieldget_data)"
  echo -e "\n"
}
#get partial field of multi-record, return batch records if match
function batch_fieldget_data(){
    target="Tcaplus.BatchFieldGetRecords"
    build_headers "$target"
    curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_batch_fieldget_data)"
    echo -e "\n"
}

#declare array variable
declare -a headers


fieldget_data

batch_fieldget_data

