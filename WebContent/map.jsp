<!doctype html>
<%@ page language="java" contentType="text/html; charset=GB2312"
    pageEncoding="GB2312"%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="chrome=1">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <title>带检索功能的信息窗体</title>
    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
    <style type="text/css">
        .info-title {
            color: white;
            font-size: 14px;
            background-color:blue;
            line-height: 26px;
            padding: 0px 0 0 6px;
            font-weight: lighter;
            letter-spacing: 1px
        }
        .info-content {
            font: 12px Helvetica, 'Hiragino Sans GB', 'Microsoft Yahei', '微软雅黑', Arial;
            padding: 4px;
            color: #666666;
            line-height: 23px;
        }
        .info-content img {
            float: left;
            margin: 3px;
        }
    </style>
    <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=8a8f95a73721a82d1c5c6a907f1b7989&plugin=AMap.AdvancedInfoWindow"></script>
    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
    
	<script src="funcjs/jquery-1.9.1.min.js"></script>
	<script src="funcjs/jquery-form.js"></script>
</head>
<body>
<div id="container"></div>
<div id="myPageTop">
    <table>
        <tr>
            <td>
                <label>按关键字搜索：</label>
            </td>
            <td class="column2">
                <label>左击获取经纬度：</label>
            </td>
        </tr>
        <tr>
            <td>
                <input type="text" placeholder="请输入关键字进行搜索" id="tipinput">
            </td>
            <td class="column2">
                <input type="text" id="position">
            </td>
        </tr>
    </table>
</div>
<div class="button-group">
	<input type="button" class="button" value="添加单车" onclick="addBike()"/>
    <input type="button" class="button" value="信息窗体1" onclick="infowindow1.open(map,lnglat)"/>
    <input type="button" class="button" value="信息窗体2" onclick="infowindow2.open(map,lnglat)"/>
    <input type="button" class="button" value="信息窗体3" onclick="infowindow3.open(map,lnglat)"/>
</div>
<script type="text/javascript">
	var lnglat = [114.385968,30.473768];
	var lng = 0;
	var lat = 0;
    var map = new AMap.Map('container', {
        resizeEnable: true,
        center: lnglat,
		zoom: 15
    });
    getBikes();
    var marker = new AMap.Marker({
        position: lnglat 
    });


    var content='<div class="info-title">高德地图</div><div class="info-content">' +
            '<img src="http://webapi.amap.com/images/amap.jpg">';
    var  infowindow1 = new AMap.AdvancedInfoWindow({
        content: content,
        offset: new AMap.Pixel(0, -30)
    });
    var  infowindow2 = new AMap.AdvancedInfoWindow({
        content: content,
        asOrigin: false,
        asDestination: false,
        offset: new AMap.Pixel(0, -30)
    });
    var  infowindow3 = new AMap.AdvancedInfoWindow({
        content: content,
        placeSearch: false,
        asDestination: false,
        offset: new AMap.Pixel(0, -30)
    });
    
    var clickEventListener = map.on('click', function(e) {
        document.getElementById("position").value = e.lnglat.getLng() + ',' + e.lnglat.getLat()
        lng = e.lnglat.getLng();
        lat = e.lnglat.getLat();
    });
    var auto = new AMap.Autocomplete({
        input: "tipinput"
    });
    AMap.event.addListener(auto, "select", select);//注册监听，当选中某条记录时会触发
    function select(e) {
        if (e.poi && e.poi.location) {
            map.setZoom(15);
            map.setCenter(e.poi.location);
            marker.setPosition(e.poi.location);
            marker.setMap(map);
        }
    }
    
    function addBike(map,lnglat){
    
        console.log(lng,lat);
    	if(lat==lng){
    		alert('请选择位置');
    		return;
    	}
		var position = lng + ',' +lat;
		
		console.log(position.split(','))
    	let params={"lng":this.lng,"lat":this.lat};
    	 $.ajax({
			type : "POST",
			url : "${basePath}/bike/addBikes", 
			data : params,
		    error:function(request) {
	          	alert("Connect faild");
	        },
			success : function(data){
				addBikeMarker(position);
				alert(data);
		   }
		});
    }
    
    function addBikeMarker(position){
			//alert(positions[i]);
		 	marker = new AMap.Marker({
					position: position.split(','),
					icon: 'icons/BIKE.png',
					map: map
			}); 
	}
    
    function getBikes(){
		$.ajax({
			type: "POST",
			url: "${basePath}/bike/getBike",
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