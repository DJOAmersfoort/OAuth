<div class="page-header">
	<h1>
		<span id="pagetitle">{{{title}}}</span>
		<small>
			{{{subtitle}}}
		</small>
	</h1>
</div>
<div class="col-md-6 col-sm-8 col-xs-10 col-md-offset-3 col-sm-offset-2 col-xs-offset-1">

	<div class="panel panel-success">
		<div class="panel-body">
			<div class="media">
				<div class="pull-left">
					<h1 style="color: rgb(174, 255, 158); margin: 0;"><b>1&nbsp;&nbsp;&nbsp;</b></h1>
				</div>
				<div class="media-body">
					<p>
						Installeer de Google Authenticator app via de <a href="market://details?id=com.google.android.apps.authenticator2">Play store</a>, <a href="http://itunes.apple.com/us/app/google-authenticator/id388497605">App store</a> of via <a href="https://m.google.com/authenticator">Blackbarry App World</a>.
					</p>
				</div>
			</div>
		</div>
	</div>

	<br />

	<div class="panel panel-success">
		<div class="panel-body">
			<div class="media">
				<div class="pull-left">
					<h1 style="color: rgb(174, 255, 158); margin: 0;"><b>2&nbsp;&nbsp;&nbsp;</b></h1>
				</div>
				<div class="media-body">
					<p>
						Scan de onderstaande QR code via de app met je telefoon/tablet.
					</p>
					<br />
					<img class="center-block" src="http://chart.googleapis.com/chart?chs=200x200&chld=M%7C0&cht=qr&chl={{qrurl}}" alt="QR code">
					<br />
					<p>
						Heb je geen QR code scanner? gebruik dan <b>{{token}}</b> bij het invullen van een nieuwe 2-staps app secret
					</p>
				</div>
			</div>
		</div>
	</div>

	<br />

	<div class="panel panel-success">
		<div class="panel-body">
			<div class="media">
				<div class="pull-left">
					<h1 style="color: rgb(174, 255, 158); margin: 0;"><b>3&nbsp;&nbsp;&nbsp;</b></h1>
				</div>
				<div class="pull-right">
					<a class="btn btn-success" style="margin-bottom: 0px;" href="/me/2stepauth/check">Doorgaan</a>
				</div>
				<div class="media-body" style="margin-top: 8px;">
					<p>
						Druk op doorgaan om 2-staps authenticatie te testen
					</p>
				</div>
			</div>
		</div>
	</div>

</div>
