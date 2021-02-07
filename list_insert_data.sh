#!/bin/bash
#load global configs
source ./global.sh

#List table Insert Operation
#Support two kinds of insert operation
# 1. insert one record with index and record
# 2. insert multi-record
#build insert request data
# @param Index: specify the insert position, -1: tail of list, -2 : head of list
# @param Record: the record that need to be inserted
function build_insert_data() {
    cat <<EOF
{
    "Index": -1,
    "Record": {
        "openid":1,
        "tconndid":1,
        "timekey":"1",
        "gamesvrid":"1",
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

# @param MultiRecords: the set of  records
# @param Index: index of sub record
function build_batch_insert_data() {
    cat <<EOF
{
    "MultiRecords": [{
        "Index": -1,
        "Record": {
        "openid":1,
        "tconndid":1,
        "timekey":"1",
        "gamesvrid":"2",
        "logintime":2,
        "lockid":[],
        "pay": {
            "total_money": 2,
            "pay_times": 2
        }
    }},{

        "Index": -1,
        "Record": {
        "openid":1,
        "tconndid":1,
        "timekey":"1",
        "gamesvrid":"3",
        "logintime":3,
        "lockid":[],
        "pay": {
            "total_money": 3,
            "pay_times": 3
        }
    }},{
        "Index": -1,
        "Record": {
        "openid":1,
        "tconndid":1,
        "timekey":"1",
        "gamesvrid":"4",
        "logintime":4,
        "lockid":[],
        "pay": {
            "total_money": 4,
            "pay_times": 4
        }
    }
        }]
}
EOF
}


function insert_data() {
  target="Tcaplus.ListInsertRecord"
  build_list_headers "$target"
  curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_insert_data)"
  echo -e "\n"
}

function batch_insert_data(){
    target="Tcaplus.ListBatchInsertRecords"
    build_list_headers "$target"
    curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_batch_insert_data)"
    echo -e "\n"
}
#declare array variable
declare -a headers
#insert one record
insert_data
#insert batch records
batch_insert_data

