

$(document).ready(function(){
	$('#toggle-breakdown-button').click(function(){
		if ($('#answer-breakdown-header-row').hasClass("hidden")) {
			$('#answer-breakdown-header-row').removeClass("hidden");
			$('#answer-breakdown-content-row').removeClass("hidden");
			$(this).text("Hide Answer Summary");
		}
		else {
			$('#answer-breakdown-header-row').addClass("hidden");
			$('#answer-breakdown-content-row').addClass("hidden");
			$(this).text("Show Answer Summary");	
		}
	});
});
