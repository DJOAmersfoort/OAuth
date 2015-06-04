<div id="error" class="alert alert-danger hidden"><strong>Oeps, </strong><span id="errortext"></span><a class="close" href="#" aria-hidden="true">&times;</a></div>
<form role="form" id="registerform" action="javascript:void(0);" method="post">
	<div class="row">
		<div class="col-xs-12">
		  <div class="form-group">
			<label for="register_mail">E-mailadres <span style="color: #F00">*</span></label>
				<input data-required="een email-adres" autofocus type="email" class="form-control" id="register_mail" name="email" value="" placeholder="email@example.com">
			</div>
		</div>
	</div>
	<div class="row">
	  <div class="col-sm-4">
			<div class="form-group">
			  <label for="register_voornaam">Voornaam <span style="color: #F00">*</span></label>
			  <input data-required="een naam" type="text" class="form-control" id="register_voornaam" name="voornaam" value="" placeholder="Jort">
			</div>
		</div>
		<div class="col-sm-4">
			<div class="form-group">
				<label for="register_tussenvoegsel">Tussenvoegsel</label>
				<input type="text" class="form-control" id="register_tussenvoegsel" name="tussenvoegsel" value="" placeholder="van der">
			</div>
		</div>
	  <div class="col-sm-4">
			<div class="form-group">
			  <label for="register_achternaam">Achternaam <span style="color: #F00">*</span></label>
			  <input type="text" class="form-control" data-required="een achternaam" id="register_achternaam" name="achternaam" value="" placeholder="Sloot">
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-6">
			<label for="register_pass">Wachtwoord <span style="color: #F00">*</span></label>
			<div class="input-group">
				<input data-required="een wachtwoord" type="password" class="form-control" id="register_pass" name="pass" value="" placeholder="&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;">
				<div class="input-group-btn">
					<button type="button" disabled="disabled" class="btn btn-default">&nbsp;&nbsp;&nbsp;</button>
				</div>
			</div>
		</div>
		<div class="col-sm-6">
		  <div class="form-group">
				<label for="register_pass_repeat">Herhaal wachtwoord <span style="color: #F00">*</span></label>
				<input type="password" class="form-control" id="register_pass_repeat" name="passrepeat" value="" placeholder="&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;">
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-6">
		    <div class="form-group">
			<label for="register_mobile">Telefoon nummer</label>
			<input type="tel" class="form-control" id="register_mobile" name="mobile" value="" placeholder="+31 6 13228754 ">
		    </div>
		</div>
		<div class="col-sm-6">
			<div class="form-group">
				<label for="register_voornaam">DJO lid/begeleider? <span style="color: #F00">*</span></label><br />
				<div class="btn-group btn-group-justified" data-toggle="buttons">
					<label class="btn btn-default">
						<input type="radio" name="djolid" value="true">Ik ben lid
					</label>
					<label class="btn btn-default active">
						<input type="radio" name="djolid" value="false" checked>Ik ben geen lid
					</label>
				</div>
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
	<div class="row">
		<div class="col-xs-12">
			<div class="form-group">
				<h3><span id="captchatext">{{{captcha}}}</span>? </h3>
				<input type="text" class="form-control" data-required="de captcha" id="register_captcha" name="captcha" value="" placeholder="9001">		
			</div>
		</div>
	</div>
	<br />
	<input type="hidden" name="type" value="register" />
	<input type="hidden" name="countaddress" value="0" />
	<!--<input type="hidden" name="counttelephone" value="0" />-->
	<input type="hidden" name="iscreatinginweb" value="true" />
	<button type="submit" class="btn btn-success">Aanmelden</button>
</form>
<div class="hidden" id="templates">
    <div id="address">
		<div id="addrow">
			<div class="row">
				<div class="col-xs-12">
					<span class="close" data-type="address" data-hidethis="true">&times;</span>
					<div class="form-group">
						<label for="register_adress_street">Adres {num} <span style="color: #F00">*</span></label>
						<input type="text" class="form-control" data-required="een straat" id="register_address_street" name="address_street_{num}" value="" placeholder="Amersfoortseweg 31" />
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-6">
					<div class="form-group">
						<input type="text" class="form-control" data-required="een postcode" id="register_address_postal" name="address_postalcode_{num}" value="" placeholder="3817BB" />
					</div>
				</div>
				<div class="col-sm-6">
					<div class="form-group">
						<input type="text" class="form-control" data-required="een stad" id="register_address_town" name="address_town_{num}" value="" placeholder="Amersfoort" />
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
$("#register_mail").blur(function() {
	if($("#register_mail").val() != "" && !validateEmail($("#register_mail").val())) {
		$(this).parent().tooltip(
			{'trigger':'', 'title': 'Vul een geldig emailadres in.', 'placement': 'bottom'}
		).tooltip("show");
	}
});
$("#register_pass").keydown(function() {
	setTimeout(function() {
		var score = CheckPassword($("#register_pass").val());
		var color = ["default", "danger", "warning", "warning", "success", "success", "success"];
		$("#register_pass").parent().find("button").removeClass("btn-default btn-danger btn-warning btn-success").addClass("btn-"+color[score]);
	},10);
});
$("#registerform").submit(function() {
	$("#error").addClass("hidden");
	$("[data-required]").each(function(index, element) {
		$(this).blur();
	});
	$("#register_pass_repeat").blur();
	$("#register_mail").blur();
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
					$("#register_captcha").val("");
					$("#captchatext").html(returndata.captcha);
				}
				
				if (typeof returndata.error != "undefined") {
					$(".form-control").prop("disabled", false);
					setupError(returndata.error);
					$("#register_mail").first().focus();
					return;
				}
				if (typeof returndata.isregistered !== "undefined") {
					location.reload();
					return;
				}
				$(".form-control").prop("disabled", false);
			},
			error: function(xhr, status, error) {
				setupError("Er ging iets verkeerd bij het aanmelden.");
			}
		});
	}
	return false;
});
$("#register_pass_repeat").blur(function() {
	if($(this).val() === "") {
		$(this).parent().tooltip(
			{'trigger':'', 'title': 'Herhaal het wachtwoord', 'placement': 'bottom'}
		).tooltip("show");
	} else if($("#register_pass").val() !== $(this).val()) {
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