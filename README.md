## 短连接服务
### 目录
  - [注解](#注解)
  - [短链接](#短链接)
    * [创建](#创建)
    * [更新](#更新)
    * [查看短链接现相关信息](#查看短链接现相关信息)
    * [删除](#删除)

### 注解
#### 授权
2种方式（选1），一个ApiApplication对一个private_token
- 传private_token参数，例：`/api/v1/short_urls?private_token=QVy1PB7sTxfy4pqfZM1U`
- 指定PRIVATE-TOKEN header，例：`curl --header "PRIVATE-TOKEN: QVy1PB7sTxfy4pqfZM1U" "http://domain/api/v1/short_urls"`

#### 错误码

| Error Code | Meaning |
| :-------- | :--------|
| 401 | Unauthorized - 授权失败，参考上方的2种授权方式 |
| 404 | Not Found - 没有找到请求的资源 |
| 422 | Unprocessable - 更新资源时，验证失败 |
| 500 | Internal Server Error - 服务器有问题，请联系我们 |


#### 其他
- 所有的api，请带上版本号`/api/v1`，例：`/api/v1/short_urls`

### 短连接
#### 创建
`POST /short_urls`

**Parameters**

| Name | Type | Description |
| :-------- | --------:| :------: |
| destination | string | `Required`. 目标URL, 带上协议`http://`或`https://` |
| custom_key | string | 自定义短连接，当此值设置时，length和char_set不会生效 |
| length | integer | 系统生成短连接的长度，默认8，范围：5~20，超出范围系统默认使用8 |
| char_set | Array | 系统生成短连接的字符集，可选值："A-Z", "a-z", "0-9", "-", "_" |

**Response**
`Status: 201 Created`
```json
  {
    "id": 12,
    "destination": "https://www.baidu.com",
    "travel_count": 0,
    "key": "aaaaaaa",
    "short_url": "http://localhost:3000/m/aaaaaaa",
    "length": null,
    "char_set": null,
    "custom_key": "aaaaaaa"
  }
```

#### 更新
`PATCH /short_urls/:key`
> 更新destination不会去更新key，其他更新时会改变key

**Parameters**

| Name | Type | Description |
| :-------- | --------:| :------: |
| destination | string | `Required`. 目标URL, 带上协议`http://`或`https://` |
| custom_key | string | 自定义短连接，当此值设置时，length和char_set不会生效 |
| length | integer | 系统生成短连接的长度，默认8，范围：5~20，超出范围系统默认使用8 |
| char_set | Array | 系统生成短连接的字符集，可选值："A-Z", "a-z", "0-9", "-", "_" |

**Response**
`Status: 200 OK`
```json
  {
    "id": 12,
    "destination": "https://www.baidu.com",
    "travel_count": 0,
    "key": "IM3Gl6kVZh",
    "short_url": "http://localhost:3000/m/IM3Gl6kVZh",
    "length": "10",
    "char_set": null,
    "custom_key": ""
  }
```

#### 查看短链接现相关信息
`GET /short_urls/:key`

**Parameters**
 `无`

**Response**
`Status: 200 OK`
```json
  {
    "id": 12,
    "destination": "https://www.baidu.com",
    "travel_count": 0,
    "key": "IM3Gl6kVZh",
    "short_url": "http://localhost:3000/m/IM3Gl6kVZh",
    "length": "10",
    "char_set": null,
    "custom_key": ""
  }
```

#### 删除
`DESTROY /short_urls/:key`

**Parameters**
 `无`

**Response**
`Status: 204 No Content`
