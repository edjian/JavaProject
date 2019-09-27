import Layout from '@/page/index/'
export default [{
    path: '/wel',
    component: Layout,
    redirect: '/wel/index',
    children: [{
        path: 'index',
        name: '首页',
        component: () =>
            import ( /* webpackChunkName: "views" */ '@/page/wel')
    }]
}, {
    path: '/info',
    component: Layout,
    redirect: '/info/index',
    children: [{
        path: 'index',
        name: '个人信息',
        component: () =>
            import ( /* webpackChunkName: "page" */ '@/views/admin/user/info'),
    }]
}, {
  path: '/views/wxmp',
  component: Layout,
  children: [
    {
    path: 'wxmenu/detail',
    name: '微信自定义菜单',
    meta: {
      keepAlive: true
    },
    component: () =>
      import ( /* webpackChunkName: "views" */ '@/views/wxmp/wxmenu/detail')
    },
    {
      path: 'wxmaterial/index',
      name: '微信素材管理',
      meta: {
        keepAlive: true
      },
      component: () =>
        import ( /* webpackChunkName: "views" */ '@/views/wxmp/wxmaterial/index')
    },
    {
      path: 'wxuser/index',
      name: '微信公众号用户管理',
      meta: {
        keepAlive: true
      },
      component: () =>
        import ( /* webpackChunkName: "views" */ '@/views/wxmp/wxuser/index')
    },
    {
      path: 'wxautoreply/index',
      name: '微信自动回复',
      meta: {
        keepAlive: true
      },
      component: () =>
        import ( /* webpackChunkName: "views" */ '@/views/wxmp/wxautoreply/index')
    },
    {
      path: 'wxmsg/index',
      name: '用户消息',
      meta: {
        keepAlive: true
      },
      component: () =>
        import ( /* webpackChunkName: "views" */ '@/views/wxmp/wxmsg/index')
    },
    {
      path: 'wxdatacube/user-summary',
      name: '用户分析',
      meta: {
        keepAlive: true
      },
      component: () =>
        import ( /* webpackChunkName: "views" */ '@/views/wxmp/wxdatacube/user-summary')
    },
    {
      path: 'wxdatacube/interface-summary',
      name: '接口分析',
      meta: {
        keepAlive: true
      },
      component: () =>
        import ( /* webpackChunkName: "views" */ '@/views/wxmp/wxdatacube/interface-summary')
    },
    {
      path: 'wxmassmsg/index',
      name: '消息群发',
      meta: {
        keepAlive: true
      },
      component: () =>
        import ( /* webpackChunkName: "views" */ '@/views/wxmp/wxmassmsg/index')
    }
  ]
}, {
  path: '/views/wxma',
  component: Layout,
  children: [
    {
      path: 'wxuser/index',
      name: '微信小程序用户管理',
      meta: {
        keepAlive: true
      },
      component: () =>
        import ( /* webpackChunkName: "views" */ '@/views/wxma/wxuser/index')
    }]
}
]
