
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
		$('input#modify-maxpage').val(data.current);
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
		$('select#correctanswer').append("<option value="+i+">"+alphabet.substr(alphabet.indexOf($(this).val())+(i-1),1)+"</option>");
		}
});

//code to open a new browser window with question page when user clicks view page 

$('button#view-page-button').click(function(){
	var isVisible = true;
	if ($('div#modify-page-image-row').hasClass("hidden")) {
		isVisible=false;
	}
	if (isVisible==false) {
		$(this).text("Hide Page");	
		$('div#modify-page-image-row').removeClass("hidden");		
	}
	else {
		$(this).text("View Page");
		$('div#modify-page-image-row').addClass("hidden");
	}
				
});

$('button#modify-image-prev-page, button#modify-image-next-page').click(function(){
	var src = $('img#q-mod-img').attr("src");
	var section = (/[a-z]+/.exec(/[a-z]+_/.exec(src)));
	var page = parseInt((/[0-9]+/.exec(/pg[0-9]+/.exec(src))));
	if ($(this).attr("id")=="modify-image-prev-page") {
		if (page>1) {
			page=page-1;
		}
	}
	else {
		maxpage=$('input#modify-maxpage').val();
		if (page<maxpage) {
			page=page+1;			
		}
	}
	//set the selected page option to the current page
	$('select#pagenumber').val(page);
	
	$('img#q-mod-img').attr("src", "/assets/"+section+"_pg"+page+".jpg");
	$('img#q-mod-img').attr("alt", section+"page "+page);
});

$('a.mod-view-page-link').click(function(){
	window.open("viewimage/"+$(this).attr("linksection")+"/"+$(this).attr("linkpage"), 
				"_blank", "menubar=yes, fullscreen=yes, scrollbars=1,resizable=1,height=1500,width=1100");
	
});

});	

