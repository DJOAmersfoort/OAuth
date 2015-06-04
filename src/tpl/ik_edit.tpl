<div id="error" class="alert alert-danger hidden"><strong>Oeps, </strong><span id="errortext"></span><a class="close" href="#" aria-hidden="true">&times;</a></div>
<form role="form" id="profileform" action="javascript:void(0);" method="post">
	<div class="row">
		<div class="col-xs-12">
		  <div class="form-group">
			<label for="profile_mail">E-mailadres</label>
				<input data-required="een email-adres" type="email" class="form-control" id="profile_mail" name="email" value="{{email}}">
			</div>
		</div>
	</div>
	<div class="row">
	  <div class="col-sm-4">
			<div class="form-group">
			  <label for="profile_voornaam">Voornaam</label>
			  <input data-required="een naam" type="text" class="form-control" id="profile_voornaam" name="voornaam" value="{{firstname}}">
			</div>
		</div>
		<div class="col-sm-4">
			<div class="form-group">
				<label for="profile_tussenvoegsel">Tussenvoegsel</label>
				<input type="text" class="form-control" id="profile_tussenvoegsel" name="tussenvoegsel" value="{{tussenvoegsel}}">
			</div>
		</div>
	  <div class="col-sm-4">
			<div class="form-group">
			  <label for="profile_achternaam">Achternaam</label>
			  <input type="text" class="form-control" data-required="een achternaam" id="profile_achternaam" name="achternaam" value="{{lastname}}">
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-6">
		    <div class="form-group">
			<label for="profile_mobile">Mobiele nummer</label>
			<input type="tel" class="form-control" id="profile_mobile" name="mobile" value="{{mobile}}">
		    </div>
		</div>
		<div class="col-sm-6">
			<div class="form-group">
				<label for="profile_voornaam">DJO lid/begeleider?</label><br />
				{{^djo}}
				<div class="btn-group btn-group-justified" data-toggle="buttons">
					<label class="btn btn-default {{#wantsDjo}}active{{/wantsDjo}}">
						<input type="radio" name="djolid" value="true" {{#wantsDjo}}checked{{/wantsDjo}}>Ik ben lid
					</label>
					<label class="btn btn-default {{^wantsDjo}}active{{/wantsDjo}}">
						<input type="radio" name="djolid" value="false" {{^wantsDjo}}checked{{/wantsDjo}}>Ik ben geen lid
					</label>
				</div>
				{{/djo}}{{#djo}}
				<div style="font-size: 16px; margin-top: 7px;"><span class="glyphicon glyphicon-ok"></span> <i>Je bent een geverifieerd DJO-lid</i></div>
				{{/djo}}
			</div>
		</div>
	</div>
	<div id="addfield_address">
		
	</div>
	<div id="addfield_telephone">
		
	</div>
	<button data-addfield="address" type="button" class="btn btn-default"><span class="glyphicon glyphicon-plus-sign"></span> Adres toevoegen</button>
	<!--&nbsp;&nbsp;<span class="visible-xs"><br /></span>
	<button data-addfield="telephone" type="button" class="btn btn-default"><span class="glyphicon glyphicon-plus-sign"></span> Telefoon toevoegen</button>-->
	<br />
	<br />
	<input type="hidden" name="type" value="profileEdit" />
	<input type="hidden" name="countaddress" value="0" />
	<input type="hidden" name="counttelephone" value="0" />
	<input type="hidden" name="iscreatinginweb" value="true" />
	<button type="submit" class="btn btn-success">Opslaan</button>
	&nbsp;&nbsp;
	<button type="button" class="btn btn-info" data-toggle="modal" data-target="#modal_editPassword"><span class="glyphicon glyphicon-edit"></span> Wachtwoord aanpassen</button>
</form>
<div class="hidden" id="templates">
    <div id="address">
		<div id="addrow">
			<div class="row">
				<div class="col-xs-12">
					<span class="close" data-type="address" data-hidethis="true">&times;</span>
					<div class="form-group">
						<label for="profile_adress_street">Adres {num}</label>
						<input type="text" class="form-control" data-required="een straat" id="profile_address_street" name="address_street_{num}" value="" placeholder="Amersfoortseweg 31" />
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-6">
					<div class="form-group">
						<input type="text" class="form-control" data-required="een postcode" id="profile_address_postal" name="address_postalcode_{num}" value="" placeholder="3817BB" />
					</div>
				</div>
				<div class="col-sm-6">
					<div class="form-group">
						<input type="text" class="form-control" data-required="een stad" id="profile_address_town" name="address_town_{num}" value="" placeholder="Amersfoort" />
					</div>
				</div>
			</div>
		</div>
    </div>
	<div id="telephone">
		<div id="addrow">
			<div class="row">
				<div class="col-xs-12">
					<span class="close" data-type="telephone" data-hidethis="true">&times;</span>
					{num}
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="modal_editPassword" tabindex="-1" role="dialog" aria-labelledby="modal_editPassword_title" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="modal_editPassword_title">Wachtwoord Aanpassen</h4>
			</div>
			<form role="form" id="editPasswordForm" action="javascript:void(0);" method="post">
				<div class="modal-body" style="padding-bottom: 0;">
					<div class="row">
						<div class="col-xs-12">
							<div class="form-group">
								<label for="password_old">Oude wachtwoord</label>
								<input type="password" class="form-control" data-required="je oude wachtwoord" id="password_old" name="password_old" value="" />
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-12">
							<div class="form-group">
								<label for="password_new">Nieuw wachtwoord</label>
								<input type="password" class="form-control" data-required="een wachtwoord" id="password_new" name="password_new" value="" />
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-12">
							<div class="form-group">
								<label for="password_new_repeat">Herhaal je nieuwe wachtwoord</label>
								<input type="password" class="form-control" data-required="je wachtwoord nogmaals" id="password_new_repeat" name="password_new_repeat" value="" />
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Sluiten</button>
					<button type="submit" class="btn btn-info">Opslaan</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
$("[data-addfield]").click(function() {
	$("[data-hidethis=true][data-type="+$(this).data("addfield")+"]:visible").css("visibility", "hidden");
	$("#addfield_"+$(this).data("addfield")).append($(".hidden > #"+$(this).data("addfield")).html().replace(/{num}/g , $("[name=count"+$(this).data("addfield")+"]").val(parseInt($("[name=count"+$(this).data("addfield")+"]").val())+1).val()));
	$("[data-hidethis=true][data-type="+$(this).data("addfield")+"]:visible").click(function() {
		$(this).closest("#addrow").remove();
		$("[data-hidethis=true][data-type="+$(this).data("type")+"]:visible").last().css("visibility", "visible");
		$("[name=count"+$(this).data("type")+"]").val($("#addfield_"+$(this).data("type")+" > #addrow").length);
	});
	updateError();
});
function CheckPassword(password) {
	var score = 1;
	
	if (password.length < 1)
		return 0;
	if (password.length < 4)
		return 1;
	if (password.length >= 8)
		score++;
	if (password.length >= 10)
		score++;
	if (password.match(/\d+/))
		score++;
	if (password.match(/[a-z]/) &&
		password.match(/[A-Z]/))
		score++;
    if (password.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,£,(,)]/))
		score++;
	if (password.length <= 6)
		score--;
	
	return score;
}
function validateEmail(email) { 
	var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	return re.test(email);
}
$("#profile_mail").blur(function() {
	if($("#profile_mail").val() != "" && !validateEmail($("#profile_mail").val())) {
		$(this).parent().tooltip(
			{'trigger':'', 'title': 'Vul een geldig emailadres in.', 'placement': 'bottom'}
		).tooltip("show");
	}
});
$("#profile_pass").keydown(function() {
	setTimeout(function() {
		var score = CheckPassword($("#profile_pass").val());
		var color = ["default", "danger", "warning", "warning", "success", "success", "success"];
		$("#profile_pass").parent().find("button").removeClass("btn-default btn-danger btn-warning btn-success").addClass("btn-"+color[score]);
	},10);
});
$("#profileform").submit(function() {
	$("#error").addClass("hidden");
	$("[data-required]").each(function(index, element) {
		$(this).blur();
	});
	$("#profile_pass_repeat").blur();
	$("#profile_mail").blur();
	if($(".tooltip").length === 0) {
		var postData = $(this).serializeArray();
		$(".form-control").prop("disabled", true);
		$.ajax({
			type: "POST",
			url: "/data",
			data: postData,
			success: function(data) {
				var returndata = JSON.parse(data);
				
				if (typeof returndata.captcha !== "undefined") {
					$("#profile_captcha").val("");
					$("#captchatext").html(returndata.captcha);
				}
				
				if (typeof returndata.error != "undefined") {
					$(".form-control").prop("disabled", false);
					setupError(returndata.error);
					$("#profile_mail").first().focus();
					return;
				}
				if (typeof returndata.isregistered !== "undefined") {
					location.reload();
					return;
				}
				$(".form-control").prop("disabled", false);
			},
			error: function(xhr, status, error) {
				setupError("Er ging iets verkeerd met het inloggen");
			}
		});
	}
	return false;
});
$("#profile_pass_repeat").blur(function() {
	if($(this).val() === "") {
		$(this).parent().tooltip(
			{'trigger':'', 'title': 'Herhaal het wachtwoord', 'placement': 'bottom'}
		).tooltip("show");
	} else if($("#profile_pass").val() !== $(this).val()) {
		$(this).parent().tooltip(
			{'trigger':'', 'title': 'Wachtwoorden komen niet overeen', 'placement': 'bottom'}
		).tooltip("show");
	}
});
function updateError() {
	$("[data-required]:not([data-hasrequired='true']):visible").blur(function() {
		if($(this).val() === "") {
			$(this).parent().tooltip(
					{'trigger':'', 'title': 'Vul '+$(this).data("required")+' in.', 'placement': 'bottom'}
			).tooltip("show");
		}
	}).each(function() {
		$(this).attr("data-hasrequired", "true");
	});
	$(".form-control:not([data-hasdestroy='true']):visible").focus(function() {
		$(this).parent().tooltip("destroy");
	}).each(function() {
		$(this).attr("data-hasdestroy", "true");
	});
}
//}
updateError();
function setupError(text) {
	$("#errortext").text(text);
	$("#error").removeClass("hidden");
	$(".close").click(function() {
		$("#error").addClass("hidden");
	});
}
</script>