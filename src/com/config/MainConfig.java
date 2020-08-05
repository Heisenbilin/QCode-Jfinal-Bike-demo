package com.config;

import com.controller.BikeController;
import com.controller.fileController;
import com.controller.UserController;
import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.ext.handler.ContextPathHandler;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.render.ViewType;
import com.model.Bike;
import com.model.User;

public class MainConfig extends JFinalConfig {

	@Override
	public void configConstant(Constants me) {
		me.setDevMode(true);
		me.setEncoding("utf-8");
		me.setViewType(ViewType.JSP); 
		me.setBaseUploadPath("/WebContent") ;

	}

	@Override
	public void configRoute(Routes me) {
		me.add("/bike", BikeController.class);
		me.add("/file",fileController.class);
		me.add("/user",UserController.class);

	}

	
	//配置数据库和model层的映射
	@Override
	public void configPlugin(Plugins me) {
		C3p0Plugin c3p0Plugin = new C3p0Plugin("jdbc:mysql://localhost:3306/gobikes?useSSL=false", "root", "xbl23win");
		c3p0Plugin.setDriverClass("com.mysql.jdbc.Driver");
		me.add(c3p0Plugin); 
		ActiveRecordPlugin arp = new ActiveRecordPlugin(c3p0Plugin); 		
		me.add(arp); 
		arp.addMapping("bike", Bike.class);
		arp.addMapping("user", User.class);
	}

	@Override
	public void configInterceptor(Interceptors me) {
		// TODO 自动生成的方法存根

	}

	@Override
	public void configHandler(Handlers me) {
		me.add(new ContextPathHandler("basePath"));

	}

}
