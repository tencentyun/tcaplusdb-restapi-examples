#!/bin/bash
#load global configs
source ./global.sh

# List Table Delete Operation
# Support three kinds of delete:
# 1. Specify one index of record with primary key to delete one record
# 2. Specify multiple indexes of record with primary key to delete multiple records
# 3. Delete all records with primary key
#build delete request data
#@param Index: the index of record, similar with array index
#@param Record: the primary key of record
function build_delete_data() {
    cat <<EOF
{
    "Index": 3,
    "Record": {
        "openid":1,
        "tconndid":1,
        "timekey": "1"
    }
}
EOF
}

#build batchdelete request data
function build_batch_delete_data(){
     cat <<EOF
{
        "Record": {
            "openid":1,
            "tconndid":1,
            "timekey": "1"
        },
        "Indexes":[4,5]

}
EOF
}

#build DeleteAll data
# @param Record : primary key of record
function build_delete_all_data() {
	cat <<EOF
{
        "Record": {
            "openid":1,
            "tconndid":1,
            "timekey": "1"
        }

}
EOF
}

#delete one record with index of specified primary key of record
function delete_data() {
  target="Tcaplus.ListDeleteRecord"
  build_list_headers "$target"
  curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_delete_data)"
  echo -e "\n"
}

#delete multi-record with indexes of specified primary key of record
function batch_delete_data(){
    target="Tcaplus.ListBatchDeleteRecords"
    build_list_headers "$target"
    curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_batch_delete_data)"
    echo -e "\n"
}

#delete all records of specified primary key of record
function delete_all_data(){
    target="Tcaplus.ListDeleteAllRecords"
    build_list_headers "$target"
    curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_delete_all_data)"
    echo -e "\n"
}

#declare array variable
declare -a headers


#delete one record
delete_data
#delete batch records
batch_delete_data

delete_all_data
