package com.controller;

import java.awt.Image;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import javax.imageio.ImageIO;

import com.interceptor.FileInterceptor;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.upload.UploadFile;
import com.model.Bike;

import jp.sourceforge.qrcode.QRCodeDecoder;
import jp.sourceforge.qrcode.exception.DecodingFailedException;


public class fileController extends Controller {
	private static int flag = 1;
	
	@Before(FileInterceptor.class)
	public void deal() {
		UploadFile uploadFile=this.getFile();        		//获取传过来的文件
        String fileName=uploadFile.getOriginalFileName();	//获取文件名字
        System.out.println(fileName);

        File file=uploadFile.getFile();    //获取文件内容
        BufferedImage bufferedImage = null;  //创建文件流对象，用来以流形式读取文件
		try {
			bufferedImage = ImageIO.read(file);		//读取文件至bufferedImage
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		QRCodeDecoder codeDecoder = new QRCodeDecoder();  //创建QRCode解析器
        String result = null;	//解析结果
		try {
			//解析文件
			result = new String(codeDecoder.decode(new MyQRCodeImage(bufferedImage)), "utf-8");
		} catch (DecodingFailedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(result != null) {
	        System.out.println("decoder success!!!");
	        System.out.println("二维码内容为:" + result);
	        Bike nowBike = Bike.bike.getBikeByID(result);
	        if(nowBike != null) {
				if(nowBike.getStr("lock").equals("1")) {
					nowBike.set("lock",0);
					nowBike.update();
					renderHtml("车辆已解锁！车号为"+result);
				}
				else {
					renderHtml("车辆正在使用，车号为"+result);
				}
			}
			else {
				renderHtml("无该单车记录");
			}
		}
		else {
	        renderHtml("解析文件失败");
		} 
	}
	
	public void unlock() {
		if(flag==0){
			renderHtml("未解锁");
		}else{
			renderHtml("已解锁");
		}
	}
	
	public static void zoomImage(String src,String dest,int w,int h) throws Exception {
		double wr=0,hr=0;
		File srcFile = new File(src);
		File destFile = new File(dest);

		BufferedImage bufImg = ImageIO.read(srcFile); //读取图片
		Image Itemp = bufImg.getScaledInstance(w, h, bufImg.SCALE_SMOOTH);//设置缩放目标图片模板
	        
		wr=w*1.0/bufImg.getWidth();     //获取缩放比例
		hr=h*1.0/bufImg.getHeight();

		AffineTransformOp ato = new AffineTransformOp(AffineTransform.getScaleInstance(wr, hr), null);
		Itemp = ato.filter(bufImg, null);
		try {
			ImageIO.write((BufferedImage) Itemp,dest.substring(dest.lastIndexOf(".")+1), destFile); //写入缩减后的图片
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}
