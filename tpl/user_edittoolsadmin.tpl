{{#currentUserHasAccessToEditUser}}
<div class="btn-group pull-right">
	<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
		<span class="glyphicon glyphicon-edit"></span> Aanpassen <span class="caret"></span>
	</button>
	<ul class="dropdown-menu editUser" role="menu">
		<li><a href="./{{userId}}/edit"><span class="glyphicon glyphicon-pencil"></span> Profiel aanpassen</a></li>
		<li><a data-toggle="modal" data-target="#modalEditRank"><span class="glyphicon glyphicon-sort"></span> Rang wijzigen</a></li>
		{{#canRemoveUser}}<li><a data-toggle="modal" data-target="#modaldeleteUser"><span class="glyphicon glyphicon-remove"></span> Gebruiker verwijderen</a></li>{{/canRemoveUser}}
	</ul>
</div>
{{/currentUserHasAccessToEditUser}}