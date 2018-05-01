<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/static/public/commons.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
<head>
<meta charset="UTF-8">
</head>
<body onload='$(".username").focus();'>
	<div class="container">
		<div class="row">
			<section>
				<div class="page-header">
					<h1>Welcome to log in</h1>
				</div>
			</section>
			<div class="col-lg-8 col-lg-offset-2">
				<form method="post" action="" id="myForm" Class="form-horizontal">
					<fieldset>
						 <legend>Required</legend>
						 <div class="form-group">
						 	<label class="col-lg-3 control-label">Account</label>
						 	<div class="col-lg-5">
						 		 <input type="text" class="username form-control" name="username" placeholder="账号">
						 	</div>
						 </div>
						 <div class="form-group">
						 	<label class="col-lg-3 control-label">Password</label>
						 	<div class="col-lg-5">
						 		<input type="password" class="form-control password" name="password" placeholder="密码">
						 	</div>
						 </div>
					</fieldset>
					<div class="form-group">
                         <div class="col-lg-9 col-lg-offset-3">
                         	<button type="button" class="btn btn-primary" id="login">登录</button>
                         	<button type="button" class="btn btn-primary" id="reg">注册</button>
                         </div>
                    </div>	
                 </form>			
			</div>
		</div>
	</div>
<script type="text/javascript">
	//初始化数据
	$(function() {
		init();
	})
	
	// 回车事件绑定
	document.onkeydown = function(event) {
		var e = event || window.event || arguments.callee.caller.arguments[0];
		if (e && e.keyCode == 13) {
			$('#login').click();
		}
	};
	
	// 注册跳转
	$("#reg").click(function() {
		window.location.href = '<%=basePath%>' + 'user/register.shtml';
	});
	
	// 登录操作
	$('#login').click(function() {
		// 开启验证
		$('#myForm').data('bootstrapValidator').validate();
		if (!$('#myForm').data('bootstrapValidator').isValid()) {
			return;
		}
		var username = $('.username').val();
		var password = $('.password').val();
		data = {
			password : password,
			email : username
		};
		var load = layer.load();
		$.ajax({
			url : "user/login.shtml",
			data : data,
			type : "post",
			dataType : "json",
			beforeSend : function() {
				layer.msg('开始登录，请注意后台控制台。');
			},
			success : function(result) {
				layer.close(load);
				if (result && result.status != 200) {
					layer.msg(result.message, function() {
					});
					$('.password').val('');
					// 验证失败后销毁
					$("#myForm").data('bootstrapValidator').destroy();
					$('#myForm').data('bootstrapValidator', null);
					// 重新加载
					init();
					return;
				} else {
					layer.msg(result.message);
					setTimeout(function() {
						var path = '<%=basePath%>';
						window.location.href = path;
					}, 1000)
				}
			},
			error : function(e) {
				console.log(e, e.message);
				layer.msg('请看后台Java控制台');
			}
		});
	});
	// init validator
	function init() {
		$("#myForm").bootstrapValidator({
			message : 'This value is not valid',
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			fields : {
				username : {
					message : '账号无效',
					validators : {
						notEmpty : {
							message : '账号不能为空'
						}
					}
				},
				password : {
					message : '密码无效',
					validators : {
						notEmpty : {
							message : '密码不能为空'
						}
					}
				}
			}
		}).on('success.form.bv', function(e) {
			// 防止表单提交，很重要
			e.preventDefault();
		})
	};
</script>
</body>
</html>