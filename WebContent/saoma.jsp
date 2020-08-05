<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>扫码</title>

    <link rel="stylesheet" href="css/saoma.css"/>
    <script src="funcjs/jquery-1.9.1.min.js"></script>
    <script src="funcjs/llqrcode.js"></script>
    <script src="funcjs/webqr.js"></script>
</head>

<body >
    <div id="main">
        <div id="mainbody">
            <table class="tsel" border="0" width="100%">
                <tr>
                    <td valign="top" align="center" width="50%">
                        <table class="tsel" border="0">
                            <tr>
                                <td  align="center">
                                    <div id="outdiv">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td><button class="weui-btn weui-btn_primary"    onclick="setwebcam()" id="btnsaveCharge">相机扫码</button></td>
                            </tr>
                            <tr>
                                <td><button class="weui-btn weui-btn_primary"  onclick="setimg()" id="btnsaveCharge">相册识别</button></td>
                            </tr>
                            <tr ><td><div  class="weui-input" id="result"></div></td></tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <canvas id="qr-canvas" width="800" height="600"></canvas>
    <script type="text/javascript">

        load();
        setwebcam();
    
    </script>
</body>

</html>