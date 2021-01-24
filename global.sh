#!/bin/bash
#######################Start TcaplusDB Common Configs####################
#required, RESTful API version, support: 1.0 and 2.0, here use 2.0 default
PROTO_VERSION="2.0"
#required, TcaplusDB Version, default : Tcaplus3.50.0
TCAPLUS_VERSION="Tcaplus3.50.0"
#required, protocol type, default: protobuf
IDL_TYPE="protobuf"
#optional, TcaplusDB record version check policy,default: 3
# 1->check version consistency between version in request and version in server side, if in-consistenty the request will return error
# 2->do not check version consistency, the record version in server side will be overwritten by the version specified in request
# 3->do not check version consistency, the record version in server side will be auto-incremented.
CHECK_POLICY=3

#optional, control the response type, default: 2
# 0 -> Not return the record data  if without any errors
# 1 -> Return the record data that contains record before updated and record after updated
# 2 -> Return the record data after updated
# 3 -> Return the record data before updated
result_flag=2

################End TcaplusDB Common Configs###############

################Start TcaplusDB Connection Infos############
#required, restapi endpoint, refer to https://cloud.tencent.com/document/product/596/31652
#default port is 80
rest_url="http://172.17.32.17"

#required, TcaplusDB cluster access id (aka, app_id), refer to https://cloud.tencent.com/document/product/596/31652, replace your access id
app_id=70

#required, TcaplusDB table group id (aka, zone_id), refer to https://cloud.tencent.com/document/product/596/31652,  replace your zone id
zone_id=1

#required, TcaplusDB table name, replace your table name
table_name="game_players"

#required TcaplusDB cluster access password, refer to https://cloud.tencent.com/document/product/596/31652, replace your password
passwd="Tcaplus@2020"

#caculate the md5 value of password
md5_passwd=$(echo -n $passwd | md5sum | cut -d ' ' -f1)
################End TcaplusDB Connection Infos########


#build request headers
#dynamic header option: x-tcaplus-target, which is TcaplusDB RESTful method, supporting methods  of generic table are as below:
# Tcaplus.InsertRecord : Insert one record, return error if record exists
# Tcaplus.BatchInsertRecords: Insert multi-record, non-atomic transaction, allow partial successful and partial failed
# Tcaplus.GetRecord: Get one record, return error if record does not exist
# Tcaplus.BatchGetRecords: Get multi-record, non-atomic transaction, allow return partial records
# Tcaplus.GetRecordByPartKey: Get multi-record with index of primary key (defined in proto file, tcaplusservice.tcaplus_index)
# Tcaplus.UpdateRecord: Update one record, return error if record does not exist
# Tcaplus.BatchUpdateRecords: Update multi-record, non-atomic transaction, allow partial successful and partial failed
# Tcaplus.ReplaceRecord: Replace one record, update record if exists, insert record if not exist
# Tcaplus.BatchReplaceRecords:  Replace multi-record, non-atomic transaction, allow partial successful and partial failed
# Tcaplus.DeleteRecord: Delete one record with primary key, return error if not exist
# Tcaplus.BatchDeleteRecords: Delete multi-record , non-atomic transaction, allow partial successful and partial failed
# Tcaplus.DeleteRecordByPartKey: Delete batch records with index of primary key (defined in proto file,tcaplusservice.tcaplus_index),
# Tcaplus.FieldGetRecord: Get partial fields of one record, according to `FieldPath` attribute to specify the partial fields' name
# Tcaplus.BatchFieldGetRecords: Get partial fields of multi-record
# Tcaplus.FieldIncRecord: Self-incremented  value of  numeric fields, atomic transaction, e.g. used in player level update
# Tcaplus.FieldUpdateRecord: Update partial fields of one record, according to `FieldPath` attribute to specify the partial fields' name
# Tcaplus.Traverse: Traverse all records of one table
# Tcaplus.GetRecordCount: Get number of records of table
# Tcaplus.IndexQuery: Query data by secondary index , use SQL syntax to query records
function build_headers(){
    headers=(
        -H "x-tcaplus-target: ${1}"
        -H "x-tcaplus-app-id: ${app_id}"
        -H "x-tcaplus-zone-id: ${zone_id}"
        -H "x-tcaplus-protocol-version: ${PROTO_VERSION}"
        -H "x-tcaplus-table-name: ${table_name}"
        -H "x-tcaplus-pwd-md5: ${md5_passwd}"
        -H "x-tcaplus-result-flag: ${result_flag}"
        -H "x-tcaplus-version: ${TCAPLUS_VERSION}"
        -H "x-tcaplus-data-version-check: ${CHECK_POLICY}"
        -H "x-tcaplus-idl-type: ${IDL_TYPE}"
    )
}