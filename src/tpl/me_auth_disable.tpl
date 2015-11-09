<div class="page-header">
	<h1>
		<span id="pagetitle">{{{title}}}</span>
		<small>
			{{{subtitle}}}
		</small>
	</h1>
</div>
<div class="col-md-6 col-sm-8 col-xs-10 col-md-offset-3 col-sm-offset-2 col-xs-offset-1">

	<div class="panel panel-danger">
		<div class="panel-body">
			<p>
				2-staps authenticatie zorg er voor dat op een onbekende computer of bij het lang ingelogd zijn eerst de code wordt gevraagd, als je dit uitschakeld is je account meer vatbaar voor bijvoorbeeld hackers.<br /><br />
				Vul de authenticatie code in als je zeker weet dat je 2-staps authenticatie wilt uit schakelen.
			</p>
			<br />
			<form role="form" id="2stepcheckform" action="javascript:void(0);" method="post">
				<div class="row">
					<div class="col-lg-10 col-lg-offset-1">
						<div class="form-group">
							<input data-required="de code" autofocus type="text" class="form-control" id="2stepauth_code" name="code" value="" placeholder="Code">
						</div>
						<button type="submit" class="btn btn-danger">Uitschakelen</button>
					</div>
				</div>
				<input type="hidden" name="type" id="type" value="2fa_disable">
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
	$("#2stepcheckform").submit(function() {
		$("#2stepauth_code").parent().tooltip("destroy");
		var postData = $(this).serializeArray();
		$(".form-control").prop("disabled", true);
		$.ajax({
			type: "POST",
			url: "/data",
			data: postData,
			success: function(data) {
				var returndata = JSON.parse(data);
				if (typeof returndata.error !== "undefined") {
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
		return false;
	});
	function setupError(error) {
		$("#2stepauth_code").parent().tooltip({"trigger":"", "title": error, "placement": "bottom"}).tooltip("show");
	}
	$("#2stepauth_code").keypress(function() {
		$(this).parent().tooltip("destroy");
	});
</script>
