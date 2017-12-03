from django.conf.urls import url

from . import views

urlpatterns = [     
#======shop

    #前台商品列表页
    url(r'^shop/list/', views.list, name='myweb_shoplist'), 
    #前台网站首页
    url(r'^shop/index/', views.index, name='myweb_shopindex'),
    #前台商品详情页
    url(r'^shop/details(?P<gid>[0-9]+)/', views.details, name='myweb_shopdetails'), 

#=======注册

    #前台注册页
    url(r'^register/', views.register, name='myweb_register'),
    #执行注册操作
    url(r'^doregister/', views.doregister, name='myweb_doregister'),

#=======登录退出
    
    #前台登录页
    url(r'^login/', views.login, name='myweb_login'), 
    #执行登录操作
    url(r'^dologin/', views.dologin, name='myweb_dologin'),
    #执行退出操作
    url(r'^outlogin/', views.outlogin, name='myweb_outlogin'), 

#=======个人中心

    #个人中心页
    url(r'^person/', views.person, name='myweb_person'),  
    #修改个人中心页
    url(r'^edit/', views.edit, name='myweb_edit'),  
    #执行修改个人中心
    url(r'^update(?P<pid>[0-9]+)/', views.update, name='myweb_update'),

#======前台购物车
    #执行购买操作
    url(r'^detail_update(?P<bid>[0-9]+)/', views.detail_update, name='detail_update'),
    #前台购物车页
    url(r'^cart/', views.cart, name='myweb_cart'),
    #执行删除购物车商品
    url(r'^cart_del(?P<bid>[0-9]+)/', views.cart_del, name='cart_del'),
    #执行清空购物车
    url(r'^cart_clear/', views.cart_clear, name='cart_clear'),
    #购物车数量加减
    url(r'^cart_change/', views.cart_change, name='cart_change'),

#======前台订单页
    #购物车执行提交
    url(r'^order_buy/', views.order_buy, name='order_buy'),
    #订单信息页
    url(r'^order_form/', views.order_form, name='order_form'),
    #订单确认页
    url(r'^order_affirm/', views.order_affirm, name='order_affirm'),
    #订单确认执行页
    url(r'^order_carry(?P<cid>[0-9]+)/', views.order_carry, name='order_carry'),
    #订单页
    url(r'^order/', views.order, name='myweb_order'),
    #订单详情页
    url(r'^order_detail/', views.order_detail, name='order_detail'),
    #待发货订单页
    url(r'^order_wait/', views.order_wait, name='order_wait'),
    #订单信息取消
    url(r'^orders/edit/',views.order_edit,name='order_edit'),
]