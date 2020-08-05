<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <title>GoBikes</title>
    <link rel="stylesheet" href="css/index.css"/>
    <script src="funcjs/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=8a8f95a73721a82d1c5c6a907f1b7989"></script>
    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
    <script>
    //传递上传的二维码
    function sendimg(){
    	alert("checking...");
    	var formData = new FormData();
    	formData.append("file",$("#scan")[0].files[0]);
    	//console.log($("#scan")[0].files[0]);
    	$.ajax({
			type: "POST",
			url: "${basePath}/file/deal",
			data : formData, 
			processData : false, 
			contentType : false,
			dataType: "html",
		    error:function(request) {
	          	alert("连接失败！");
	        },
			success: function(data){
				alert(data);
			}
		});
    }
    </script>
<body>
<div id='container'></div>
<div id="tip"></div>
<div id="btn">
	<form id="img"  enctype="multipart/form-data">
		<input id="scan" type="file" value="开始用车" onchange="sendimg()">
		<input id="user" type="button" onclick="window.location.href='saoma.jsp'" value="扫码">
	</form>
</div>
<script type="text/javascript">

    var map, geolocation, marker;
    //新建高德地图对象，加载地图，调用浏览器定位服务
    map = new AMap.Map('container', {
    	center:[114.3864727020,30.4735322293],
    	//mapStyle: 'blue_night',
        resizeEnable: true,
		zoom: 15
    });
    //调用AMap.Geolocation插件来实现定位
    map.plugin('AMap.Geolocation', function(){
        geolocation = new AMap.Geolocation({
            enableHighAccuracy: true,				//是否使用高精度定位，默认:true
            timeout: 10000,          				//超过10秒后停止定位，默认：无穷大
            buttonOffset: new AMap.Pixel(50,50),	//定位按钮与设置的停靠位置的偏移量，默认：Pixel(10, 20)
            zoomToAccuracy: true,      				//定位成功后调整地图视野范围使定位位置及精度范围视野内可见，默认：false
            buttonPosition:'RB'						//定位按钮的排放位置，RB表示右下
        });
        map.addControl(geolocation);				//给定位点添加图标
        geolocation.getCurrentPosition();
		AMap.event.addListener(geolocation, 'complete', onComplete);//返回定位信息
		AMap.event.addListener(geolocation, 'error', onError);      //返回定位出错信息
    });
    //解析定位结果
    function onComplete(data) {
        var str=['定位成功'];
        str.push('经度：' + data.position.getLng());
        str.push('纬度：' + data.position.getLat());
        str.push('精度：' + data.accuracy + ' 米');
        str.push('是否经过偏移：' + (data.isConverted ? '是' : '否'));
        document.getElementById('tip').innerHTML = str.join('<br>');
        getBikes();
    }
    //解析定位错误信息
    function onError(data) {
        console.log("定位失败！"+data);
        getBikes();
    }
    
	function getBikes(){
		$.ajax({
			type: "POST",
			url: "${basePath}/bike/getBikes",
			dataType: "html",
			data: "id=1",
		    error:function(request) {
	          	alert("Connect faild");
	        },
			success: function(data){
				//alert(data);
				console.log(data);
				var positions = data.split('|');
				addMarker(positions);
			}
		});
	}
    
	function addMarker(positions){
		for(var i=0;i<positions.length;i++)	{
			//alert(positions[i]);
		 	marker = new AMap.Marker({
				position: positions[i].split(','),
				icon: 'icons/BIKE.png',
				map: map
			}); 
		}
	}
	
</script>
</body>
</html>