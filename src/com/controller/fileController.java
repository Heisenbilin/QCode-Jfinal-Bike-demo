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
		UploadFile uploadFile=this.getFile();        		//��ȡ���������ļ�
        String fileName=uploadFile.getOriginalFileName();	//��ȡ�ļ�����
        System.out.println(fileName);

        File file=uploadFile.getFile();    //��ȡ�ļ�����
        BufferedImage bufferedImage = null;  //�����ļ�����������������ʽ��ȡ�ļ�
		try {
			bufferedImage = ImageIO.read(file);		//��ȡ�ļ���bufferedImage
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		QRCodeDecoder codeDecoder = new QRCodeDecoder();  //����QRCode������
        String result = null;	//�������
		try {
			//�����ļ�
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
	        System.out.println("��ά������Ϊ:" + result);
	        Bike nowBike = Bike.bike.getBikeByID(result);
	        if(nowBike != null) {
				if(nowBike.getStr("lock").equals("1")) {
					nowBike.set("lock",0);
					nowBike.update();
					renderHtml("�����ѽ���������Ϊ"+result);
				}
				else {
					renderHtml("��������ʹ�ã�����Ϊ"+result);
				}
			}
			else {
				renderHtml("�޸õ�����¼");
			}
		}
		else {
	        renderHtml("�����ļ�ʧ��");
		} 
	}
	
	public void unlock() {
		if(flag==0){
			renderHtml("δ����");
		}else{
			renderHtml("�ѽ���");
		}
	}
	
	public static void zoomImage(String src,String dest,int w,int h) throws Exception {
		double wr=0,hr=0;
		File srcFile = new File(src);
		File destFile = new File(dest);

		BufferedImage bufImg = ImageIO.read(srcFile); //��ȡͼƬ
		Image Itemp = bufImg.getScaledInstance(w, h, bufImg.SCALE_SMOOTH);//��������Ŀ��ͼƬģ��
	        
		wr=w*1.0/bufImg.getWidth();     //��ȡ���ű���
		hr=h*1.0/bufImg.getHeight();

		AffineTransformOp ato = new AffineTransformOp(AffineTransform.getScaleInstance(wr, hr), null);
		Itemp = ato.filter(bufImg, null);
		try {
			ImageIO.write((BufferedImage) Itemp,dest.substring(dest.lastIndexOf(".")+1), destFile); //д���������ͼƬ
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}
