# docker-yapi
## 变量
| 变量           | 默认值          | 备注                                        |
| -------------- | --------------- | ------------------------------------------- |
| DB_HOST        | 127.0.0.1       | 数据库主机地址                              |
| DB_PORT        | 27017           | 数据库端口                                  |
| DB_NAME        | yapi            | 数据库名称                                  |
| DB_USER        |                 | 数据库用户名，根据MongoDB实际配置填写       |
| DB_PASSWORD    |                 | 数据库密码，根据MongoDB实际配置填写         |
| YAPI_PORT      | 3000            | YApi Web端口                                |
| YAPI_ACCOUNT   | admin@admin.com | 初始化管理员账户                            |

## 使用
### docker-compose启动（推荐）

##### 拉取文件
```bash
git clone git@github.com:buall/docker-yapi.git ~/yapi && cd ~/yapi
```
在启动之前根据实际配置，修改`docker-compose.yml`中的相关配置；若无特殊设置，直接执行下面的启动命令即可。
##### 启动
```bash
docker-compose up -d
```
### docker启动
docker启动之前需要配置好MongoDB相关信息，并根据实际情况修改相应的配置。
```bash
docker run -d --name yapi -e DB_HOST=10.0.0.1 -e DB_PORT=27017 -e DB_NAME=yapi -e DB_USER="" -e DB_PASSWORD="" -e YAPI_PORT="3000"-p 3000:3000 registry-vpc.cn-shenzhen.aliyuncs.com/maimages/yapi
```
正常启动之后，在浏览器打开`http://10.0.0.1:3000`，使用初始化管理员账户（默认：`admin@admin.com`）和默认密码`ymfe.org`。若无法打开页面或无法登录，查看日志`docker logs --tail=100 -f yapi` 进行排查。
