# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	#$('#answer-summary-table').dataTable()
	jQuery(document).ready ->
		jQuery("a#nextquizquestion").click ->
			ansUrl=jQuery("form#ans-save-form").attr("action")
			ans=jQuery("select[name='ans_choice']").val()
			qid=jQuery("input#qidinput").val()
			time=parseInt(jQuery("input#timerminute").val())*60+parseInt(jQuery("input#timersecond").val())
			jQuery.ajax({type:"POST", url: ansUrl, data: {time: time, question_id: qid, ans_choice: ans}, dataType:"HTML"}).success ->
			