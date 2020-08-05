package com.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;

public class Bike extends Model<Bike> {
	public static final Bike bike = new Bike();
	
	public String getbikes() {
		String result = "";
		List<Bike> bikes = bike.find("SELECT * FROM bike");
		for(Bike bike : bikes){
			result += bike.getStr("position")+"|";
		}
		return result;
	}
	
	public String addBikeByPosition(String position) {
		List<Bike> bikes = bike.find("select * from bike order by id desc limit 0,1");
		String lastBikeID = bikes.get(0).getStr("id");
		String nickID = String.valueOf(Integer.parseInt(lastBikeID)+1);
		Bike nickbike = new Bike().set("id", nickID).set("position", position).set("lock","1");
		if(nickbike.save()){
			return nickID;
		}
		else {
			return "null";
		}
	}
	
	public Bike getBikeByID(String bikeID) {
		Bike nowBike = bike.findById(bikeID);
		return nowBike;
	}
	
}
