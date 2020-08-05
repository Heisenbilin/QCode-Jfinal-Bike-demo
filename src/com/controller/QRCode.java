package com.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;
import jp.sourceforge.qrcode.QRCodeDecoder;
import jp.sourceforge.qrcode.exception.DecodingFailedException;
import jp.sourceforge.qrcode.reader.QRCodeImageReader;

public class QRCode {

    /** 
     * 解析二维码（QRCode） 
     * @param imgPath 图片路径 
     * @return 
     */  
    public String decoderQRCode(String imgPath) {  
        // QRCode 二维码图片的文件  
        File imageFile = new File(imgPath);  
        BufferedImage bufImg = null;  
        String content = null;  
        try {  
            bufImg = ImageIO.read(imageFile);  
            QRCodeDecoder decoder = new QRCodeDecoder();  
/*            QRCodeImageReader imageReader new QRCodeImageReader();
            imageReader.getQRCodeSymbol(arg0)*/
            content = new String(decoder.decode(new QRCodeImageBean(bufImg)), "utf-8");   
        } catch (IOException e) {  
            System.out.println("Error: " + e.getMessage());  
            e.printStackTrace();  
        } catch (DecodingFailedException dfe) {  
            System.out.println("Error: " + dfe.getMessage());  
            dfe.printStackTrace();  
        }  
        return content;  
    }  
   
/*
    public static void main(String[] args) {  
        String imgPath = "G:/jee-neon/workspace/GoBikes/WebContent/imagee.jpg";  
        QRCode handler = new QRCode();  
        String qrCon = handler.decoderQRCode(imgPath);
        System.out.println("decoder success!!!");  
        System.out.println("二维码内容为:" + qrCon);
    }  
*/
}