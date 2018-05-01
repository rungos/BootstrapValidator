<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/static/public/commons.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${session_user.nickname }</title>
<style type="text/css">
body {
	min-width: 500px;
}
</style>
<meta charset="UTF-8">
</head>
<body>
	<div class="container">
		<div class="row">
			<section>
				<div class="page-header">
					<h1>Welcome ${session_user.nickname } 
						<a href="javascript:void(0);" style="float: right;">
							<button type="button" class="btn btn-primary" onclick="logout();">logout</button>
						</a>
					</h1>
				</div>
			</section>
		</div>
	</div>
</body>
<script type="text/javascript">
function logout() {
	$.ajax({
		url : "user/logout.shtml",
		type : "GET",
		dataType : "json",
		success : function(result) {
			if (result && result.status != 200) {
				layer.msg('退出失败，请重试！');
				return;
			} else {
				layer.msg('退出成功');
				setTimeout(function() {
					window.location.reload(true);
					return !1;
				}, 1000)
			}
		}
	})
}
</script>
</html>