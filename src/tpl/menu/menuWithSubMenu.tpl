<li class="dropdown{{#active}} active{{/active}}">
	<a class="dropdown-toggle" data-toggle="dropdown" href="javascript:void(0);">
		{{{name}}}
		<b class="caret"></b>
	</a>
	<ul class="dropdown-menu">
		{{#subMenus}}{{#divider}}
		<li class="divider"></li>
		{{/divider}}{{#header}}<li class="dropdown-header">{{header}}</li>{{/header}}
		<li><a href="/{{url}}">{{{name}}}</a></li>{{/subMenus}}
	</ul>
</li>