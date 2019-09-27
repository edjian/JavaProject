import Mock from 'mockjs';

// 素材内容
export var tableData = Mock.mock('/api/data',
  [{
    name: 'Vue',
  }, {
    name: 'angular',
  },{
    name: 'react',
  },
  ]
  );

// 配置菜单
export var menu = Mock.mock('/api/menu',
  {
  // 一级菜单
  button:[
    {
        "type": "miniprogram",
  "name": "指环商城",
  "url": "http://mp.weixin.qq.com/s?__biz=MzI5MTYwODIwMw==&mid=2247483713&idx=1&sn=0f45b743ffd1b087d9f19ea973a6aafc&chksm=ec0f42a5db78cbb3183699af19ca42b942b3ea0bc2969ac00df20142e24979bd89d67e026914&scene=18#wechat_redirect",
      "sub_button": [],
      "appid": "wx24f9070e64c4a8e4",
      "pagepath": "pages/index/index"
    },
    {
      "name": "下载APP",
      "sub_button": [
        {
          "type": "view",
          "name": "下载ios App",
          "url": "https://itunes.apple.com/us/app/twitter/id1124463975?mt=8",
          "sub_button": []
        },
        {
          "type": "view",
          "name": "下载安卓App",
          "url": "https://www.pgyer.com/czww",
          "sub_button": []
        },
        {
          "type": "view",
          "name": "ERP简介",
          "url": "http://mp.weixin.qq.com/s?__biz=MzI5MTYwODIwMw==mid=2247483865idx=1sn=9f3af4286e66e958ea5a6e2d6a14563cchksm=ec0f423ddb78cb2bc0f7fa3cca36adc35d0fef265b01b3a2bd35f906120306195d4f5e00e52bscene=18#wechat_redirect",
          "sub_button": []
        },
        {
          "type": "click",
          "name": "特色功能",
          "key": "V3",
          "sub_button": []
        }
      ]
    },
    {
      "name": "联系我们",
      "sub_button": [
        {
          "type": "click",
          "name": "售前咨询",
          "key": "V1",
          "sub_button": []
        },
        {
          "type": "click",
          "name": "售后维护",
          "key": "V2",
          "sub_button": []
        }
      ]
    }
  ]
}
);


