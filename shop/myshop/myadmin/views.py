from django.shortcuts import render
from django.http import HttpResponse,JsonResponse
from django.shortcuts import redirect
from django.core.urlresolvers import reverse
from django.core.paginator import Paginator

from myadmin.models import Users,Types,Goods,Orders
import time,json


#========================后台==========================
#首页
def index(request):
	context = {}
	#获取会员所有信息
	list = Users.objects.all()
	list = len(list)

	#获取商品父种类所有信息
	list1 = Types.objects.filter(pid=0)
	list1 = len(list1)

	#获取商品数量
	list2 = Goods.objects.all()
	list2 = len(list2)

	#获取订单数
	list3 = Orders.objects.all()
	list3 = len(list3)
	#获取当前用户登录信息
	user = Users.objects.get(id = request.session['adminid'])
	
	context['indexlist']=user
	context['orderslist']=list3
	context['goodslist']=list2
	context['typeslist']=list1
	context['userslist']=list
	return render(request,'myadmin/index.html',context)

#浏览用户
def users_index(request,pIndex=1):
	list = Users.objects.all()
	# context = {'userslist':list}

	#判断并封装搜索学生信息
	where = [] 
	if request.GET.get('name','') != '':
		list = list.filter(name__contains=request.GET['name'])
		where.append('name='+request.GET['name'])
	#传入数据和页的大小来创建对象
	p = Paginator(list,5)
	#判断页号没有初始值时初始化1
	if pIndex == '':
		pIndex = '1'
	pIndex = int(pIndex) #类型转换int
	list2 = p.page(pIndex)#获取当前页数据
	plist = p.page_range#获取页码信息
	#封装分页信息
	context = {'userslist':list2,'plist':plist,'pIndex':pIndex,'where':where}
	return render(request,'myadmin/users/index.html',context)

#添加用户信息
def users_add(request):
	return render(request,'myadmin/users/add.html')
#执行会员信息添加
def users_insert(request):
	try:
		ob = Users()
		ob.username = request.POST['username']
		ob.name = request.POST['name']
		if request.POST['password'] == request.POST['repassword']:
			#获取密码并m5d
			import hashlib
			m = hashlib.md5()
			m.update(bytes(request.POST['password'],encoding='utf8'))
			ob.password = m.hexdigest()
			ob.sex = request.POST['sex']
			ob.address = request.POST['address']
			ob.code = request.POST['code']
			ob.phone = request.POST['phone']
			ob.email = request.POST['email']
			ob.state = 1
			ob.addtime = time.time()
			ob.save()
			context = {'info':'添加成功!'}
		else:
			return redirect(reverse('myadmin_uadd'))
	except:
		context = {'info':'添加失败'}
	return render(request,'myadmin/info.html',context)

#会员信息删除
def users_del(request,uid):
	try:
		ob = Users.objects.get(id=uid)
		ob.delete()
		context = {'info':'删除成功'}
	except:
		context = {'info':'删除失败'}
	return render(request,'myadmin/info.html',context)

#会员信息编辑
def users_edit(request,uid):
	try:
		ob=Users.objects.get(id=uid)
		context = {'user':ob}
		return render(request,'myadmin/users/edit.html',context)
	except:
		context ={'info':'没有找到要修改的信息'}
		return render(request,'myadmin/info.html',context)

#执行会员信息编辑
def users_update(request,uid):
	try:
		ob = Users.objects.get(id=uid)
		ob.name = request.POST['name']
		ob.sex = request.POST['sex']
		ob.address = request.POST['address']
		ob.code = request.POST['code']
		ob.phone = request.POST['phone']
		ob.email = request.POST['email']
		ob.state = request.POST['state']
		ob.save()
		context = {'info':'修改成功！'}
	except:
		context = {'info':'修改失败！'}
	return render(request,"myadmin/info.html",context)

#会员登录
def login(request):
	return render(request,'myadmin/login.html')

#执行会员登录
def dologin(request):
	#校验验证码
	verifycode = request.session['verifycode']
	code = request.POST['code']
	if verifycode != code:
		context = {'info':'验证码错误！'}
		return render(request,"myadmin/login.html",context)
	try:
		#根据账号获取登录者信息
		user = Users.objects.get(username=request.POST['username'])
		#判断当前用户是否是后台管理员用户
		if user.state == 0:
			# 验证密码
			import hashlib
			m = hashlib.md5() 
			m.update(bytes(request.POST['password'],encoding="utf8"))
			if user.password == m.hexdigest():
				# 此处登录成功，将当前登录信息放入到session中，并跳转页面
				request.session['adminuser'] = user.name
				request.session['adminid'] = user.id
				#print(json.dumps(user))
				return redirect(reverse('index'))
				# return render(request,'myadmin/users/index.html')
			else:
				context = {'info':'登录密码错误！'}
		else:
			context = {'info':'此用户非后台管理用户！'}
	except:
		context = {'info':'登录账号错误！'}
	return render(request,"myadmin/login.html",context)


#会员退出
def outlogin(request):
	del request.session['adminuser']
	return redirect(reverse('myadmin_login'))

#会员登录验证
def verifycode(request):
	#引入绘图模块
	from PIL import Image, ImageDraw, ImageFont
	#引入随机模块
	import random
	#定义变量,用于画布的背景色,宽,高
	#bgcolor = (random.randrange(20,100),random.randrange(20,100),255)
	bgcolor = (150,154,194)
	width = 100
	height = 25
	#创建画面对象
	im = Image.new('RGB',(width,height),bgcolor)
	#创建画笔对象
	draw = ImageDraw.Draw(im)
	#调用画笔的point()函数绘制噪点

	for i in range(0, 100):
		xy = (random.randrange(0,width),random.randrange(0,height))
		fill = (random.randrange(0,255),255,random.randrange(0,255))
		draw.point(xy,fill=fill)
	#定义验证码的备选值
	#str1 = 'ABCD123EFGHIJK456LMNOPQRS789TUVWXYZ0'
	str1 = '0123456789'
	#随机选取4个值作为验证码
	rand_str = ''
	for i in range(0, 4):
		rand_str += str1[random.randrange(0, len(str1))]

	#构造字体对象
	font = ImageFont.truetype('static/myadmin/font/STXIHEI.TTF', 23)
	#font = ImageFont.load_default().font
	for i in range(0, 4):
		#构造字体颜色
		fontcolor = (random.randrange(0, 255), random.randrange(0, 255), random.randrange(0, 255))
		#绘制4个字
		draw.text((5+i*24, -4), rand_str[i], font=font, fill=fontcolor)
	#释放画笔
	del draw
	#存入session,用于做进一步验证
	request.session['verifycode'] = rand_str
	#内存文件操作
	import io
	buf = io.BytesIO()
	#将图片保存在内存中,文件类型为png
	im.save(buf,'png')
	#将内存中的图片数据返回给客户端,MIME类型为图片png
	return HttpResponse(buf.getvalue(), 'image/png')





