<div class="page-header">
	<h1>
		<span id="pagetitle">{{{title}}}</span>
		<small>
			{{{subtitle}}}
		</small>
	</h1>
</div>
<div class="row">
	<div class="col-md-4 col-sm-6">
		<h3>Jouw gegevens <a href="/me/edit"><small><small>Aanpassen</small></small></a></h3>
		<div class="form-horizontal">
			<div class="form-group">
				<label class="col-xs-5 control-label">Voornaam</label>
				<div class="col-xs-7">
					<p class="form-control-static">{{firstName}}</p>
				</div>
			</div>
			{{#surName}}
			<div class="form-group">
				<label class="col-xs-5 control-label">Tussenvoegsel</label>
				<div class="col-xs-7">
					<p class="form-control-static">{{surName}}</p>
				</div>
			</div>
            {{/surName}}
			<div class="form-group">
				<label class="col-xs-5 control-label">Achternaam</label>
				<div class="col-xs-7">
					<p class="form-control-static">{{familyName}}</p>
				</div>
			</div>
			<div class="form-group">
				<label class="col-xs-5 control-label">E-mailadres</label>
				<div class="col-xs-7">
					<p class="form-control-static">{{email}}</p>
				</div>
			</div>
			<div class="form-group">
				<label class="col-xs-5 control-label">Gebruikers-ID</label>
				<div class="col-xs-7">
					<p class="form-control-static">{{id}}@oauth.djoamersfoort.nl</p>
				</div>
			</div>
			<div class="form-group">
				<label class="col-xs-5 control-label">Rang</label>
				<div class="col-xs-7">
					<p class="form-control-static"><span class="label label-info tooltipTitle" title="{{rank}}">{{rank}}</span></p>
				</div>
			</div>
			{{#addresses}}
			<div class="form-group">
				<label class="col-xs-5 control-label">Adres {{i}}</label>
				<div class="col-xs-7">
					<p class="form-control-static">{{adres_street}} {{adres_number}}<br />{{adres_postalcode}}, {{adres_town}}</p>
				</div>
			</div>
			{{/addresses}}
			<div class="form-group">
				<label class="col-xs-5 control-label">2-staps authenticatie</label>
				<div class="col-xs-7">
					<p class="form-control-static"><a href="/me/2stepauth" style="text-decoration: none;">
							<span class="label label-{{#2fa}}success{{/2fa}}{{^2fa}}danger{{/2fa}} tooltipTitle" title="{{#2fa}}Klik om 2-staps authenticatie uit te schakelen.{{/2fa}}{{^2fa}}Je account is niet extra beveiligd.{{/2fa}}">{{#2fa}}Aan{{/2fa}}{{^2fa}}Uit{{/2fa}}</span>
					</a></p>
				</div>
			</div>
		</div>
	</div>
	<div class="col-md-4 col-sm-6">
		<h3>Jouw apps <a href="/apps"><small>Meer</small></a></h3>
		<div class="list-group">
			{{#apps}}
			<a href="/apps/{{id}}" class="list-group-item">
				<h5>
					<b>
						{{name}}
						<span class="pull-right" style="font-size: 28px; margin-top: -7px;">
							{{#edit}}<span class="glyphicon glyphicon-edit"></span>&nbsp;&nbsp;{{/edit}}
							{{#read}}<span class="glyphicon glyphicon-eye-open"></span>{{/read}}
						</span>
					</b>
				</h5>
			</a>
			{{/apps}}
			{{^apps}}
			<small>Je gebruikt dit account nog nergens om online in te loggen.</small>
			{{/apps}}
		</div>
	</div>
</div>
