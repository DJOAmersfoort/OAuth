<div class="row">
	<div class="col-md-4 col-sm-6">
		<h3>Gegevens <a href="/ik/edit"></a></h3>
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
					<p class="form-control-static">{{user_id}}@oauth.djoamersfoort.nl</p>
				</div>
			</div>
			<div class="form-group">
				<label class="col-xs-5 control-label">Rang</label>
				<div class="col-xs-7">
					<p class="form-control-static"><span class="label label-{{^djomember}}{{^inactivated}}info{{/inactivated}}{{/djomember}}{{#djomember}}warning{{/djomember}}{{#inactivated}}danger{{/inactivated}} tooltipTitle {{#currentUserHasAccessToEditUser}}{{#djomember}}pointer{{/djomember}}{{/currentUserHasAccessToEditUser}}" {{#currentUserHasAccessToEditUser}}{{#djomember}}title="Klik om de gebruiker als djo lid te verifiëren" data-verifybutton="true"{{/djomember}}{{/currentUserHasAccessToEditUser}}>{{rank}}</span></p>
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
					<p class="form-control-static">
							<span class="label label-white tooltipTitle" title="{{#2fa}}{{^canTurnOff2StepAuth}}2-staps authenticatie staat uit{{/canTurnOff2StepAuth}}{{#canTurnOff2StepAuth}}Klik om 2-staps authenticatie uit te schakelen{{/canTurnOff2StepAuth}}{{/2fa}}{{^2fa}}2-staps authenticatie staat uit{{/2fa}}">{{#2fa}}Aan{{/2fa}}{{^2fa}}Uit{{/2fa}}</span>
					</p>
				</div>
			</div>
		</div>
	</div>
	<div class="col-md-4 col-sm-6">
		<h3>Apps <a href="/apps"></a></h3>
		<div class="list-group">
			{{#apps}}
			<div class="list-group-item">
				<h5>
					<b>
						{{name}}
						<span class="pull-right" style="font-size: 28px; margin-top: -7px;">
							{{#edit}}<span class="glyphicon glyphicon-edit"></span>&nbsp;&nbsp;{{/edit}}
							{{#read}}<span class="glyphicon glyphicon-eye-open"></span>{{/read}}
						</span>
					</b>
				</h5>
			</div>
			{{/apps}}
			{{^apps}}
			<small>Deze gebruiker gebruikt nog geen apps.</small>
			{{/apps}}
		</div>
	</div>
</div>
{{#currentUserHasAccessToEditUser}}
<div class="modal fade" id="modalEditRank" tabindex="-1" role="dialog" aria-labelledby="modalEditRankLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="modalEditRankLabel">Rang aanpassen</h4>
			</div>
			<div class="modal-body">
				<div id="error_rank" data-id="rank" class="alert alert-danger hidden">
					<strong>Oeps, </strong>
					<span id="errortext_rank"></span>
					<a class="close" href="#" aria-hidden="true">&times;</a>
				</div>
				<p>Kies een nieuwe rang voor de gebruiker, let op: de rank moet onder die van jouw zitten.</p>
				<br />
				<select id="newRank" class="form-control">
					{{#ranksAccessible}}
					<option {{#isSelected}}selected{{/isSelected}} value="{{value}}">{{name}}</option>
					{{/ranksAccessible}}
				</select>
			</div>
			<div class="modal-footer">
				<button type="button" data-dismiss="modal" class="btn btn-default">Annuleren</button>
				<button type="button" class="btn btn-info" id="saveNewRank">Opslaan</button>
			</div>
		</div>
	</div>
</div>
<script>
	function errorForRankEdit(text) {
		$("#error_rank > #errortext_rank").text(text);
		$("#error_rank").removeClass("hidden");
		$("#error_rank > .close").click(function() {
			$("#error_rank").addClass("hidden");
		});
		
	}
	$("#saveNewRank").click(function() {
		$(".form-control").prop("disabled", true);
		$("#error_rank").addClass("hidden");
		$.ajax({
			type: "POST",
			url: "/data",
			data: {"type": "EditRank", "rank": $("#newRank").val(), "id": {{user_id}}},
			success: function(data) {
				var returndata = JSON.parse(data);
				
				if (typeof returndata.error !== "undefined") {
					errorForRankEdit(returndata.error);
					$(".form-control").prop("disabled", false);
					return;
				}
				if (typeof returndata.changedRank !== "undefined") {
					location.reload();
					return;
				}
			},
			error: function() {
				errorForRankEdit("Er ging iets mis bij het opslaan");
			}
		});
	});
	
	{{#djomember}}
	$("[data-verifybutton='true']").click(function() {
		$.ajax({
			type: "POST",
			url: "/data",
			data: {"type": "EditRank", "rank": 1, "id": {{user_id}}},
			success: function(data) {
				var returndata = JSON.parse(data);
				
				if (typeof returndata.error !== "undefined") {
					alert(returndata.error);
					return;
				}
				if (typeof returndata.changedRank !== "undefined") {
					location.reload();
					return;
				}
			},
			error: function() {
				alert("Er ging iets mis bij het opslaan.");
			}
		});
		
	});
	{{/djomember}}
</script>
{{/currentUserHasAccessToEditUser}}
{{#canRemoveUser}}
<div class="modal fade" id="modaldeleteUser" tabindex="-1" role="dialog" aria-labelledby="modaldeleteUserLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="modaldeleteUserLabel">Gebruiker verwijderen</h4>
			</div>
			<div class="modal-body">
				<div id="error_delete" class="alert alert-danger hidden">
					<strong>Oeps, </strong>
					<span id="errortext_delete"></span>
					<a class="close" href="#" aria-hidden="true">&times;</a>
				</div>
				<p>Als u zeker weet dat u de gebruiker <b>{{firstName}}, {{user_id}}</b> wilt verwijderen moet u uw wachtwoord hieronder invoeren.</p>
				<p>Let op: Dit kan niet ongedaan worden!</p>
				<br />
				<div class="form-group">
					<label for="DeleteUserPassword">Uw wachtwoord </label>
					<input type="password" id="DeleteUserPassword" placeholder="&bull;&bull;&bull;&bull;&bull;&bull;" class="form-control"/>
				</div>
			</div>
			<div class="modal-footer" style="margin-top: 0;">
				<button type="button" data-dismiss="modal" class="btn btn-default">Annuleren</button>
				<button type="button" class="btn btn-danger" id="deleteUser">Verwijderen</button>
			</div>
		</div>
	</div>
</div>
<script>
	$("#deleteUser").click(function() {
		$(".form-control").prop("disabled", true);
		$("#error_delete").addClass("hidden");
		$.ajax({
			type: "POST",
			url: "/data",
			data: {"type": "DeleteUser", "password": $("#DeleteUserPassword").val(), "id": {{user_id}}},
			success: function(data) {
				var returndata = JSON.parse(data);
				
				if (typeof returndata.error !== "undefined") {
					errorForDeleteUser(returndata.error);
					$(".form-control").prop("disabled", false);
					return;
				}
				if (typeof returndata.userIsDeleted !== "undefined") {
					window.location = "/users";
					return;
				}
			},
			error: function() {
				errorForDeleteUser("Er ging iets mis bij het verwijderen van de gebruiker.");
			}
		});
	});
	function errorForDeleteUser(text) {
		$("#error_delete > #errortext_delete").text(text);
		$("#error_delete").removeClass("hidden");
		$("#error_delete > .close").click(function() {
			$("#error_delete").addClass("hidden");
		});
	}
</script>
{{/canRemoveUser}}