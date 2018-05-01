<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/static/public/commons.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>register</title>
<head>
<meta charset="UTF-8">
</head>
<body onload='$("#nickname").focus();'>
	<div class="container">
		<div class="row">
			<section>
				<div class="page-header">
					<h1>Welcome to registration</h1>
				</div>
			</section>
			<div class="col-lg-8 col-lg-offset-2">
				<form  method="post" action="user/register.shtml" id="myForm" Class="form-horizontal">
					<fieldset>
						 <legend>Required</legend>
						 <div class="form-group">
						 	<label class="col-lg-3 control-label">Nickname</label>
						 	<div class="col-lg-5">
						 		<input id="nickname" name="nickname" placeholder="昵称" Class="form-control"/>
						 	</div>
						 </div>
						 <div class="form-group">
						 	<label class="col-lg-3 control-label">Email Account</label>
						 	<div class="col-lg-5">
						 		<input id="email" name="email" class="form-control" placeholder="账号">
						 	</div>
						 </div>
						 <div class="form-group">
						 	<label class="col-lg-3 control-label">Password</label>
						 	<div class="col-lg-5">
						 		<input type="password" class="form-control" name="password" placeholder="密码">
						 	</div>
						 </div>
						 <div class="form-group">
						 	<label class="col-lg-3 control-label">Repeat the password</label>
						 	<div class="col-lg-5">
						 		<input type="password" class="form-control" name="re_password" placeholder="密码">
						 	</div>
						 </div>
					</fieldset>
					<div class="form-group">
                         <div class="col-lg-9 col-lg-offset-3">
                             <button type="submit" class="btn btn-primary">注册</button>
                             <button type="button" class="btn btn-primary" id="login">登录</button>
                         </div>
                    </div>	
                 </form>			
			</div>
		</div>
	</div>
<script type="text/javascript">
	// 登录跳转
	$("#login").click(function() {
		window.location.href = '<%=basePath%>' + 'user/login.shtml';
	});
	
	$(function() {
		$("#myForm").bootstrapValidator({
			message : 'This value is not valid',
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			fields : {
				nickname : {
					message : '昵称无效',
					validators : {
						notEmpty : {
							message : '昵称不能为空'
						},
						stringLength : {
							min : 2,
							max : 12,
							message : '昵称必须在2到12之间'
						}
					}
				},
				email : {
					message : '账号无效',
					threshold : 6, // 当输入框输入6个及以上个字符开始验证
					validators : {
						notEmpty : {
							message : '账号不能为空'
						},
						emailAddress : {
							message : '邮箱账号格式有误'
						},
						remote : {
							// ajax验证。server result:{"valid",true or false}
							// 向服务发送当前input name值，获得一个json数据。例表示正确：{"valid",true}
							// data : { email : $("#email").val()}
							// 这里可以不使用data属性，框架将自动读取需要被验证的属性名称和值组成json格式的数据
							message : '邮箱账号已被注册',
							url : '<%=basePath%>' + 'user/checkAccount.shtml',
							delay : 2000,// 每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
							type : 'POST'
						}
					}
				},
				password : {
					message : '密码无效',
					validators : {
						notEmpty : {
							message : '密码不能为空'
						},
						stringLength : {
							min : 6,
							max : 16,
							message : '密码长度必须在6到16之间'
						},
						different : {
							field : 'email',
							message : '密码不能与账号相同'
						},
						identical : {
							field : 're_password',
							message : '两次密码输入不相同'
						}
					}
				},
				re_password : {
					message : '重复密码无效',
					validators : {
						notEmpty : {
							message : '重复密码不能为空'
						},
						identical : {
							field : 'password',
							message : '两次密码输入不相同'
						}
					}
				}
			}
		}).on('success.form.bv', function(e) {
			// 防止表单提交
			e.preventDefault();
			// 获取表单实例
			var $form = $(e.target);
			// 获取bootstrapValidator实例
			var bv = $form.data('bootstrapValidator');
			// 使用Ajax提交表单
			$.post($form.attr('action'), $form.serialize(), function(result) {
				if (result && result.status != 200) {
					return layer.msg(result.message, function() {
					}), !1;
				} else {
					layer.msg(result.message);
					var path = '<%=basePath%>';
					window.location.href = path;
				}
			}, 'json');
		})
	});
</script>
</body>
</html>