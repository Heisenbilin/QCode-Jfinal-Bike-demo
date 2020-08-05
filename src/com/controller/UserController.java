package com.controller;

import com.jfinal.core.Controller;
import com.model.User;

public class UserController extends Controller{
	public void login() {
		String name = getPara("name");//��ȡ�����ݣ�����Ĳ�������ҳ����е�name����ֵ
		String password = getPara("password");
		User item = User.userDao.findFirst("select * from user where name=?",name);//�����û�����ѯ���ݿ��е��û�
		if(item != null) {
			if(password.equals(item.getStr("password"))) {//�ж����ݿ��е��������û�����������Ƿ�һ��
				getSession().setAttribute("user", item);//����session�������¼�û����ǳ�
				renderHtml("login success");//��ǰ̨��������
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
		String name = getPara("name");		//��ȡ�����ݣ�����Ĳ�������ҳ����е�name����ֵ
		String email = getPara("email");
		String password = getPara("password");
		//User item = User.userDao.findFirst("insert into user (name,email,password) values(?,?,?)", name,email,password);//��������
		User item = User.userDao.findFirst("select * from user where name=?",name);//�����û�����ѯ���ݿ��е��û�
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
