$("document").ready(function(){
	//pull right question list as soon as dom loaded
	$('select#question').html('');
	$.ajax({
		type:"GET",
		url:"/questions/list.json",
		dataType:"JSON",
		data:
		{
			test: $('select#test-number').val(),
			section: $('select#section').val()
		}
	}).done(function(data){
		for (i=0; i<data.length; i++) {
			$("select#question").append("<option value="+data[i].question_number+">"+data[i].question_number+"</option>");
		}
    });

});