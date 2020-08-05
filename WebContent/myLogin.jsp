<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="author" content="Kodinger">
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<title>登陆界面</title>
	<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/my-login.css">
	<script src="funcjs/jquery-1.9.1.min.js"></script>
	<script src="funcjs/jquery-form.js"></script>
    
</head>
<body class="my-login-page">
	<section class="h-100">
		<div class="container h-100">
			<div class="row justify-content-md-center h-100">
				<div class="card-wrapper">
					<div class="brand">
						<img src="img/logo.jpg" alt="logo">
					</div>
					<div class="card fat">
						<div class="card-body">
							<h2 class="card-title">GoBikes 登录界面</h2>
							<form method="post" id="loginForm" onsubmit="submitForm()" class="my-login-validation">
								<div class="form-group">
									<label for="email">用户名</label>
									<input id="name" type="text" class="form-control" name="name" value="" required autofocus>
									<div class="invalid-feedback">
										账号有误
									</div>
								</div>

								<div class="form-group">
									<label for="password">密码
										<a href="#" class="float-right">
											忘记密码?
										</a>
									</label>
									<input id="password" type="password" class="form-control" name="password" required data-eye>
								    <div class="invalid-feedback">
								    	密码有误
							    	</div>
								</div>

								<div class="form-group">
									<div class="custom-checkbox custom-control">
										<input type="checkbox" id="remember" class="custom-control-input">
										<label for="remember" class="custom-control-label">记住我</label>
									</div>
								</div>

								<div class="form-group m-0">
									<button type="submit" id="login" class="btn btn-primary btn-block">
										登录
									</button>
								</div>
								<div class="mt-4 text-center">
									没有账号? <a href="register.jsp">创建一个</a>
								</div>
							</form>
						</div>
					</div>
					<div class="footer">
						Copyright &copy; 2019 &mdash;共享单车系统
					</div>
				</div>
			</div>
		</div>
	</section>
	<script type="text/javascript">
		function submitForm(){
			$("#loginForm").ajaxSubmit({
				dataType:"html",
				url:"${basePath}/user/login",
				success: function(data){
					//console.log(data);
					if(data=="login success") {
						//alert("登录成功！");
						window.location="index.jsp";
					}
					else if(data=="password error") {
						alert("密码错误！");
					}
					else{
						alert("用户名错误！");
					}
				}
			});
		}
	
	</script>
	<script src="js/my-login.js"></script>
</body>
</html>
