#

推送消息惹恼了我，我要把它干掉

##功能
拦截推送消息
过滤广告
对有用消息分
用户角色、情景设置
根据设置对消息放行或者read later
对信息的有用程度进行分类、排序

##UI设置
角色类型，定义需要的时间，可自定义
需要，定义需要过滤信息的程度
自定义需要安静的时间
定义如何处理过滤掉的信息

##推送消息
界面结构做的差不多，准备做server，后面在美化。
当我了解IOS的推送消息的时候，觉得悲剧了，Apple跟没给我这个机会，不能做一个常驻后台去管理推送消息，即使可以，不无法截获APNs,即使这一切在越狱的情况下做到了，也不能上架

IOS只能通过ANPs,不想Android上面那样五花八门的，既然是做消息控制，就不能挑食。
IOS的推送虽然省电，但这样统一管理，确实有失轻重缓急，比如QQ消息延迟了很久，这个不应该与其它非IM消息一同对待

我要想办法的师如何接管APNs发到设备上的消息，ANPs晚了我没办法，但是已经收到的，应该区分对待。

参考了
[zhihu](http://www.zhihu.com/topic/19699063) [ifanr](http://www.ifanr.com/3979) [ifanr2](http://www.ifanr.com/3776) [ifanr2](http://www.ifanr.com/3371) [Apple](https://developer.apple.com/library/mac/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/ApplePushService.html)