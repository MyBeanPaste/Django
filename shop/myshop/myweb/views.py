from django.shortcuts import render
from django.http import HttpResponse,JsonResponse
from django.shortcuts import redirect
from django.core.urlresolvers import reverse
import random
import hashlib
import io
import time,json

from myweb.models import Types, Goods, Users, Orders, Detail


#========公共信息加载函数=======
def loadinfo(request):
    context={}
    context['typelist'] = Types.objects.filter(pid=0)
    return context

#========shop==========

#前台首页
def index(request):
    context={}
    context['typelist'] = Types.objects.filter(pid=0)
    #获取最新五个商品
    context['indexlist'] = Goods.objects.order_by('-id')[:5]
    #获取点击量最高的五个商品
    context['indexlist1'] = Goods.objects.order_by('-clicknum')[:5]
    #获取价格最便宜的商品
    context['indexlist2'] = Goods.objects.order_by('price')[:5]

    return render(request, "myweb/shop/index.html", context)

#前台商品列表页
def list(request):
    context = loadinfo(request)
    list = Goods.objects.filter()
    if request.GET.get('tid', '') != '':
        tid = str(request.GET.get('tid', ''))
        list = list.filter(typeid__in=Types.objects.only('id').filter(path__contains=','+tid+','))
    context['goodslist'] = list
    return render(request, "myweb/shop/list.html", context)

#前台商品详情页
def details(request, gid):
    context = loadinfo(request)
    ob = Goods.objects.get(id=gid)
    ob.clicknum += 1
    ob.save()
    context['goods'] = ob
    return render(request, "myweb/shop/details.html", context)

#==========前台注册======

#前台注册页
def register(request):
    return render(request, "myweb/register.html")

#执行注册操作
def doregister(request):
    # try:
    users = Users.objects.all()
    if users.filter(phone=request.POST['phone']):
        context = {'info': '该手机号已注册！'}
    else:
        ob = Users()
        ob.username = request.POST['username']
        ob.name = request.POST['name']
        if request.POST['password'] == request.POST['repassword']:
            # 获取密码并md5
            import hashlib
            m = hashlib.md5()
            m.update(bytes(request.POST['password'], encoding="utf8"))
            ob.password = m.hexdigest()
            ob.phone = request.POST['phone']
            ob.email = request.POST['email']
            ob.state = 1
            ob.addtime = time.time()
            ob.save()
            return redirect(reverse('myweb_login'))
        else:
            context = {'info':'重复密码错误!'}
    # except:
    #     context = {'info': '添加失败！'}
    return render(request, "myweb/register.html", context)

#==========前台登录退出页=========

#前台登陆页
def login(request):
    return render(request, "myweb/login.html")


#执行登陆操作
def dologin(request):
    try:
        user = Users.objects.get(phone=request.POST['phone'])
        # 根据账号获取登陆着信息
        m = hashlib.md5()
        m.update(bytes(request.POST['password'], encoding="utf-8"))
        if user.password == m.hexdigest():
            # 若此处登陆成功，将 当前登陆信息放到session中，并跳转页面
            request.session['webuser'] = user.name
            request.session['webid'] = user.id
            request.session['webcode'] = user.code
            request.session['webaddress'] = user.address
            request.session['webphone'] = user.phone
            return redirect(reverse('myweb_shopindex'))
        else:
            context = {'info': '密码错误！'}
            return render(request, "myweb/login.html", context)

    except:
        context = {'info': '账号不存在！'}
        return render(request, "myweb/login.html", context)

#前台退出页
def outlogin(request):
    del request.session['webuser']
    del request.session['webid']
    del request.session['webcode'] 
    del request.session['webaddress']
    del request.session['webphone'] 
    return redirect(reverse('myweb_shopindex'))

#=========前台个人中心页========

#前台个人中心页
def person (request):
    context = {}
    user = Users.objects.get(id=request.session['webid'])
    status = Orders.objects.filter(uid=request.session['webid']).filter(status=0)
    list = len(status)
    context['person']= user
    context['statuslist']= list
    return render(request, "myweb/person/person.html", context)


#修改个人中心表单
def edit(request):
    user = Users.objects.get(id=request.session['webid'])
    context = {'person': user}
    return render(request, "myweb/person/edit.html",context)


#执行修改个人信息
def update(request,pid):
    try:
        ob = Users.objects.get(id=pid)
        ob.name = request.POST['name']
        ob.sex = request.POST['sex']
        ob.address = request.POST['address']
        ob.code = request.POST['code']
        ob.phone = request.POST['phone']
        ob.email = request.POST['email']
        ob.save()
        del request.session['webuser']
        request.session['webuser'] = ob.name 
    except:
        context = {'info': '修改失败！'}
        return render(request, "myweb/update.html", context)
    return redirect(reverse('myweb_person'))

