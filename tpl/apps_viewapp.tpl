<style>
	.history_icon {
		height: 20px;
		width: 20px;
		background: #5cb85c;
		border-radius: 10px;
		border: 1px #4cae4c solid;
		position: absolute;
		top: 50%;
		margin-top: -10px;
		right: 10px;
	}
	.history_icon.orange {
		background: #f0ad4e;
		border-color: #eea236;
	}
	.history_icon.red {
		background: #d9534f;
		border-color: #d43f3a;
	}
</style>
<div class="page-header">
	<h1>
		<span id="pagetitle">{{{title}}}</span>
		<small>
			{{{subtitle}}}
		</small>
	</h1>
</div>
<div class="row">
	<div class="col-md-6 col-sm-7 col-xs-12">
		<div class="media">
			<div class="pull-left">
				<img src="{{appimage}}" height="128" width="128">
			</div>
			<div class="media-body">
				<h2 class="media-heading">{{appname}}</h2>
				<p>
				{{appinfotext}}
				</p>
			</div>
		</div>
		<div class="row">
			{{{access}}}
			{{#access_read}}

			{{/access_read}}
			{{#access_write}}

			{{/access_write}}
		</div>
		<br />
		<a class="btn btn-success" href="" data-toggle="modal" data-target="#auth" title="Dit trekt alle keys van {{appname}} in">Toegang intrekken</a>
		<div class="visible-xs"><br /><br /></div>
	</div>

	<div class="col-md-6 col-sm-5 col-xs-12">
		<div class="media">
			<div class="media-body">
				<h2 class="media-heading">Geschiedenis</h2>
				<div class="list-group">
					<a href="javascript:void(0)" class="list-group-item" data-placement="bottom" data-original-title="Data" data-toggle="popover" title="" data-content="<b>Response</b><br />Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis pretium ullamcorper metus vel mattis. Sed condimentum et diam sed adipiscing. Proin sit amet elementum augue. Nunc eleifend convallis libero, quis dictum ante faucibus non. Morbi nec faucibus turpis. Nullam elementum facilisis eros. Sed lobortis, ligula aliquet volutpat fringilla, risus augue vehicula felis, eget dapibus lacus dolor et urna.<br /><br /><b>Headers</b><br />Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis pretium ullamcorper metus vel mattis. Sed condimentum et diam sed adipiscing. Proin sit amet elementum augue. Nunc eleifend convallis libero, quis dictum ante faucibus non. Morbi nec faucibus turpis. Nullam elementum facilisis eros. Sed lobortis, ligula aliquet volutpat fringilla, risus augue vehicula felis, eget dapibus lacus dolor et urna.<br /><small><br />25 januari 2014 14:55</small>" data-html="true"><span style="font-size:14px;">API v1 aanvraag via access token</span><div class="pull-right"><div class="history_icon"></div></div></a>
					<a href="javascript:void(0)" class="list-group-item"><span style="font-size:14px;">Access token aanvraag via authorisatie</span><div class="pull-right"><div class="history_icon"></div></div></a>
					<a href="javascript:void(0)" class="list-group-item"><span style="font-size:14px;">Access token aanvraag via refresh token</span><div class="pull-right"><div class="history_icon orange" data-toggle="tooltip" data-placement="top" data-container="body" title="Refresh token verlopen"></div></div></a>
				</div>
				<small>Oudere geschiedenis kan worden opgevraagd bij een admin</small>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="auth" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Authenticatie</h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-xs-10 col-xs-offset-1">
						{{^2fa}}
						<p>Vul je wachtwoord in om de toegang van {{appname}} in te trekken</p>
						{{/2fa}}{{#2fa}}
						<p>Vul je 2-staps authenticatie code in om de toegang {{appname}} in te trekken</p>
						{{/2fa}}
			 	 	</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Annuleren</button>
				<button type="button" class="btn btn-primary">Intrekken</button>
			</div>
		</div>
	</div>
</div>
