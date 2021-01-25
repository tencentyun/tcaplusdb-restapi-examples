#!/bin/bash

#load global configs
source ./global.sh


function build_traverse_data(){
    cat <<EOF
{
    "Limit": 3,
    "TraveseSession":"0.0",
    "ReturnValues": "user buffers, to build a bridge between request and response, use case: global object that do not want to save in memory"
}
EOF
}

#traverse all records of table, specify `Limit` attr to limit numbers of record of response
#if table has massive data, each response size has a limit level (10M-level), if the size of records is over this limit
# user should check the return flag `complete` to check whether the records have been traversed
# if `complete` flag is false, use for-loop to traverse the remaining records
# best practice: combine `Limit` attr and `complete` flag to control number of records of each response and to check number of remaining records
function traverse() {
  target="Tcaplus.Traverse"
  build_headers "$target"
  curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_traverse_data)"
  echo -e "\n"
}

#declare array variable
declare -a headers


traverse
