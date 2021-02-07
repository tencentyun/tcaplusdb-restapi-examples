#!/bin/bash
#load global configs
source ./global.sh

#List table Update Operation
# Support two kinds of update operation
# 1. update one record with specified index
# 2. update batch records with relative index

#build update request data
function build_update_data() {
    cat <<EOF
{
    "Index": 0,
    "Record": {
        "openid":1,
        "tconndid":1,
        "timekey":"1",
        "gamesvrid":"2",
        "logintime":1,
        "lockid":[],
        "pay": {
            "total_money": 1,
            "pay_times": 1
        }
    }
}
EOF
}

function build_batch_update_data() {
    cat <<EOF
{
    "MultiRecords": [{
        "Index": 1,
        "Record": {
        "openid":1,
        "tconndid":1,
        "timekey":"1",
        "gamesvrid":"11",
        "logintime":1,
        "lockid":[],
        "pay": {
            "total_money": 1,
            "pay_times": 1
        }
    }},{

        "Index": 2,
        "Record": {
        "openid":1,
        "tconndid":1,
        "timekey":"1",
        "gamesvrid":"22",
        "logintime":22,
        "lockid":[],
        "pay": {
            "total_money": 22,
            "pay_times": 22
        }
    }}
    ]
}
EOF
}


function update_data() {
  target="Tcaplus.ListUpdateRecord"
  build_list_headers "$target"
  curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_update_data)"
  echo -e "\n"
}

function batch_update_data(){
    target="Tcaplus.ListBatchUpdateRecords"
    build_list_headers "$target"
    curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_batch_update_data)"
    echo -e "\n"
}
#declare array variable
declare -a headers
#update one record
update_data
#update batch records
batch_update_data

