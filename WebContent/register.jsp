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
	<title>注册界面</title>
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
						<img src="img/logo.jpg" alt="bootstrap 4 login page">
					</div>
					<div class="card fat">
						<div class="card-body">
							<h2 class="card-title">GoBiles 注册界面</h2>
							<form method="post" onsubmit="submitForm()" id="registForm" class="my-login-validation">
								<div class="form-group">
									<label for="name">用户名</label>
									<input id="name" type="text" class="form-control" name="name" required autofocus>
									<div class="invalid-feedback">
										用户名不能使用
									</div>
								</div>

								<div class="form-group">
									<label for="email">邮箱地址</label>
									<input id="email" type="email" class="form-control" name="email" required>
									<div class="invalid-feedback">
										邮箱地址有误
									</div>
								</div>

								<div class="form-group">
									<label for="password">密码</label>
									<input id="password" type="password" class="form-control" name="password" required data-eye>
									<div class="invalid-feedback">
										密码格式不对
									</div>
								</div>

								<div class="form-group">
									<div class="custom-checkbox custom-control">
										<input type="checkbox" name="agree" id="agree" class="custom-control-input" required="">
										<label for="agree" class="custom-control-label">我同意<a href="#">用户协议</a></label>
										<div class="invalid-feedback">
											必须同意用户协议
										</div>
									</div>
								</div>

								<div class="form-group m-0">
									<button type="submit" id="regist" class="btn btn-primary btn-block">
										注册
									</button>
								</div>
								<div class="mt-4 text-center">
									已经有账号? <a href="myLogin.jsp">登录</a>
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
	        	$("#registForm").ajaxSubmit({
					dataType:"html",
					url:"${basePath}/user/register",
					success: function(data){
						console.log(data);
						if(data=="regist success") {
							alert("注册成功，马上登录吧！");
							window.location="myLogin.jsp";
						}
						else{
							alert("注册失败，用户名已存在！");
						}
					}
				});
		}
	</script>
	<script src="js/my-login.js"></script>
</body>
</html>
