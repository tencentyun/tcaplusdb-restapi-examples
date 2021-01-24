#!/bin/bash
#This script shows how to update partial fields of one record.
# FieldPath: Specify the fields' name that need to be update
# Record: Specify the primary key field and updated fields of record


#load global configs
source ./global.sh

#build fieldupdate request data
function build_fieldupdate_data() {
    cat <<EOF
{
    "FieldPath": ["is_online"],
    "Record": {
        "player_id":5,
        "player_name":"5",
        "player_email":"5",
        "is_online": true

    }
}
EOF
}


#update partial field of one record, use `FieldPath` to specify the field that  need to return
function fieldupdate_data() {
  target="Tcaplus.FieldUpdateRecord"
  build_headers "$target"
  curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_fieldupdate_data)"
  echo -e "\n"
}


#declare array variable
declare -a headers


fieldupdate_data

