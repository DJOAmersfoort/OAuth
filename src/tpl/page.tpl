<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>DJO OAuth - {{title}}</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="{{url}}/static/css/bootstrap.3.0.3.min.css" rel="stylesheet">
		<link href="{{url}}/static/branding/css/djo-branding.css" rel="stylesheet" />
		<link href="{{url}}/static/css/site.css" rel="stylesheet">
		<script src="{{url}}/static/js/jquery.1.11.1.min.js"></script>
		<script src="{{url}}/static/js/bootstrap.3.0.3.min.js"></script>
		<script src="{{url}}/static/js/site.js"></script>
	</head>

	<body data-page="{{pageid}}">
		<div class="navbar-wrapper navbar-djo">
			<div class="container">
				<div class="navbar navbar-default navbar-static-top">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
						<a class="navbar-brand oauth" href="/"></a>
					</div>
					<div class="navbar-collapse collapse">
						<ul class="nav navbar-nav">{{{navbarleft}}}</ul>
						<ul class="nav navbar-nav navbar-right">{{{navbarright}}}</ul>
					</div>
				</div>
			</div>
		</div>

		<div class="container">
			{page}
		</div>
	</body>
</html>
