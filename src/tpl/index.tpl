{{#userHasJustLoggedOut}}
<div class="alert alert-success" style="width: 200px;">
	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	<strong>Uitgelogd</strong>
</div>
{{/userHasJustLoggedOut}}
<p>Uit onderzoek blijkt dat men op de De Jonge Onderzoekers Amersfoort niet zo gediend is van het de OAuth systemen van de services &#8216;Google+&#8217; en &#8216;Outlook&#8217;.</p>
<p>Om dit uitermate belangrijke probleem op te lossen presenteren wij hier vol trots: DJO OAuth. Een compleet nutteloos systeem om een aantal nutteloze DJO'ers tevreden te stellen</p>
<p>Het systeem werkt simpel, je meldt je hier aan met je gegevens (admins kunnen je eventueel een DJO lid status geven) en gaat dan naar een DJO OAuth competabele website, daar klik je op inloggen. Je wordt dan eenmalig doorgestuurd terug naar ons om te bekijken wat de applicatie kan zien en om akkoord te gaan. Je bent nu ingelogd.</p>
<p>Voor programmeurs blijft het ook simpel, het systeem werkt geheel via de OAuth 2.0 spec. Voor meer informatie bekijk je developers pagina.</p>
<p>-Yoeri Otten</p>
{{#isNotLoggedIn}}
<br />
<br />
<div class="row">
	<div class="col-sm-6 col-sm-offset-3">
		<div class="well">
			<div class="row">
				<div class="col-sm-6">
					<a class="btn btn-danger btn-block btn-large" href="/login">Inloggen</a>
				</div>
				<div class="visible-xs"><br /></div>
				<div class="col-sm-6">
					<a class="btn btn-info btn-block btn-large" href="/aanmelden">Aanmelden</a>
				</div>
			</div>
		</div>
	</div>
</div>
{{/isNotLoggedIn}}