#=======前台购物车

#执行购买操作
def detail_update(request,bid):
    goods = Goods.objects.get(id=bid)
    shop = goods.buy()
    shop['num'] = int(request.POST['num'])

    #获取购物车中的信息
    if 'shoplist' in request.session:
        shoplist = request.session['shoplist']
    else:
        shoplist = {}
    #判断并放置session中
    if bid in shoplist:
        shoplist[bid]['num'] += shop['num']
    else:
        shoplist[bid] = shop
    #将购物车信息shoplist放入到session中
    request.session['shoplist'] = shoplist
    return redirect(reverse('myweb_cart'))
    
#购物车页
def cart(request):
    context = loadinfo(request)
    return render(request,'myweb/cart/cart.html',context)

#执行购物车删除
def cart_del(request,bid):
    shoplist = request.session['shoplist']
    del shoplist[bid]
    request.session['shoplist'] = shoplist
    return redirect(reverse('myweb_cart'))

#清空购物车
def cart_clear(request):
    if request.session.get('shoplist',None) != None:
        request.session['shoplist'] = {}
    return redirect(reverse('myweb_cart'))

#购物车数量的改变
def cart_change(request):
    shoplist = request.session['shoplist']
    #获取信息
    shopid = request.GET['sid']
    num = int(request.GET['num'])
    if num < 1:
        num = 1
    #更改商品数量
    shoplist[shopid]['num'] = num 
    request.session['shoplist'] = shoplist
    return redirect(reverse('myweb_cart'))
    
#=======前台订单

#购物车提交页
def order_buy(request):
    context = loadinfo(request)
    list1 = request.GET['gids']
    if list1 == '':
        context['info']='您还没有选择宝贝!'
        return render(request,'myweb/cart/cart.html',context)
    else:
        gids = list1.split(',')
        shoplist = request.session['shoplist']
        total = 0
        orderlist = {}
        for i in gids:
            orderlist[i]=shoplist[i]#获取商品信息
            total += shoplist[i]['price']*shoplist[i]['num'] #计算商品总价
        request.session['orderlist'] = orderlist
        request.session['total'] = total
        return render(request,'myweb/order/orderform.html',context)
#订单信息页
def order_form(request):
    context = loadinfo(request)
    return render(request,'myweb/order/orderform.html',context)
#订单确认页
def order_affirm(request):
    context = loadinfo(request)
    request.session['webuser1'] = request.POST['name']
    request.session['webaddress1'] = request.POST['address']
    request.session['webcode1'] = request.POST['code']
    request.session['webphone1'] = request.POST['phone']
    return render(request,'myweb/order/orderaffirm.html',context)
#订单确认执行页
def order_carry(request,cid):
    #订单数据库存储
    user = Users.objects.get(id=cid)
    order = Orders()
    order.uid = user.id
    order.linkman = request.POST['name']
    order.address = request.POST['address']
    order.code = request.POST['code']
    order.phone = request.POST['phone']
    order.addtime = time.time()
    order.total = request.session['total']
    order.status = 0
    order.save()
    #订单详情数据库存储
    orderlist = request.session['orderlist']
    shoplist = request.session['shoplist']
    for shop in orderlist.values(): 
        del shoplist[str(shop['id'])]
        detail = Detail()
        detail.orderid = order.id
        detail.goodsid = shop['id']
        detail.name = shop['goods']
        detail.price = shop['price']
        detail.num = shop['num']
        detail.save()
    #删除购物车中已经购买的商品
    del request.session['orderlist'] 
    del request.session['total']
    request.session['shoplist'] = shoplist
    return redirect(reverse('myweb_order'))

#订单页
def order(request):

    orderlist = Orders.objects.filter(uid = request.session['webid'])
    context = {}
    context['orderlist'] = orderlist
    return render(request,'myweb/order/order.html',context)

#订单详情页
def order_detail(request):
    did = Detail.objects.filter(orderid=request.GET['did'])
    for ob in did:
        dt = Goods.objects.get(id = ob.goodsid)
        ob.picname = dt.picname
    context = {'detaillist':did}
    return render(request,'myweb/order/orderdetail.html',context)

#待发货订单页
def order_wait(request):
    wait = Orders.objects.filter(uid=request.session['webid']).filter(status=0)
    context = {'waitlist':wait}
    return render(request,'myweb/order/orderwait.html',context)

#取消订单编辑
def order_edit(request):
    orders = Orders.objects.get(id=request.GET['pid'])
    orders.status = 3
    orders.save()
    return redirect(reverse('myweb_order'))






    
        
    