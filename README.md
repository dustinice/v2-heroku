[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://dashboard.heroku.com/new?template=https://github.com/dustinice/v2-heroku)

#### 部署服务端

点击上面紫色`Deploy to Heroku`，会跳转到heroku app创建页面，填上app的名字，然后换上从 https://www.uuidgenerator.net/ 拷贝过来的UUID，点击下面deploy创建APP，完成后会生成一个链接，点击链接显示“Bad Request”就说明部署成功了！

需要记下的是appname,和你填入的UUID，下面就可以设置客户端翻墙了。

#### 客户端设置

![443port](https://github.com/yeahwu/kinto/raw/master/img/kinto3.jpg)

上图是443端口设置方法，当然你也可以设置80端口，不要打开tls就可以了，如下：

```
地址(address) : appname.herokuapp.com	//appname替换成你的app名字

端口(port) : 80

用户ID(uuid) : 这里填写刚申请的UUID

加密方式(security) : aes-128-gcm

传输协议(network) : ws
```

本地客户端config.json文件配置：
```
{
  "inbounds": [
    {
      "port": 1080,
      "listen": "127.0.0.1",
      "protocol": "socks",
      "sniffing": {
        "enabled": true,
        "destOverride": ["http", "tls"]
      },
      "settings": {
        "auth": "noauth",
        "udp": false
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "vmess",
      "settings": {
        "vnext": [
          {
            "address": "appname.herokuapp.com",  //域名
            "port": 443,
            "users": [
              {
                "id": "b831381d-6324-4d53-ad4f-8cda48b30811"
              }
            ]
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls",
        "wsSettings": {}
      }
    }
  ]
}
```
捐赠本博：https://yeahwu.com/donation.html
