<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<title>DJO OAuth - {{title}}</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="{{url}}/static/css/bootstrap.3.0.3.min.css" rel="stylesheet">
	<link href="{{url}}/static/css/site.css" rel="stylesheet">
	<script src="{{url}}/static/js/jquery.1.11.1.min.js"></script>
	<script src="{{url}}/static/js/bootstrap.3.0.3.min.js"></script>
	<script src="{{url}}/static/js/site.js"></script>
</head>

<body data-page="{{pageid}}">
	<div class="navbar navbar-static-top" role="navigation">
		<div class="container">
			<div class="navbar-header" title="De Jonge Onderzoekers Amersfoort authorisatie">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<div class="navbar-brand"></div>
				<!--<span class="navbar-djo-domainnav-title"><b>Auth</b></span>-->
			</div>
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav">{{{navbarleft}}}
				</ul>
				<ul class="nav navbar-nav navbar-right">{{{navbarright}}}
				</ul>
			</div>
		</div>
	</div>
	
	<div class="container">
		<div class="page-header">
			<h1>
				<span id="pagetitle">{{{title}}}</span>
				<small>
					{{{subtitle}}}
				</small>
			</h1>
		</div>
		{page}
	</div>
</body>
</html>