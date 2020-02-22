### 注意🈲
1. 本软件为 www.joolun.com 开发研制，未经购买不得使用
1. 购买后可获得全部源代码（禁止转卖、分享、上传到码云、github等开源平台）
1. 一经发现盗用、分享等行为，将追究法律责任，后果自负
2. 有问题可以发git工单解决，**拒绝淘宝差评**，否则直接删除git账号

### 重要信息
1. ⚡技术问题和bug，请提交 【[工单](http://git.joolun.com/joolun-mp-ma/mp-ma/issues)】；如问题解决请自行关闭工单，问题请带截图和操作步骤，问题没描述清楚的不处理
1. 前期项目部署时遇到问题可以联系技术人员QQ帮忙解决；其他非部署问题请直接发【[工单](http://git.joolun.com/joolun-mp-ma/mp-ma/issues)】，QQ只处理部署方面的问题
2. 版本升级时要重新导入新的脚本，并清理redis缓存
3. 代码请拉master分支，其他分支不要管
3. 🔊请按照自己业务需求进行测试后再使用，因框架问题造成的任何损失JooLun概不负责
### 请严格按照教程操作；不要自己改库名、改包名，教程上没有说的就不要动，这样出了问题我们才好给你排查，等你熟悉项目了再改也不迟；因自己改了教程之外的东西出了问题来咨询技术的，我们都不受理，还会被叼一顿😒
### 文档教程
* [开发环境部署教程](https://git.joolun.com/joolun-mp-ma/mp-ma/wiki/%E4%B8%80-%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83%E9%83%A8%E7%BD%B2%E6%95%99%E7%A8%8B)
* [生产环境部署教程（centos7）](https://git.joolun.com/joolun-mp-ma/mp-ma/wiki/%E4%B8%80-%E7%94%9F%E4%BA%A7%E7%8E%AF%E5%A2%83%E9%83%A8%E7%BD%B2%EF%BC%88centos7%EF%BC%89)
* [所有教程文档](http://git.joolun.com/joolun-mp-ma/mp-ma/wiki/_pages)

### 版本升级说明
##### 每次版本升级都会有业务或逻辑上的变化，请仔细阅读[升级日志](https://git.joolun.com/joolun-mp-ma/mp-ma/releases)后再决定是否升级
##### 拉取完新版本代码后，数据库有两种方式升级；无特殊情况建议使用第一种全量导入
##### 第一种：重新全量导入
* 重新导入joolun/db下的4个全量脚本，无需理会升级脚本
* 升级完要清redis缓存再重启服务
##### 第二种：执行升级脚本
* JooLun在每次上新版本的时候都会提供sql升级脚本（joolun/db/升级脚本/xxx升级xxx.sql）
* 必须对应自己当前的版本号执行（项目pom.xml文件查看版本号）
* 升级脚本不包含base_config库，base_config请自行全量导入
* 升级完要清redis缓存再重启服务

### 常见问题
* [必看的常见问题](https://git.joolun.com/joolun-mp-ma/mp-ma/issues?q=&type=all&sort=&state=closed&labels=6&milestone=0&assignee=0)

### 使用案例，登记返现10块💰
* [在此登记](http://git.joolun.com/joolun-mp-ma/mp-ma/issues/48)，只要你的小程序在JooLun的基础上开发并且已经发布，都可以在此登记；截图联系客服QQ1023530620即可返现10块

### 软著（受法律保护）
* ![](https://joolun-blog.oss-cn-zhangjiakou.aliyuncs.com/%E8%BD%AF%E8%91%97.jpg)
### [阿里云领取￥2000红包](https://promotion.aliyun.com/ntms/yunparter/invite.html?userCode=ktp7i3ac)