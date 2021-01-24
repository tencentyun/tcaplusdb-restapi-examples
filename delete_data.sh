#!/bin/bash
# This script shows how to delete tcaplusdb records, supporting single delete, batch delete and delete by index of primary key
#Record: Specify the primary key fields of record that need to be deleted
# Note: The batch operation is non-atomic transaction, allowing partial succeed and partial fail

#load global configs
source ./global.sh

#build delete request data
function build_delete_data() {
    cat <<EOF
{
    "RecordVersion": 1,
    "Record": {
        "player_id":4,
        "player_name":"4",
        "player_email":"4"
    }
}
EOF
}

#build batchdelete request data
#Note: RecordVersion is optional, specify the version in request
function build_batch_delete_data(){
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

#build delete request data, delete record by index of primary key
#Note: index of primary key is defined in table schema proto file, see option(tcaplusservice.tcaplus_index)
function build_delete_by_partkey_data() {
    cat <<EOF
{
    "RecordVersion": 1,
    "Record": {
        "player_id":5,
        "player_name":"5"
    }
}
EOF
}

function delete_data() {
  target="Tcaplus.DeleteRecord"
  build_headers "$target"
  curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_delete_data)"
  echo -e "\n"
}

function batch_delete_data(){
    target="Tcaplus.BatchDeleteRecords"
    build_headers "$target"
    curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_batch_delete_data)"
    echo -e "\n"
}

function delete_by_partkey_data(){
    target="Tcaplus.DeleteRecordByPartKey"
    build_headers "$target"
    curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_delete_by_partkey_data)"
    echo -e "\n"
}
#declare array variable
declare -a headers

#delete one record
delete_data
#delete batch records
batch_delete_data
#delete record by index of primary key
delete_by_partkey_data