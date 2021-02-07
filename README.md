# TcaplusDB RESTful API Examples

# Table of Contents

- [前言](#\xE5\x89\x8D\xE8\xA8\x80)
- [前置条件](#\xE5\x89\x8D\xE7\xBD\xAE\xE6\x9D\xA1\xE4\xBB\xB6)
  - [TcaplusDB 表创建](#tcaplusdb-\xE8\xA1\xA8\xE5\x88\x9B\xE5\xBB\xBA)
  - [TcaplusDB 表全局索引创建](#tcaplusdb-\xE8\xA1\xA8\xE5\x85\xA8\xE5\xB1\x80\xE7\xB4\xA2\xE5\xBC\x95\xE5\x88\x9B\xE5\xBB\xBA)
  - [测试机器申请](#\xE6\xB5\x8B\xE8\xAF\x95\xE6\x9C\xBA\xE5\x99\xA8\xE7\x94\xB3\xE8\xAF\xB7)
- [RESTful API](#restful-api)
  - [接口汇总](#\xE6\x8E\xA5\xE5\x8F\xA3\xE6\xB1\x87\xE6\x80\xBB)
  - [接口示例](#\xE6\x8E\xA5\xE5\x8F\xA3\xE7\xA4\xBA\xE4\xBE\x8B)
    - [示例公共参数说明](#\xE7\xA4\xBA\xE4\xBE\x8B\xE5\x85\xAC\xE5\x85\xB1\xE5\x8F\x82\xE6\x95\xB0\xE8\xAF\xB4\xE6\x98\x8E)
    - [示例脚本说明](#\xE7\xA4\xBA\xE4\xBE\x8B\xE8\x84\x9A\xE6\x9C\xAC\xE8\xAF\xB4\xE6\x98\x8E)
  - [接口响应处理](#\xE6\x8E\xA5\xE5\x8F\xA3\xE5\x93\x8D\xE5\xBA\x94\xE5\xA4\x84\xE7\x90\x86)
  - [接口使用场景](#\xE6\x8E\xA5\xE5\x8F\xA3\xE4\xBD\xBF\xE7\x94\xA8\xE5\x9C\xBA\xE6\x99\xAF)
    - [基本增删查改场景](#\xE5\x9F\xBA\xE6\x9C\xAC\xE5\xA2\x9E\xE5\x88\xA0\xE6\x9F\xA5\xE6\x94\xB9\xE5\x9C\xBA\xE6\x99\xAF)
    - [其它常用场景](#\xE5\x85\xB6\xE5\xAE\x83\xE5\xB8\xB8\xE7\x94\xA8\xE5\x9C\xBA\xE6\x99\xAF)
- [附录](#\xE9\x99\x84\xE5\xBD\x95)
  - [常见错误码](#\xE5\xB8\xB8\xE8\xA7\x81\xE9\x94\x99\xE8\xAF\xAF\xE7\xA0\x81)
  - [全局二级索引支持的 SQL 语法](#\xE5\x85\xA8\xE5\xB1\x80\xE4\xBA\x8C\xE7\xBA\xA7\xE7\xB4\xA2\xE5\xBC\x95\xE6\x94\xAF\xE6\x8C\x81\xE7\x9A\x84-sql-\xE8\xAF\xAD\xE6\xB3\x95)
    - [条件查询](#\xE6\x9D\xA1\xE4\xBB\xB6\xE6\x9F\xA5\xE8\xAF\xA2)
    - [分页查询](#\xE5\x88\x86\xE9\xA1\xB5\xE6\x9F\xA5\xE8\xAF\xA2)
    - [聚合查询](#\xE8\x81\x9A\xE5\x90\x88\xE6\x9F\xA5\xE8\xAF\xA2)
    - [支持查询部分字段的值](#\xE6\x94\xAF\xE6\x8C\x81\xE6\x9F\xA5\xE8\xAF\xA2\xE9\x83\xA8\xE5\x88\x86\xE5\xAD\x97\xE6\xAE\xB5\xE7\x9A\x84\xE5\x80\xBC)
    - [不支持的 sql 查询语句](#\xE4\xB8\x8D\xE6\x94\xAF\xE6\x8C\x81\xE7\x9A\x84-sql-\xE6\x9F\xA5\xE8\xAF\xA2\xE8\xAF\xAD\xE5\x8F\xA5)
      - [不支持聚合查询与非聚合查询混用](#\xE4\xB8\x8D\xE6\x94\xAF\xE6\x8C\x81\xE8\x81\x9A\xE5\x90\x88\xE6\x9F\xA5\xE8\xAF\xA2\xE4\xB8\x8E\xE9\x9D\x9E\xE8\x81\x9A\xE5\x90\x88\xE6\x9F\xA5\xE8\xAF\xA2\xE6\xB7\xB7\xE7\x94\xA8)
      - [不支持 order by 查询](#\xE4\xB8\x8D\xE6\x94\xAF\xE6\x8C\x81-order-by-\xE6\x9F\xA5\xE8\xAF\xA2)
      - [不支持 group by 查询](#\xE4\xB8\x8D\xE6\x94\xAF\xE6\x8C\x81-group-by-\xE6\x9F\xA5\xE8\xAF\xA2)
      - [不支持 having 查询](#\xE4\xB8\x8D\xE6\x94\xAF\xE6\x8C\x81-having-\xE6\x9F\xA5\xE8\xAF\xA2)
      - [不支持多表联合查询](#\xE4\xB8\x8D\xE6\x94\xAF\xE6\x8C\x81\xE5\xA4\x9A\xE8\xA1\xA8\xE8\x81\x94\xE5\x90\x88\xE6\x9F\xA5\xE8\xAF\xA2)
      - [不支持嵌套 select 查询](#\xE4\xB8\x8D\xE6\x94\xAF\xE6\x8C\x81\xE5\xB5\x8C\xE5\xA5\x97-select-\xE6\x9F\xA5\xE8\xAF\xA2)
      - [不支持别名](#\xE4\xB8\x8D\xE6\x94\xAF\xE6\x8C\x81\xE5\x88\xAB\xE5\x90\x8D)
      - [不支持的其他查询](#\xE4\xB8\x8D\xE6\x94\xAF\xE6\x8C\x81\xE7\x9A\x84\xE5\x85\xB6\xE4\xBB\x96\xE6\x9F\xA5\xE8\xAF\xA2)

# 前言

TcaplusDB RESTful API 基于通用 RESTful 协议进行设计，满足用户基于 RESTful 协议进行开发场景。主要分两类接口，一类是`Generic表`的接口，另一类是`List表`的接口。

- 详细的 RESTful 接口使用手册请参考目录下：`document/TcaplusDB_RESTful_SDK_v2_User_Guide.pdf`。
- Generic 表和 List 表区别参考目录下：`TcaplusDB的Generic表和List表介绍.pdf`。

# 前置条件

## TcaplusDB 表创建

假定用户已经在腾讯云控制台已创建 TcaplusDB 表，如果未创建，请参照官网：[创建表](https://cloud.tencent.com/document/product/596/38808)。具体步骤：

- 创建集群
- 创建表格组
- 创建表

### Generic 表示例

本文档以示例表`game_players.proto`举例，　示例表定义文件如下：

```
syntax = "proto3";                      // Specify the version of the protocol buffers language


import "tcaplusservice.optionv1.proto"; // Use the public definitions of TcaplusDB by importing them.

message game_players {  // Define a TcaplusDB table with message

	// Specify the primary keys with the option tcaplusservice.tcaplus_primary_key
	// The primary key of a TcaplusDB table has a limit of 4 fields
    option(tcaplusservice.tcaplus_primary_key) = "player_id, player_name, player_email";

    // Specify the primary key indexes with the option tcaplusservice.tcaplus_index
    option(tcaplusservice.tcaplus_index) = "index_1(player_id, player_name)";
    option(tcaplusservice.tcaplus_index) = "index_2(player_id, player_email)";


    // Value Types supported by TcaplusDB
    // int32, int64, uint32, uint64, sint32, sint64, bool, fixed64, sfixed64, double, fixed32, sfixed32, float, string, bytes
    // Nested Types Message

    // primary key fields
    uint64 player_id = 1;
    string player_name = 2;
    string player_email = 3;


    // Ordinary fields
    int32 game_server_id = 4;
    repeated string login_timestamp = 5;
    repeated string logout_timestamp = 6;
    bool is_online = 7;

    payment pay = 8;
}


message payment {

	int64 pay_id = 1;
	uint64 amount = 2;
    int64 method = 3;

}
```

### List 表示例

本文档以`tb_online_list`表为示例，如下所示：

```
syntax = "proto3";

package tcaplusservice;

import "tcaplusservice.optionv1.proto";

message tb_online_list {
    option(tcaplusservice.tcaplus_primary_key) = "openid,tconndid,timekey";
    option(tcaplusservice.tcaplus_customattr) = "TableType=LIST;ListNum=1900";

    int32 openid = 1; //QQ Uin
    int32 tconndid = 2;
    string timekey = 3;
    string gamesvrid = 4;
    int32 logintime = 5 ;
    repeated int64 lockid = 6;
    pay_info pay = 7;

    message pay_info {
        uint64 total_money = 1;
        uint64 pay_times = 2;
    }

}
```

## TcaplusDB 表全局索引创建

如果用户希望使用全局二级索引来满足基本的查询场景，　即类似 MySQL 二级索引机制通过 SQL 语法进行数据查询，则用户需要在腾讯云控制台提前为表创建好二级索引。创建方式：

- **Step1**: 提前创建好上述`game_players`表
- **Step2**: 从控制台点击`表格id`进表详情页面，然后进`表格配置`，在底部`索引信息`栏，点击`修改`，添加对应的索引字段
- **Step3**: 查看任务信息，查看索引创建进度

**索引约束**:

- **目前只支持表一级字段作为二级索引字段,即不支持嵌套的字段作为二级索引字段**
- **字段类型不支持将嵌套的类型作为索引字段**
- **字段类型不支持 blob 类型作为索引字段**

## 测试机器申请

腾讯云 CVM 实例用于测试整个 RESTful API, 　注意：保证 CVM 实例 VPC 与 TcaplusDB 所在 VPC 网络保持一致。

# RESTful API

## 接口汇总

### Generic 表接口列表

Generic 表的 RESTful API 目前支持**19**个接口
|序号|接口名|接口说明|
|---|---|---|
| 1| Tcaplus.InsertRecord | Insert one record, return error if record exists |
| 2| Tcaplus.BatchInsertRecords | Insert multi-record, non-atomic transaction, allow partial success and partial failure |
| 3| Tcaplus.GetRecord | Get one record, return error if record does not exist |
| 4| Tcaplus.BatchGetRecords | Get multi-record, non-atomic transaction, allow return partial records |
| 5| Tcaplus.GetRecordByPartKey | Get multi-record with index of primary key (defined in proto file, tcaplusservice.tcaplus_index) |
| 6| Tcaplus.UpdateRecord | Update one record, return error if record does not exist|
| 7| Tcaplus.BatchUpdateRecords | Update multi-record, non-atomic transaction, allow partial success and partial failure |
| 8| Tcaplus.ReplaceRecord | Replace one record, update record if exists, insert record if not exist |
|9 | Tcaplus.BatchReplaceRecords | Replace multi-record, non-atomic transaction, allow partial success and partial failure |
| 10| Tcaplus.DeleteRecord | Delete one record with primary key, return error if not exist |
| 11| Tcaplus.BatchDeleteRecords | Delete multi-record , non-atomic transaction, allow partial success and partial failure |
| 12| Tcaplus.DeleteRecordByPartKey | Delete batch records with index of primary key (defined in proto file,tcaplusservice.tcaplus_index), |
| 13| Tcaplus.FieldGetRecord | Get partial fields of one record, according to `FieldPath` attribute to specify the partial fields' name |
| 14| Tcaplus.BatchFieldGetRecords | Get partial fields of multi-record |
| 15| Tcaplus.FieldIncRecord | Self-incremented value of numeric fields, atomic transaction, e.g. used in player level update |
| 16| Tcaplus.FieldUpdateRecord | Update partial fields of one record, according to `FieldPath` attribute to specify the partial fields' name |
| 17| Tcaplus.Traverse | Traverse all records of one table |
| 18| Tcaplus.GetRecordCount | Get number of records of table |
| 19| Tcaplus.IndexQuery | Query data by secondary index , use SQL syntax to query records |

### List 表接口列表

List 表的 RESTful API 目前支持**12**个接口
|序号|接口名|接口说明|
|---|---|---|
|1|Tcaplus.ListInsertRecord|Insert one record with index , -1: insert in tail of list, -2: insert in head of list|
|2|Tcaplus.ListBatchInsertRecords|Insert multi-record with index|
|3|Tcaplus.ListGetRecord|Get one record with specified list index and primary key|
|4|Tcaplus.ListBatchGetRecords| Get multi-record with specified list indexes and primary key|
|5|Tcaplus.ListGetAllRecords|Get all records with specified primry key|
|6|Tcaplus.ListDeleteRecord|Delete one record with specified index and primary key|
|7|Tcaplus.ListBatchDeleteRecords|Delete multi-record with specified indexes and primary key|
|8|Tcaplus.ListDeleteAllRecords|Delete all records with specified primary key|
|9|Tcaplus.ListUpdateRecord|Update one record with specified index and record|
|10|Tcaplus.ListBatchUpdateRecords|Update multi-record with specified index and records|
|11|Tcaplus.ListTraverse|Traverse all records of table|

## 接口示例

### 示例公共参数说明

公共参数放置在`global.sh`中，如下

```
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
# 0 -> Not return the record data  if succeed
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
```

公共参数涉及几类：

- **TcaplusDB 连接参数**
  - **rest_url**: RESTful 连接终端, 端口默认 80，用户替换成自己的终端
  - **app_id**:　集群访问 id, 用户替换成自己的访问 id
  - **zone_id**: 　表格组 id, 用户替换成自己的表格组 id
  - **table_name**: 表名，用户替换成自己的表名
  - **passwd**: 集群连接密码，用户替换成自己的密码
- **REST api 设置参数**
  - **PROTO_VERSION**: RESTful API 版本, 必须参数，默认：2.0,
  - **TCAPLUS_VERSION**: TcalusDB 版本要求, 必须参数，如果设置的版本与 TcaplusDB 后端最低版本要求不匹配则返回请求错误
  - **IDL_TYPE**: TcaplusDB 表定义类型，必须参数，默认 protobuf
  - **CHECK_POLICY**: TcaplusDB 记录版本检测策略，用于乐观锁并发控制，可选参数，默认：3，取值范围：1，2，3
  - **result_flag**: 控制响应返回的数据类型，根据实际需要设置，可选参数，默认：2，取值范围: 0, 1, 2, 3

### 示例脚本说明

#### Generic 表示例脚本

上述 19 个接口的示例分散在各个不同的`bash`脚本中，同类型的单笔和批量接口放同一个脚本中。具体脚本如下：
|序号|脚本名|脚本说明|
|---|---|---|
|1|insert_data.sh| 包含单笔 InsertRecord 和批量插入 BatchInsertRecords 接口|
|2|get_data.sh|包含单笔 GetRecord 和批量获取 BatchGetRecords，及根据主键索引获取记录 GetByPartkey 接口|
|3|update_data.sh|包含单笔 UpdateRecord，批量 BatchUpdateRecords 接口|
|4|replace_data.sh|包含单笔 ReplaceRecord，批量 BatchReplaceRecords 接口|
|5|delete_data.sh|包含单笔 DeleteRecord, 批量 BatchDeleteRecords, 根据主键索引删除 DeleteByPartkey 接口|
|6|fieldget_data.sh|包含单笔 FieldGetRecord，批量 BatchFieldGetRecords 接口|
|7|fieldupdate_data.sh|包含 FieldUpdateRecord 接口|
|8|fieldinc_data.sh|包含 FieldIncRecord 接口|
|9|get_count.sh|包含 GetRecordCount 接口|
|10|traverse.sh|包含 Traverse 接口|
|11|index_query.sh|包含 IndexQuery 接口|

#### List 表示例脚本

| 序号 | 脚本名              | 脚本说明                                                                                   |
| ---- | ------------------- | ------------------------------------------------------------------------------------------ |
| 1    | list_insert_data.sh | 包含单笔 ListInsertRecord 和批量 ListBatchInsertRecords 插入接口                           |
| 2    | list_get_data.sh    | 包含单笔 ListGetRecord 和批量 ListBatchGetRecords、ListGetAllRecords 接口                  |
| 3    | list_update_data.sh | 包含单笔 ListUpdateRecord 和批量 ListBatchUpdateRecords                                    |
| 4    | list_delete_data.sh | 包含单笔删除 ListDeleteRecord 和批量删除 ListBatchDeleteRecords、ListDeleteAllRecords 接口 |
| 5    | list_traverse.sh    | 包含 ListTraverse 遍历接口                                                                 |

具体示例代码参考上述脚本即可，用通用的`curl`方式发起请求.

## 接口响应处理

RESTful API 响应以 JSON 类型返回，处理主要涉及几方面：

- **错误码处理**: 用户解析响应包的 ErrorCode, ErrorMsg, 如果 ErrorCode 为非零值，需要处理相应错误码，根据业务逻辑进行重试或放弃处理
- **响应体处理**: 不同接口的响应体处理不同，对于单笔接口，根据`result_flag`设置的类型返回操作前或操作后的数据，对于批量接口，涉及部分成功部分失败，需要处理对应的`SucceedRecords`, `SucceedNum`,`FailedRecords`,`FailedNum`。来获取成功或失败的记录或条数。
- **ReturnValues 处理**: 此参数主要是用户缓存，用于存放一些类似全局对象，通过此参数实例请求与响应的一一映射，避免将此对象保存在内存中

## 接口使用场景

### 基本增删查改场景

- **单笔操作场景**: 用户可用`InsertReocrd, GetRecord, UpdateRecord, ReplaceRecord, DeleteRecord`此类单笔接口。
- **批量操作场景**: 此类接口可用于提高数据操作效率及性能，如`BatchInsertRecords, BatchGetRecords, BatchUpdateRecords, BatchReplaceRecords,BatchDeleteRecord`。批量接口需要注意此类接口非原子事务，接口本身允许**部分记录操作成功,部分记录操作失败**, 需要判断响应包中的成功或失败的记录来尝试进一步的操作
- **主键索引场景**: 主键索引主要基于 TcaplusDB 主键字段设置的主键索引，如 3 个联合主键字段，把其中 1 个或 2 个字段设置为主键索引字段，可用`GetRecordByPartkey, DeleteRecordByPartkey`接口来满足场景操作，

### 其它常用场景

- **部分字段场景**: 此类接口用于获取记录部分字段或更新表部分字段或自增数值类型字段，通过此接口可大幅降低返回的包大小，提高传输效率和性能，可用`FieldGetRecord, BatchFieldGetRecord, FieldUpdateRecord, FieldIncRecord`接口。自增数值字段接口常用于如玩家经验等级更新，经验值更新场景。
- **遍历场景**: 此场景主要是遍历整表数据场景，结合 Limit 和返回的 complete 参数来控制包的大小和判断遍历是否可以结束，可用`Traverse`接口。常用于启服时加载玩家整表数据，
- **获取表记录条数场景**: 此场景可获取整个表的记录数, 　可用`GetRecordCount`接口.
- **二级索引查询场景**: 根据控制台增加的表二级索引字段进行数据查询，主要是用`select`类型的 SQL 语句来满足查询场景，支持模糊匹配、范围查找、简单聚合(sum,count,max,min)。支持的 SQL 语法参见附录`全局二级索引支持的 SQL 语法`说明。

# 附录

## 常见错误码

常见的错误码列表, 其它错误码用户可查看 Response 返回的 ErrMsg 属性看具体错误类型：

| 编号 | 错误码 | 描述                                                   |
| ---- | ------ | ------------------------------------------------------ |
| 1    | -1792  | 表处于只读模式，请检查 RCU,                            |
| 3    | 261    | 该记录不存在                                           |
| 4    | -525   | batchget 操作请求超时,                                 |
| 5    | -781   | batchget,                                              |
| 6    | -1037  | 系统繁忙，请联系管理员                                 |
| 7    | -1293  | 记录已存在，请不要重复插入                             |
| 8    | -1549  | 访问的表字段不存在                                     |
| 9    | -2061  | 表字段类型错误                                         |
| 10   | -3085  | SetFieldName 操作指定了错误的字段                      |
| 11   | -3341  | 字段值大小超过其定义类型的限制                         |
| 12   | -4109  | list 数据类型元素下标超过范围                          |
| 14   | -4621  | 请求缺少主键字段或索引字段                             |
| 15   | -6157  | list 表元素个数超过定义范围,请设置元素淘汰             |
| 16   | -6925  | result_flag 设置错误，请参考 SDK 中 result_flag 说明   |
| 17   | -7949  | 请检查乐观锁，请求记录版本号与实际记录版本号不一致     |
| 18   | -11277 | 操作表的方法不存在                                     |
| 19   | -16141 | PB 表 GetRecord 操作失败，请联系管理员                 |
| 20   | -16397 | PB 表非主键字段值超过限定大小(256KB)                   |
| 21   | -16653 | PB 表 FieldSetRecord 操作失败，请联系管理员            |
| 22   | -16909 | PB 表 FieldIncRecord 操作失败，请联系管理员            |
| 23   | -275   | 主键字段个数超过限制，Generic 表限制数为 4,            |
| 24   | -531   | 非主键字段个数超过限制，Generic 表限制数为 128,        |
| 25   | -787   | 字段名称大小超过限制（32B）                            |
| 26   | -1043  | 字段值指超过限制（256KB）                              |
| 27   | -1555  | 字段值的数据类型与其定义类型不匹配                     |
| 28   | -5395  | 请求中缺少主键                                         |
| 29   | -9235  | index 不存在                                           |
| 30   | -12307 | 请求发送失败，网络过载，请联系管理员。                 |
| 31   | -12819 | 表不存在                                               |
| 32   | -13843 | 后台网络异常，请求无法发送成功，如持续存在请联系管理员 |
| 33   | -14099 | 插入的记录超过大小限制（1MB）                          |
| 34   | －6673 | 请求参数无主键                                         |
| 35   | －6929 | 请求参数缺少主键字段                                   |
| 36   | -4877  | 需要签名                                               |
| 37   | -4365  | 超出最大 field 数                                      |
| 38   | -34565 | 索引不存在                                             |
| 39   | -3597  | 非法操作                                               |
| 40   | -1805  | 超出最大行数                                           |
| 41   | -2067  | 操作类型不匹配                                         |
| 42   | -11539 | 非法请求, 详细原因请参考返回信息字段                   |
| 43   | -279   | 鉴权错误                                               |
| 44   | -2579  | 数据反序列化错误                                       |
| 45   | -1811  | 非法参数                                               |
| 46   | -2323  | 数据序列化错误                                         |

## 全局二级索引支持的 SQL 语法

主要介绍二级索引查询所支持的 SQL 语法,　注意前提：**在云控制台已经针对表添加了全局二级索引**,　如若未添加是无法使用此接口的。

### 条件查询

支持 =, >, >=, <, <=, !=, between, in, not in, like, not like, and, or , 比如:

```
select * from table where a > 100 and b < 1000;

select * from table where a between 1 and 100 and b < 1000;

select * from table where str like "test";

select * from table where a > 100 or b < 1000;
```

注意：between 查询时，between a and b，对应的查询范围为[a, b]，比如 between 1 and 100, 是会包含 1 和 100 这两个值的，即查询范围为[1,100]

注意：like 查询是支持模糊匹配，其中"%"通配符，匹配 0 个或者多个字符； “\_”通配符，匹配 1 个字符；
分页查询

### 分页查询

支持 limit offset 分页查询。
比如：

```
select * from table whre a > 100 limit 100 offset 0;
```

注意：当前 limit 必须与 offset 搭配使用，即不支持 limit 1 或者 limit 0,1 这种。

### 聚合查询

当前支持的聚合查询包括：sum, count, max, min, avg，比如：

```
select sum(a), count(*), max(a), min(a), avg(a) from table where a > 1000;
```

注意：聚合查询不支持 limit offset，即 limit offset 不生效；

注意：目前只有 count 支持 distinct，即 select count(distinct(a)) from table where a > 1000; 其他情况均不支持 distinct
部分字段查询

### 支持查询部分字段的值

```
select a, b from table where a > 1000;
```

对于 pb 表，还支持查询嵌套字段的值，用点分方式，类似：

```
select field1.field2.field3, a, b from table where a > 1000;
```

### 不支持的 sql 查询语句

#### 不支持聚合查询与非聚合查询混用

```
select *, a, b from table where a > 1000;

select sum(a), a, b from table where a  > 1000;

select count(*), * from table where a  > 1000;
```

#### 不支持 order by 查询

```
select * from table where a > 1000 order by a;
```

#### 不支持 group by 查询

```
select * from table where a > 1000 group by a;
```

#### 不支持 having 查询

```
select sum(a) from table where  a > 1000 group by a having sum(a) > 10000;
```

#### 不支持多表联合查询

```
select * from table1 where table1.a > 1000 and table1.a = table2.b;
```

#### 不支持嵌套 select 查询

```
select * from table where a > 1000 and b in (select b from table where b < 5000);
```

#### 不支持别名

```
select sum(a) as sum_a from table where a > 1000;
```

#### 不支持的其他查询

- 不支持 join 查询；
- 不支持 union 查询；
- 不支持类似 select a+b from table where a > 1000 的查询；
- 不支持类似 select \* from table where a+b > 1000 的查询；
- 不支持类似 select \* from table where a >= b 的查询；
- 不支持其他未提到的查询。
