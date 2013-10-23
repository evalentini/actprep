# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery -> 
	jQuery(document).ready ->
		jQuery("#toggle-breakdown-button").click ->
			alert("running")
			if jQuery('#answer-breakdown-header-row').hasClass("hidden")
				jQuery('#answer-breakdown-header-row').removeClass("hidden")
				jQuery('#answer-breakdown-content-row').removeClass("hidden")
				jQuery(this).text("Hide Answer Summary")
			else
				jQuery('#answer-breakdown-header-row').addClass("hidden")
				jQuery('#answer-breakdown-content-row').addClass("hidden")
				jQuery(this).text("Show Answer Summary")
				