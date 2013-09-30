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
			question_number: $('input#questionnumber').val()
		}
	}).done(function(data){
		window.location.replace(window.location.href);
    });
	
});
	
//save test
	
//code to change max/min question when section changes
$('select#section').change(function(){
	var sectionName = $(this).val();
	//alert($('input#maxquestion-hidden-input-'+sectionName).val());
	//delete all of the options for question #
	$('input#questionnumber').val(parseInt($('input#maxquestion-hidden-input-'+sectionName).val())+1);
	$('select#pagenumber').html('');
	//run ajax to get answer choice for other section
	$.ajax({
		type:"GET",
		url:"/questions/maxpage.json",
		dataType:"JSON",
		data:
		{
			test: $('select#testnumber').val(),
			section: $('select#section').val()
		}
	}).done(function(data){
		var maxpage=parseInt(data.current);
		for (i=1; i<=maxpage; i++){
			$('select#pagenumber').append("<option value="+i+">"+i+"</option>");
		}
    });
	
	
});

//code to change answer choice letters when first choice changes 
$('select#choice1').change(function(){
	var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	var startChar = $(this).val();
	$('div#choice-2-span').text("Choice 2=>"+alphabet.substr(alphabet.indexOf($(this).val())+1,1));
	$('div#choice-3-span').text("3=>"+alphabet.substr(alphabet.indexOf($(this).val())+2,1));
	$('div#choice-4-span').text("4=>"+alphabet.substr(alphabet.indexOf($(this).val())+3,1));
	//reset list of options for correct answer
	$('select#correctanswer').html('');
	for(i=1; i<5; i++) {
		//alert("<option value="+i+">"+alphabet.substr(alphabet.indexOf($(this).val())+(i-1),1)+"</option>")
		$('select#correctanswer').append("<option value="+i+">"+alphabet.substr(alphabet.indexOf($(this).val())+(i-1),1)+"</option>");
		}
});

//code to open a new browser window with question page when user clicks view page 

$('button#view-page-button').click(function(){
	window.open("viewimage/"+$('select#section').val()+"/"+$('select#pagenumber').val(), 
				"_blank", "menubar=yes, fullscreen=yes, scrollbars=1,resizable=1,height=1500,width=1100");
});

});	

