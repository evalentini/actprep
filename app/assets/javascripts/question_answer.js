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
		changeQuestionID(1);
    });	
}

function changeQuestionID(question) {
	//pull right question list as soon as dom loaded
	$.ajax({
		type:"GET",
		url:"/questions/findbyattributes.json",
		dataType:"JSON",
		data:
		{
			test: $('select#question-answer-test-number').val(),
			section: $('select#question-answer-section').val(),
			question: question
		}
	}).done(function(data){
		$("form#answer-q-form").attr("action","/answers/record/"+data.id)
    });	
}



$("document").ready(function(){
	$('select#question-answer-section, select#question-answer-test-number').change(function(){
		pullQuestions();
	});
	
	$('select#question-answer-question').change(function(){
		changeQuestionID($("select#question-answer-question").val());
	});
	
});