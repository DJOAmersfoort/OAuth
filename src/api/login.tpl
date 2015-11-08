<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>DJO - OAuth</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="{{url}}/static/css/bootstrap.3.0.3.min.css" rel="stylesheet">
		<link href="{{url}}/static/branding/css/djo-branding.css" rel="stylesheet" />
		<link href="{{url}}/static/css/site.css" rel="stylesheet">
		<script src="https://code.jquery.com/jquery-2.0.3.min.js"></script>
	  <script src="{{url}}/static/js/bootstrap.3.0.3.min.js"></script>
	</head>
	<body data-page="oauth-login">
		<div class="navbar-wrapper navbar-djo">
			<div class="container">
				<div class="navbar navbar-default navbar-static-top">
					<div class="navbar-header">
						<a class="navbar-brand oauth" href="/"></a>
					</div>
					<div class="navbar-collapse collapse">
						<ul class="nav navbar-nav navbar-right">
							<li><a>Authorisatie</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>

		<div class="container">
			<form role="form" id="loginform" action="javascript:void(0);" method="post">
				<div class="row page-top">
					<div class="col-sm-10 col-sm-offset-1 col-md-6 col-md-offset-3">
						<div id="error" class="alert alert-danger hidden"><strong>Oeps, </strong><span id="errortext"></span><a class="close" href="#" aria-hidden="true">&times;</a></div>
						<div class="form-group">
							<div class="row">
								<div class="col-xs-3" style="padding-top: 6px;">
									<label for="loginform_pass" class="pull-left">E-mailadres</label>
								</div>
								<div class="col-xs-9">
									<input autofocus type="email" autocomplete="off" class="form-control" id="loginform_mail" name="email" value="" placeholder="email@example.com">
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="row">
								<div class="col-xs-3" style="padding-top: 6px;">
									<label for="loginform_pass" class="pull-left">Wachtwoord</label>
								</div>
								<div class="col-xs-9">
									<input type="password" autocomplete="off" class="form-control" id="loginform_pass" name="pass" value="" placeholder="&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;">
								</div>
							</div>
						</div>

						<p>
							<a href="/login/forgot" class="btn btn-link" style="padding-left: 0; margin-left: 0;">Wachtwoord vergeten?</a>
							 /
							<a href="/aanmelden" class="btn btn-link">aanmelden</a>
							<!--<button type="button" id="login_remember" class="btn btn-primary" data-toggle="button">Onthouden</button>-->
							&nbsp;&nbsp;<button type="submit" class="btn btn-djo pull-right">Login</button>
						</p>

						<input type="hidden" name="login_remember" value="false" />
						<input type="hidden" name="type" value="login" />
					</div>
				</div>
			</form>
			<script type="text/javascript">
			function validateEmail(email) {
			    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
			    return re.test(email);
			}
			$("#login_remember").click(function() {
				$("[name=login_remember]").val($("[name=login_remember]").val() == "true" ? "false" : "true");
			});
			$("#loginform").submit(function() {
				var postData = $(this).serializeArray();
				if($("#loginform_mail").val() === "") {
					$("#loginform_mail").parent().tooltip(
						{'trigger':'', 'title': 'Vul een emailadres in.', 'placement': 'bottom'}
					).tooltip("show");
				} else if($("#loginform_pass").val() === "") {
					$("#loginform_pass").parent().tooltip(
						{'trigger':'', 'title': 'Vul een wachtwoord in in.', 'placement': 'bottom'}
					).tooltip("show");
				} else if($("#loginform_mail").val().length > 200) {
					$("#loginform_mail").parent().tooltip(
						{'trigger':'', 'title': 'Email te lang. (max 200 tekens)', 'placement': 'bottom'}
					).tooltip("show");
				} else if($("#loginform_pass").val().length > 32) {
					$("#loginform_pass").parent().tooltip(
						{'trigger':'', 'title': 'Wachtwoord te lang. (max 32 tekens)', 'placement': 'bottom'}
					).tooltip("show");
				} else if(!validateEmail($("#loginform_mail").val())) {
					$("#loginform_mail").parent().tooltip(
						{'trigger':'', 'title': 'Vul een geldig emailadres in.', 'placement': 'bottom'}
					).tooltip("show");
				} else {
					$("form > .form-group > .form-control").prop("disabled", true);
					$.ajax({
						type: "POST",
						url: "/data",
						data: postData,
						success: function(data) {
							var returndata = JSON.parse(data);
							$("form > .form-group > .form-control").prop("disabled", false);
							if (typeof returndata.error != "undefined") {
								setupError(returndata.error);
								$("#loginform_mail").first().focus();
								return;
							}
							if(typeof returndata.isloggedin !== "undefined") {
								if(returndata.isloggedin === true) {
									location.reload(true);
								}
							}

						},
						error: function(xhr, status, error) {
							setupError("Er ging iets verkeerd met het inloggen");
						}
					});
				}
				return false;
			});
			$(".form-control").focus(function() {
				$(this).parent().tooltip("destroy");
			});
			function setupError(text) {
				$("#errortext").text(text);
				$("#error").removeClass("hidden");
				$(".close").click(function() {
					$("#error").addClass("hidden");
				});
			}
			</script>

		</div>
	</body>
</html>
