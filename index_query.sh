#!/bin/bash
# This script shows how to query data with secondary indexex, supporting like,not like,in, not in, >=,>,<=,<, max, min, avg, count, e.g.
# Note: SQL syntax see the attachment of `README.md`
# Note: The where condition is essential, including field defined in secondary index, limit, and offset. Can't use those fields that are not defined in secondary index as where condition

source ./global.sh

# Requirements:
# First, add global secondary index in tencent cloud console, such as  game_server_id
# Second, the where condition must contain field defined in global secondary index but not fields that did not define in global secondary index.
# limit : limit the number of records to return
# offset: specify the offset pos of returning records
# Supporting SQL syntax: see README.md
function build_query_data() {
    cat <<EOF
{
    "Query": "select player_id, player_name,player_email, game_server_id, pay.amount from game_players where game_server_id>0 limit 1 offset 0"
}
EOF
}


function index_query(){
    target="Tcaplus.IndexQuery"
    build_headers "$target"
    curl -i -XPOST "${headers[@]}" "$rest_url" -d "$(build_query_data)"
    echo -e "\n"
}

declare -a headers

index_query