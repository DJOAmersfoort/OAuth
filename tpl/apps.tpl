<div class="page-header">
	<h1>
		<span id="pagetitle">{{{title}}}</span>
		<small>
			{{{subtitle}}}
		</small>
	</h1>
</div>
<ul class="nav nav-pills nav-stacked">
	{{#apps}}
		<li><a href="/apps/{{id}}"><b>{{name}}</b><span class="pull-right">{{#write}}<span class="glyphicon glyphicon-edit"></span> &nbsp;&nbsp;{{/write}}{{#read}}<span class="glyphicon glyphicon-eye-open"></span> &nbsp;&nbsp;{{/read}}<em>Laatst gebruikt: Onbekend</em></span></a></li>

	{{/apps}}
</ul>
