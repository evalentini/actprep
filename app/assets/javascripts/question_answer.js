function pullQuestions() {
	//pull right question list as soon as dom loaded
	$('select#question-answer-question').html('');
	$.ajax({
		type:"GET",
		url:"/questions/list.json",
		dataType:"JSON",
		data:
		{
			test: $('select#question-answer-test-number').val(),
			section: $('select#question-answer-section').val()
		}
	}).done(function(data){
		for (i=0; i<data.length; i++) {
			$("select#question-answer-question").append("<option value="+data[i].question_number+">"+data[i].question_number+"</option>");
		}
    });	
}


$("document").ready(function(){
	$('select#question-answer-section, select#question-answer-test-number').change(function(){
		pullQuestions();
	})
});