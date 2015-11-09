<form role="form" id="loginform" action="javascript:void(0);" method="post">
	<div class="row page-top" style="">
		<div class="col-sm-10 col-sm-offset-1 col-md-6 col-md-offset-3">
      <div class="page-header" style="margin-bottom: 0;">
        <h1>
          <span id="pagetitle">{{{title}}}</span>
        </h1>
      </div>
      <p>
        DJO OAuth is een systeem zodat niet DJO'ers en DJO'ers in het geval de identity provider niet werkt zich kunnen identificeren zodat zij zich kunnen aanmelden voor evenementen of andere activiteiten. Heb je nog geen account?
        <a href="/register">Meld je dan eerst aan!</a>
      </p>
      <br />
			<div id="error" class="alert alert-danger hidden"><strong>Oeps, </strong><span id="errortext"></span><a class="close" href="#" aria-hidden="true">&times;</a></div>
			<div class="form-group">
				<div class="row">
					<div class="col-xs-3" style="padding-top: 6px;">
						<label for="loginform_pass" class="pull-left">E-mailadres</label>
					</div>
					<div class="col-xs-9">
						<input autofocus type="email" autocomplete="off" class="form-control" id="loginform_mail" name="email" value="" placeholder="email@example.com">
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="row">
					<div class="col-xs-3" style="padding-top: 6px;">
						<label for="loginform_pass" class="pull-left">Wachtwoord</label>
					</div>
					<div class="col-xs-9">
						<input type="password" autocomplete="off" class="form-control" id="loginform_pass" name="pass" value="" placeholder="&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;">
					</div>
				</div>
			</div>
			
			<p>
				<a href="/login/forgot" class="btn btn-link" style="padding-left: 0; margin-left: 0;">wachtwoord vergeten?</a>
				 /
				<a href="/register" class="btn btn-link">aanmelden</a>
				<!--<button type="button" id="login_remember" class="btn btn-primary" data-toggle="button">Onthouden</button>-->
				&nbsp;&nbsp;<button type="submit" class="btn btn-djo pull-right">Login</button>
			</p>
			
			<input type="hidden" name="login_remember" value="false" />
			<input type="hidden" name="type" value="login" />
		</div>
	</div>
</form>
<script type="text/javascript">
function validateEmail(email) { 
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}
$("#login_remember").click(function() {
	$("[name=login_remember]").val($("[name=login_remember]").val() == "true" ? "false" : "true");
});
$("#loginform").submit(function() {
	var postData = $(this).serializeArray();
	if($("#loginform_mail").val() == "") {
		$("#loginform_mail").parent().tooltip(
			{'trigger':'', 'title': 'Vul een email-adres in.', 'placement': 'bottom'}
		).tooltip("show");
	} else if($("#loginform_pass").val() == "") {
		$("#loginform_pass").parent().tooltip(
			{'trigger':'', 'title': 'Vul een wachtwoord in in.', 'placement': 'bottom'}
		).tooltip("show");
	} else if($("#loginform_mail").val().length > 254 ) {
		$("#loginform_mail").parent().tooltip(
			{'trigger':'', 'title': 'Email-adres te lang. (max 254 tekens)', 'placement': 'bottom'}
		).tooltip("show");
	} else if($("#loginform_pass").val().length > 32) {
		$("#loginform_pass").parent().tooltip(
			{'trigger':'', 'title': 'Wachtwoord te lang. (max 32 tekens)', 'placement': 'bottom'}
		).tooltip("show");
	} else if(!validateEmail($("#loginform_mail").val())) {
		$("#loginform_mail").parent().tooltip(
			{'trigger':'', 'title': 'Vul een geldig emailadres in.', 'placement': 'bottom'}
		).tooltip("show");
	} else {
		$("form > .form-group > .form-control").prop("disabled", true);
		$.ajax({
			type: "POST",
			url: "/data",
			data: postData,
			success: function(data) {
				var returndata = JSON.parse(data);
				$("form > .form-group > .form-control").prop("disabled", false);
				if (typeof returndata.error != "undefined") {
					setupError(returndata.error);
					$("#loginform_mail").first().focus();
					return;
				}
				if(typeof returndata.isloggedin != "undefined") {
					if(returndata.isloggedin == true) {
						window.location = "/";
					}
				}
				
			},
			error: function(xhr, status, error) {
				setupError("Er ging iets verkeerd met het inloggen");
			}
		});
	}
	return false;
});
$(".form-control").focus(function() {
	$(this).parent().tooltip("destroy");
});
function setupError(text) {
	$("#errortext").text(text);
	$("#error").removeClass("hidden");
	$(".close").click(function() {
		$("#error").addClass("hidden");
	});
}
</script>