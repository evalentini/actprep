$("document").ready(function(){
$("button#addquestion").click(function(){
	$.ajax({
		type:"GET",
		url:"/questions/add.json",
		dataType:"JSON",
		data:
		{
			test: $('select#testnumber').val(),
			section: $('select#section').val(),
			page: $('select#pagenumber').val(),
			choice1: $('select#choice1').val(),
			choice2: $('select#choice2').val(),
			choice3: $('select#choice3').val(),
			choice4: $('select#choice4').val(),
            correct_answer: $('select#correctanswer').val(),
			question_number: $('select#questionnumber').val()
		}
	}).done(function(data){
		$("table#questionlist").html("");
		$("table#questionlist").append("<tr><td>1</td><td>2</td></tr>");
		data.each 
    });
});
});	

