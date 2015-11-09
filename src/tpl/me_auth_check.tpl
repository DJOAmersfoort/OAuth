<div class="page-header">
	<h1>
		<span id="pagetitle">{{{title}}}</span>
		<small>
			{{{subtitle}}}
		</small>
	</h1>
</div>
<div class="col-md-6 col-sm-8 col-xs-10 col-md-offset-3 col-sm-offset-2 col-xs-offset-1">

	<div class="panel panel-success">
		<div class="panel-body">
			<div class="media">
				<div class="pull-left">
					<h1 style="color: rgb(174, 255, 158); margin: 0;"><b>4&nbsp;&nbsp;&nbsp;</b></h1>
				</div>
				<div class="media-body">
					<p>
						De authenticator app geeft nu elke 30 seconden en nieuwe code aan, vul deze code hieronder in voordat de code verloopt.<br /><br />
						2-staps authenticatie wordt dan aangezet, en is ook alleen via 2-staps authenticatie weer uit te schakelen.<br /><br />
						Met 2-staps authenticatie aan wordt op een onbekende computer of bij het lang ingelogd zijn eerst de code gevraagd.
					</p>
					<br />
					<form role="form" id="2stepcheckform" action="javascript:void(0);" method="post">
						<div class="row">
							<div class="col-lg-10 col-lg-offset-1">
								<div class="form-group">
									<input data-required="de code" autofocus type="text" class="form-control" id="2stepauth_code" name="code" value="" placeholder="Code">
								</div>
								<div class="form-group">
									<button type="submit" class="btn btn-success">Activeren</button>
								</div>
							</div>
						</div>
						<input type="hidden" name="type" id="type" value="2fa_check">
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	$("#2stepcheckform").submit(function() {
		if($(".tooltip").length === 0) {
			var postData = $(this).serializeArray();
			$(".form-control").prop("disabled", true);
			$.ajax({
				type: "POST",
				url: "/data",
				data: postData,
				success: function(data) {
					var returndata = JSON.parse(data);

					if (typeof returndata.error != "undefined") {
						$(".form-control").prop("disabled", false);
						$("#2stepauth_code").first().focus();
						setupError(returndata.error);
						return;
					}
					if (typeof returndata.success !== "undefined") {
						window.location = "/me";
						return;
					}
					$(".form-control").prop("disabled", false);
				},
				error: function(xhr, status, error) {
					setupError("Er ging iets verkeerd.");
				}
			});
		}
		return false;
	});
	function setupError(error) {
		$("#2stepauth_code").parent().tooltip({"trigger":"", "title": error, "placement": "bottom"}).tooltip("show");
	}
	$("#2stepauth_code").focus(function() {
		$(this).parent().tooltip("destroy");
	});
</script>
