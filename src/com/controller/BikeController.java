package com.controller;

import com.jfinal.core.Controller;
import com.model.Bike;

public class BikeController extends Controller {
	public void index() {
		this.render("/index.html");
	}
	
	public void getBikes() {
		String result = Bike.bike.getbikes();
		this.renderHtml(result);
	}
	
	public void saoma() {
		String result = this.getPara("id");
		Bike nowBike = Bike.bike.getBikeByID(result);
        if(nowBike != null) {
			if(nowBike.getStr("lock").equals("1")) {
				nowBike.set("lock",0);
				nowBike.update();
				renderHtml("扫码成功，车号为"+result);
			}
			else {
				renderHtml("单车已在使用中，车号为"+result);
			}
		}
		else {
			renderHtml("单车不存在");
		}
	}
	
	public void addBike() {
		String lng = this.getPara("lng");
		String lat = this.getPara("lat");
		String position = lng + ',' +lat;
		System.out.print(position);
		String flag = Bike.bike.addBikeByPosition(position);
		if(flag!="null"){
			renderHtml("添加单车成功，车号为："+flag);
		}
		else {
			renderHtml("添加失败");
		}
	}
}
