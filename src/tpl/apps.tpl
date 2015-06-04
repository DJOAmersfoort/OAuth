<ul class="nav nav-pills nav-stacked">
	{{#apps}}
		<li><a href="/apps/{{id}}"><b>{{name}}</b><span class="pull-right">{{#write}}<span class="glyphicon glyphicon-edit"></span> &nbsp;&nbsp;{{/write}}{{#read}}<span class="glyphicon glyphicon-eye-open"></span> &nbsp;&nbsp;{{/read}}<em>Laatst gebruikt: Onbekend</em></span></a></li>
		
	{{/apps}}
</ul>