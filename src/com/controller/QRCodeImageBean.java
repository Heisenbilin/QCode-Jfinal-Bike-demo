package com.controller;

import java.awt.image.BufferedImage;

import jp.sourceforge.qrcode.data.QRCodeImage;

public class QRCodeImageBean implements QRCodeImage {

    BufferedImage bufImg;  
    
    public QRCodeImageBean(BufferedImage bufImg) {  
        this.bufImg = bufImg;  
    }  
      
    @Override  
    public int getHeight() {  
        return bufImg.getHeight();  
    }  
  
    @Override  
    public int getPixel(int x, int y) {  
        return bufImg.getRGB(x, y);  
    }  
  
    @Override  
    public int getWidth() {  
        return bufImg.getWidth();  
    }  
}