#!/bin/bash
# This script shows how to get number of records

source ./global.sh

#get number of records
function get_record_count() {
  target="Tcaplus.GetRecordCount"
  build_headers "$target"
  curl -i -XPOST "${headers[@]}" "$rest_url" -d ""
  echo -e "\n"
}

#declare array variable
declare -a headers


get_record_count