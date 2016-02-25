# V2EX API Documents

## Site

### site/stats.json

URL: [http://www.v2ex.com/api/site/stats.json](http://www.v2ex.com/api/site/stats.json)

获取社区统计信息。

#### 参数

None

#### 返回值

* topic_max - 当前社区话题数量
* member_max - 当前社区用户数量

### site/info.json

URL: [http://www.v2ex.com/api/site/info.json](http://www.v2ex.com/api/site/info.json)

获取社区介绍。

#### 参数

None

#### 返回值

* title - 当前社区站名
* slogan - 当前社区口号
* description - 当前社区描述
* domain - 社区网址

## Node

### nodes/all.json

URL: [http://www.v2ex.com/api/nodes/all.json](http://www.v2ex.com/api/nodes/all.json)

获取全部节点

#### 参数

None

#### 返回值

* id - 节点 ID
* name - 节点缩略名
* url - 节点地址
* title - 节点名称
* title_alternative - 备选节点名称
* topics - 节点主题总数
* header - 节点头部信息
* footer - 节点脚部信息
* created - 节点创建时间

### nodes/show.json

URL: [http://www.v2ex.com/api/nodes/show.json](http://www.v2ex.com/api/nodes/show.json)

获取单个节点信息

#### 参数

* id - 节点 id
* name - 节点缩略名

（以上参数任选其一）

#### 返回值
* id - 节点 ID
* name - 节点缩略名
* url - 节点地址
* title - 节点名称
* title_alternative - 备选节点名称
* topics - 节点主题总数
* header - 节点头部信息
* footer - 节点脚部信息
* created - 节点创建时间

## Topic

### topics/latest.json

URL: [http://www.v2ex.com/api/topics/latest.json](http://www.v2ex.com/api/topics/latest.json)

#### 参数

None

#### 返回值

* id - Topic ID
* title - Topic 标题
* content - Topic 内容
* content_rendered - 渲染过的 Topic 内容（比如 gist, Youtube 等）
* replies - 回复数量

### topics/show.json

URL: [http://www.v2ex.com/api/topics/show.json](http://www.v2ex.com/api/topics/show.json)

#### 参数

* id - Topic ID

#### 返回值

* id - Topic ID
* title - Topic 标题
* content - Topic 内容
* content_rendered - 渲染过的 Topic 内容（比如 gist, Youtube 等）
* replies - 回复数量

### replies/show.json

URL: [http://www.v2ex.com/api/replies/show.json](http://www.v2ex.com/api/replies/show.json)

#### 参数

* topic_id - Topic ID

#### 返回值

* id - Reply ID
* content - Reply 内容
* content_rendered - 渲染过的 Reply 内容（比如 gist, Youtube 等）
* thank - 感谢数量

## Member

### member/show.json

URL: [http://www.v2ex.com/api/members/show.json](http://www.v2ex.com/api/members/show.json)

#### 参数

* id - Member ID
* username - Member name

(以上参数任选其一)

#### 返回值

* status
* id
* url
* username
* website
* twitter
* location
* tagline
* bio
