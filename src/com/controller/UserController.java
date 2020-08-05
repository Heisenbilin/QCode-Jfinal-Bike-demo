package com.controller;

import com.jfinal.core.Controller;
import com.model.User;

public class UserController extends Controller{
	public void login() {
		String name = getPara("name");//获取表单数据，这里的参数就是页面表单中的name属性值
		String password = getPara("password");
		User item = User.userDao.findFirst("select * from user where name=?",name);//根据用户名查询数据库中的用户
		if(item != null) {
			if(password.equals(item.getStr("password"))) {//判断数据库中的密码与用户输入的密码是否一致
				getSession().setAttribute("user", item);//设置session，保存登录用户的昵称
				renderHtml("login success");//给前台返回数据
			}
			else {
				renderHtml("password error");
			}
		}
		else {
			renderHtml("name error");
		}
	}
	
	public void register(){
		String name = getPara("name");		//获取表单数据，这里的参数就是页面表单中的name属性值
		String email = getPara("email");
		String password = getPara("password");
		//User item = User.userDao.findFirst("insert into user (name,email,password) values(?,?,?)", name,email,password);//插入数据
		User item = User.userDao.findFirst("select * from user where name=?",name);//根据用户名查询数据库中的用户
		if(item != null) {
			renderHtml("regist error");
		}
		else {
			User nickuser = new User().set("password",password).set("name",name).set("email",email);
			nickuser.save();
			renderHtml("regist success");
		}
	}
}
