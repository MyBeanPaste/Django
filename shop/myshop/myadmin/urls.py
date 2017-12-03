
from django.conf.urls import url
from . import views,viewsgoods

urlpatterns = [
#=======================后台==========================
    #首页
    url(r'^index/',views.index,name='index'),
#========后台用户

    #浏览用户信息
    url(r'^users/index(?P<pIndex>[0-9]*)/',views.users_index,name='myadmin_uindex'),
    #添加用户信息
    url(r'^users/add/',views.users_add,name='myadmin_uadd'),
    #执行会员信息添加
    url(r'^users/insert/',views.users_insert,name='myadmin_uinsert'),
    #执行会员信息删除
    url(r'^users/(?P<uid>[0-9]+)/del/', views.users_del, name="myadmin_udel"),
    #会员信息编辑
    url(r'^users/(?P<uid>[0-9]+)/edit/', views.users_edit, name="myadmin_uedit"),
    #执行会员信息编辑
    url(r'^users/(?P<uid>[0-9]+)/update/', views.users_update, name="myadmin_uupdate"),
#=======会员登录

   	#会员登录
    url(r'^login/',views.login,name='myadmin_login'),
    #执行会员登录
    url(r'^dologin/',views.dologin,name='myadmin_dologin'),
    #会员退出
    url(r'^outlogin/',views.outlogin,name='myadmin_outlogin'),
    #会员登录验证
    url(r'^verifycode/',views.verifycode,name='myadmin_verifycode'),
#=======商品类型

    #商品类别浏览
    url(r'^type/(?P<pIndex>[0-9]*)/',viewsgoods.type_index,name='myadmin_typeindex'),
    #商品类别添加
    url(r'^types/(?P<tid>[0-9]+)/add/',viewsgoods.type_add,name='myadmin_typeadd'),
    #执行商品类别添加
    url(r'^types/insert/',viewsgoods.type_insert,name='myadmin_typeinsert'),
    #执行商品删除
    url(r'^types/(?P<tid>[0-9]+)/del/',viewsgoods.type_del,name='myadmin_typedel'),
    #商品信息编辑表单
    url(r'^types/(?P<tid>[0-9]+)/edit/',viewsgoods.type_edit,name='myadmin_typeedit'),
    #执行商品信息编辑
    url(r'^types/(?P<tid>[0-9]+)/update/',viewsgoods.type_update,name='myadmin_typeupdate'),

#=======商品信息管理

    #商品信息浏览
    url(r'^goods/index(?P<pIndex>[0-9]*)/',viewsgoods.goods_index,name='myadmin_goodindex'),
    #商品信息添加
    url(r'^goods/add/',viewsgoods.goods_add,name='myadmin_goodadd'),
    #执行商品信息添加
    url(r'^goods/insert/',viewsgoods.goods_insert,name='myadmin_goodinsert'),
    #商品信息删除
    url(r'^goods/(?P<gid>[0-9]+)/del/',viewsgoods.goods_del,name='myadmin_gooddel'),
    #商品信息编辑表单
    url(r'^goods/(?P<gid>[0-9]+)/edit/',viewsgoods.goods_edit,name='myadmin_goodedit'),
    #执行编辑商品信息
    url(r'^goods/(?P<gid>[0-9]+)/update/',viewsgoods.goods_update,name='myadmin_goodupdate'),

#======订单信息管理
    #订单信息浏览
    url(r'^orders/index(?P<pIndex>[0-9]*)/',viewsgoods.orders_index,name='myadmin_ordersindex'),
    #订单信息编辑
    url(r'^orders/edit(?P<rid>[0-9]*)/',viewsgoods.orders_edit,name='myadmin_ordersedit'),
    #执行订单信息编辑
    url(r'^orders/update(?P<rid>[0-9]*)/',viewsgoods.orders_update,name='myadmin_ordersupdate'),
    #订单详情页
    url(r'^orders/detail(?P<rid>[0-9]*)/',viewsgoods.orders_detail,name='myadmin_ordersdetail'),

]

