#!/bin/bash
#load global configs
source ./global.sh

#List Table Get Operation
# Support three kinds of get operation:
# 1. get one record with specified index and primary key of record
# 2. get multi-record with specified indexes and primary key of record
# 3. get all record with specified primary key of record
#build get request data

# @param Record: primary key of record
# @param Index: index of record
function build_get_data() {
    cat <<EOF
{
    "Record": {
                "openid": 1,
                "timekey": "1",
                "tconndid": 1
        },
    "Index": 1
}
EOF
}

#build batchget request data
# @param Indexes: indexes of record to return
# @param Record: primary key of record
function build_batch_get_data(){
     cat <<EOF
{
    "Indexes": [4,5],
    "Record": {
		"openid": 1,
		"timekey": "1",
		"tconndid": 1
    }
}

EOF
}

# @param Record: primary key
# @param Offset: offset position of record
# @param Limit:  limit the number of records to return, -1: return all records
function build_get_all_data() {
	cat <<EOF
{
    "Record": {
                "openid": 6,
                "timekey": "6",
                "tconndid": 6
        },
    "Offset": 0,
    "Limit": -1
}
EOF
}

# get one record with index and primary key of record
function get_data() {
  target="Tcaplus.ListGetRecord"
  build_list_headers "$target"
  curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_get_data)"
  echo -e "\n"
}

#get multi-record with specified indexes and primary key
function batch_get_data(){
    target="Tcaplus.ListBatchGetRecords"
    build_list_headers "$target"
    curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_batch_get_data)"
    echo -e "\n"
}

# get all records with specified primary key
function get_all_data(){
  target="Tcaplus.ListGetAllRecords"
  build_list_headers "$target"
  curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_get_all_data)"
  echo -e "\n"
}

#declare array variable
declare -a headers
#get one record
get_data
#get batch records
batch_get_data

get_all_data
