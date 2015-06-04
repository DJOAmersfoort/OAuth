<script src="//oauth.djoamersfoort.nl/js/site.js"></script>
<form role="form" action="/data" data-type="testForm" method="post">

	<input type="hidden" name="type" value="testForm" />

	<div id="form-elements">
		<div class="form-group">
			<label for="register_mail">E-mailadres <span style="color: #F00">*</span></label>
			<input data-required="een email-adres" autofocus type="email" class="form-control" id="register_mail" name="email" value="" placeholder="mijnnaam@waarschijnlijkeendomeinmaarnietgmailofoutlook.nl">
		</div>
		<div class="row">
		  <div class="col-sm-4">
				<div class="form-group">
					<label for="register_voornaam">Voornaam <span style="color: #F00">*</span></label>
					<input data-required="een naam" type="text" class="form-control" id="register_voornaam" name="voornaam" value="" placeholder="Piet">
				</div>
			</div>
			<div class="col-sm-4">
				<div class="form-group">
					<label for="register_tussenvoegsel">Tussenvoegsel</label>
					<input
					type="text" class="form-control" id="register_tussenvoegsel" name="tussenvoegsel" value="" placeholder="de">
				</div>
			</div>
		  <div class="col-sm-4">
				<div class="form-group">
				  <label for="register_achternaam">Achternaam <span style="color: #F00">*</span></label>
				  <input type="text" class="form-control" data-required="een achternaam" id="register_achternaam" name="achternaam" value="" placeholder="Jong">
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
				<label for="register_mobile">Mobiele nummer</label>
				<input type="tel" class="form-control" id="register_mobile" name="mobile" value="" placeholder="06-56200969">
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
	</div>
	<button data-addfield="address" type="button" class="btn btn-default"><span class="glyphicon glyphicon-plus-sign"></span> Adres toevoegen</button>
	<br />
	<br />
	<button type="submit" class="btn btn-success">Aanmelden</button>
</form>