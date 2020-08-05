package com.controller;

import jp.sourceforge.qrcode.data.QRCodeImage;

import java.awt.image.BufferedImage;

/**
 * ʵ��QRCodeImage�ӿڣ�
 * ���ý����ͼƬ��Ϣ
 * ����codeDecoder.decode()��Ҫ������ͼƬ����
 * Created by BigRoc on 2017/9/9.
 */
public class MyQRCodeImage implements QRCodeImage{


    BufferedImage bufferedImage;

    public MyQRCodeImage(BufferedImage bufferedImage){
        this.bufferedImage=bufferedImage;
    }

    //��
    @Override
    public int getWidth() {
        return bufferedImage.getWidth();
    }

    //��
    @Override
    public int getHeight() {
        return bufferedImage.getHeight();
    }

    //���ػ�����ɫ
    @Override
    public int getPixel(int i, int j) {
        return bufferedImage.getRGB(i,j);
    }
}
