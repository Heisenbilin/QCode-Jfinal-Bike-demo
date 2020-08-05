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
				renderHtml("ɨ��ɹ�������Ϊ"+result);
			}
			else {
				renderHtml("��������ʹ���У�����Ϊ"+result);
			}
		}
		else {
			renderHtml("����������");
		}
	}
	
	public void addBike() {
		String lng = this.getPara("lng");
		String lat = this.getPara("lat");
		String position = lng + ',' +lat;
		System.out.print(position);
		String flag = Bike.bike.addBikeByPosition(position);
		if(flag!="null"){
			renderHtml("��ӵ����ɹ�������Ϊ��"+flag);
		}
		else {
			renderHtml("���ʧ��");
		}
	}
}
