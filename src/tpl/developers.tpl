<div class="row">
	<div class="col-md-8 col-sm-10 col-xs-12 col-md-offset-2 col-sm-offset-1">
    <div class="page-header">
      <h1>
        <span id="pagetitle">{{{title}}}</span>
        <small>
          {{{subtitle}}}
        </small>
      </h1>
    </div>
		<div class="well">
			<h4><b>OAuth gegevens</b></h4>
			<br />
			<p>
		   	 	<b>Api: </b>https:{url}/api/v1 <span class="label label-success">Online</span><br />
			</p>
			<p>
				<b>Authorisatie: </b>https:{url}/api/OAuth/authorize <span class="label label-success">Online</span><br />
			</p>
			<p>
		   	 	<b>Toegangs token: </b>https:{url}/api/OAuth/access_token <span class="label label-success">Online</span><br />
			</p>
			<p>
				<b>Versie: </b> OAuth 2.0
			</p>
		</div>
		<br />
        <h1><b>OAuth 2.0</b></h1>
        <h2><b>Hoe het werkt.</b></h2>
		<center><img src="{url}/static/img/oauth2flow.png" alt="De OAuth 2.0 workflow" class="img-responsive"/></center>
		<small>Cheat sheet! Weet je het even niet meer? Dan komt dit misschien van pas.</small>
		<h3>Stap 1</h3>
		<p>De app stuurt de gebruiker naar ons door, daar als de gebruiker er voor het eerst komt wachten we eerst tot de gebruiker toestemming geeft voor de app.</p>
		<h3>Stap 2</h3>
		<p>Je krijgt als alles goed gaat een 'Authorization token' van onze servers terug.</p>
		<h3>Stap 3</h3>
		<p>Je stuurt de authorization code samen met je client secret terug naar ons.</p>
		<h3>Stap 4</h3>
		<p>Wij controleren alles en sturen een Access token en een Refresh token terug, met de Refresh token kun je een nieuwe access token aanvragen als deze is verlopen.</p>
		<h3>Stap 5</h3>
		<p>Je kunt nu met de Access token de gegevens van de gebruiker bekijken.</p><br />
		<h2><b>Zelf gebruiken</b></h2>
		<p>OAuth 2 is veel versimpeld en daardoor makkelijk te implementeren in jouw website, beveiliging is alleen een groot probleem en je als je een eigen library maakt is er een grote kans dat error niet goed worden behandeld.</p><p>We raden daarom ook aan om een open-source library te gebruiken, deze worden altijd geupdate en zijn makkelijk te gebruiken</p>
		<p>
			Hier een lijstje met open-source OAuth library's voor php<br /><br />
			<a class="btn btn-link" href="https://github.com/Lusitanian/PHPoAuthLib">PHPoAuthLib</a><br />
			<a class="btn btn-link" href="https://code.google.com/p/google-api-php-client/wiki/OAuth2">Google OAuth lib</a>
		</p>
		<p>
			Hier een lijstje met open-source OAuth library's voor Node.JS<br /><br />
			<a class="btn btn-link" href="https://github.com/ciaranj/node-oauth">Node-OAuth</a><br />
			<a class="btn btn-link" href="https://github.com/jaredhanson/oauth2orize">OAuth2orize</a>
		</p>
		<p>Je hoeft hier alleen je client_id en client_secret in te vullen en de documentatie te volgen </p>
		<h2><b>App registreren</b></h2>
		<p>
			Voordat je dit nutteloze systeem kan gebruiken moet je eerst je website/app registreren<br /><br />
			<a class="btn btn-link" href="https://oauth.djoamersfoort.nl/appregister">App registreren</a><br />
		</p>
		<hr size="3">
		<h1><b>De API</b></h1>
		<pre>
{
	"users" : [
		{
			"displayName" : "Piet de Jong",
			"name" : {
				"givenName" : "Piet",
				"insertionName" : "de",
				"familyName" : "Jong"
			},
			"addresses" : [
				{
					"street" : "Amersfoortseweg 55"
					"postalcode" : "3817BB"
					"town" : "Amersfoort"
				}
			],
			"isDjoMember" : true,
			"id" : "33@oauth.djoamersfoort.nl",
			"email" : "email@example.com",
		}
	]
}
		</pre>
		<small class="pull-right">Een voorbeeld antwoord van de v1 API</small>
	</div>
</div>
