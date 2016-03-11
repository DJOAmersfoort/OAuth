<div class="page-header">
	<h1>
		<span id="pagetitle">{{{title}}}</span>
		<small>
			{{{subtitle}}}
		</small>
	</h1>
</div>
{{#users_rangs}}
<div class="row">
	<h3 class="col-md-12">
		{{title}}
		{{#count}}<span class="text-muted">&nbsp;({{count}})</span>{{/count}}
	</h3>
	{{#users}}
	<div class="col-lg-3 col-md-4 col-xs-12 col-sm-6">
		<div class="panel panel-default">
			<div class="panel-body">
				<span class="pull-right">
					<span class="label label-{{color}} tooltipTitle">{{rang}}</span>
				</span>
				<span class="clearfix">
					<a href="/user/{{id}}">
						{{firstname}} {{#middlename}}{{middlename}} {{/middlename}}{{lastname}}
					</a>
				</span>
			</div>
		</div>
	</div>
	{{/users}}{{^users}}
	<div class="col-md-12">
		<p>Er zitten geen gebruikers in de groep {{title}}</p>
		<br />
	</div>
	{{/users}}
</div>
{{/users_rangs}}