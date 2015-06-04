<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title>DJO - OAuth</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="https://oauth.djoamersfoort.nl/css/bootstrap.3.0.3.min.css" rel="stylesheet">
	<link href="https://oauth.djoamersfoort.nl/css/site.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-2.0.3.min.js"></script>
    <script src="https://oauth.djoamersfoort.nl/js/bootstrap.3.0.3.min.js"></script>
	<style>
		hr {
			margin-top: 0;
			margin-bottom: 0;
		}
	</style>
</head>
<body>
	<div class="navbar navbar-static-top" role="navigation">
		<div class="container">
			<div class="navbar-header" title="De Jonge Onderzoekers Amersfoort authorisatie">
				<div class="navbar-brand"></div>
				<!--<span class="navbar-djo-domainnav-title"><b>Auth</b></span>-->
			</div>
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav navbar-right">
					{{{menu}}}
				</ul>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row" style="margin-top: 60px;">
			<div class="col-md-6 col-sm-8 col-xs-10 col-md-offset-3 col-sm-offset-2 col-xs-offset-1">
				<div class="media">
					<div class="pull-left">
						<img src="{{{appimage}}}" height="128" width="128">
					</div>
					<div class="media-body">
						<h2 class="media-heading">{{appname}}</h2>
						<p>
						{{appinfotext}}
						</p>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-10 col-xs-12 col-sm-offset-1 col-xs-offset-0">
						<hr size="3" noshade style="margin-top: 20px;">
						<div class="pull-left">
							<h1><span class="glyphicon glyphicon-eye-open"></span></h1>
						</div>
						<div class="visible-lg">
							<div class="pull-right" style="margin-top: 14px;">
								<span style="font-size: 22px;">Deze app kan uw gegevens lezen</span>
							</div>
						</div>
						<div class="hidden-lg">
							<div class="pull-right" style="margin-top: 20px;">
								<span style="font-size: 16px;">Deze app kan uw gegevens lezen</span>
							</div>
						</div>
					</div>
					<div class="col-sm-10 col-xs-12 col-sm-offset-1 col-xs-offset-0">
						<hr size="3" noshade>
					</div>
				</div>
				<br />
				<br />
				<button type="button" class="btn btn-success" data-toggle="modal" data-target="#confirm">Machtigen</button>
				<small>&nbsp;&nbsp;&nbsp;Je kunt de machteging ongedaan maken via je instellingen</small>
				<div class="modal fade" id="confirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-body">
								<h3 style="margin-top: 0;">Weet je het zeker?</h3>
								<p>Vul je wachtwoord in om door te gaan.</p>
								<br />
								<form role="form" action="javascript:void(0);" method="post">
									<div class="form-group">
										<input type="password" name="pass" class="form-control" id="password" placeholder="&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;" value=""/>
									</div>
									<br />
									<input type="hidden" name="app" value="{{appid}}" />
                                    <input type="hidden" name="type" value="machtigen" />
									<button type="submit" class="btn btn-success">Machtigen</button>
									<button type="button" class="btn btn-default" data-dismiss="modal">Annuleren</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	$("form").submit(function() {
		var postData = $(this).serializeArray();
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
					return;
				}
				if(typeof returndata.isauthorized !== "undefined") {
					if(returndata.isauthorized == true) {
						window.location = window.location;
					}
				}
			},
			error: function(xhr, status, error) {
				setupError("Er ging iets verkeerd met het inloggen");
			}
		});
	});
	function setupError(error) {
		$("#password").parent().tooltip({"trigger":"", "title": error, "placement": "bottom"}).tooltip("show");
	}
	$("#password").focus(function() {
		$(this).parent().tooltip("destroy");
	});
	
	</script>
</body>
</html>