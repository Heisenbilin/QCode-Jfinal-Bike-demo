package com.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;

public class User extends Model<User> {
	public static final User userDao = new User();
	
	public List<User> getUsers() {
		List<User> users = userDao.find("SELECT * FROM user");
		return users;
	}
	
//	 public static void main(String[] args){
//		User user = userDao.findById("xbl");
//		System.out.println(user.toString());
//	}
}
