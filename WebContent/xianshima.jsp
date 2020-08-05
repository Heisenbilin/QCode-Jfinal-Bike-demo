<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>生成二维码</title>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
<script src="funcjs/qrcode.min.js"></script>
<script src="funcjs/qrcode.js"></script> 
<script src="funcjs/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
$(function(){
	//conServer();
	});
function conServer(){
	$.ajax({
		type: "POST",
		url: "${basePath}/file/unlock",
		data : "id=1234", 
		dataType: "html",
	    error:function(request) {
          	alert("Connect faild");
        },
		success: function(data){
			alert(data);
		}
	});
	
	AutoUpdConten();
}
function AutoUpdConten(){
	//setTimeout(conServer, 10000);
}
</script>
</head>
<body>
	<input id="text" type="text" value="0000" /><br />
	<div id="qrcode"></div>
	<input type="file" name="pic" value="æ«æäºç»´ç "  /> 
	<script type=text/javascript>
	var qrcode = new QRCode("qrcode");

	function makeCode () {      
	    var elText = document.getElementById("text");
	    
	    if (!elText.value) {
	        alert("Input a text");
	        elText.focus();
	        return;
	    }
	    
	    qrcode.makeCode(elText.value);
	}

	makeCode();

	$("#text").
	on("click", function () {
	    makeCode();
	}).
 	on("keydown", function (e) {
	    if (e.keyCode == 13) {
	        makeCode();
	    }
	});
	</script>
</body>
</html>