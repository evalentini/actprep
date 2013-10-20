
$("document").ready(function(){
	
//convert textarea to nicedit instance

var buttonOptions={'buttonList':
								[
									'bold', 'italic', 'underline',
									'left','center','right', 'subscript', 'superscript',
									'strikethrough', 'indent', 'outdent', 'fontSize'
								]
					
				   };

new nicEditor(buttonOptions).panelInstance('edit-exp-area');
//nicEditors.findEditor('edit-exp-area');

$("button#save-new-question-button").click(function(){
	
	$.ajax({
		type:"GET",
		url:"/questions/add.json",
		dataType:"JSON",
		data:
		{
			test: $('select#testnumber').val(),
			section: $('select#section').val(),
			page: $('select#pagenumber').val(),
			choice1: $('select#choice1').val().split(/ /)[0],
			num_choice: $('select#choice1').val().split(/ /).length,
	        correct_answer: $('select#correctanswer').val(),
			question_number: $('input#questionnumber').val()
		}
	}).done(function(data){
		window.location.replace(window.location.href.replace(/#/g, ''));
	    });
	
});

$('button#reveal-new-question-button').click(function(){
	$('tr#new-question-row').removeClass('hidden');
	$('button.editQuestion').remove();

	$("tbody tr[questionid!='new']").addClass("hidden");

	$(this).remove();
	
	
	//hide all other rows 
	
});

$('button#cancel-new-question').click(function(){
	window.location.replace(window.location.href.replace(/#/g, ''));
});

$('button.editQuestion').click(function(){
	var row=$(this).parent().parent();
	var row_id=row.attr('questionid');
	$("span.editmode-"+row_id).removeClass("hidden");
	$("span.viewmode-"+row_id).addClass("hidden");
	
	$(this).parent().prepend(" <button qid="+row_id+" class='btn btn-primary btn-mini saveQuestion'>save</button>");
	$(this).parent().prepend(" <button class='btn btn-primary btn-mini cancelQuestionEdit'>cancel</button>");
	$(this).remove();
	$('button#reveal-new-question-button').remove();
	
	//hide all other rows 
	$("tbody tr[questionid!='"+row_id+"']").addClass("hidden");
	
});	

$(document).on("click", "button.saveQuestion", function(){
	var row=$(this).parent().parent();
	var row_id=row.attr('questionid');
	var qidCondition="[qid='"+row_id+"']"
	$.ajax({
		type:"GET",
		url:"/questions/edit.json",
		dataType:"JSON",
		data:
		{
			id: row_id,
			page: $("select[fieldtype='page']"+qidCondition).val(),
			choice1: $("select[fieldtype='answerchoices']"+qidCondition).val().split(/ /)[0],
			num_choice: $("select[fieldtype='answerchoices']"+qidCondition).val().split(/ /).length,
	        correct_answer: $("select[fieldtype='correctanswer']"+qidCondition).val()
		}
	}).done(function(data){
		window.location.replace(window.location.href.replace(/#/g, ''));
	    });
	
});

//save test

$(document).on("click", "button.cancelQuestionEdit", function(){
	window.location.replace(window.location.href.replace(/#/g, ''));
});

$(document).on("click", "button.deleteQuestion", function(){
	
	$.ajax({
		type:"GET",
		url:"/questions/delete.json",
		dataType:"JSON",
		data:
		{
			id: $(this).parent().parent().attr("questionid")
		}
	}).done(function(data){
		window.location.replace(window.location.href.replace(/#/g, ''));
	});
});

	
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
	var options=$(this).val();
	var optionList=options.split(/ /);


	
//	var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
//	var startChar = $(this).val();
//	$('div#choice-2-span').text("Choice 2=>"+alphabet.substr(alphabet.indexOf($(this).val())+1,1));
//	$('div#choice-3-span').text("3=>"+alphabet.substr(alphabet.indexOf($(this).val())+2,1));
//	$('div#choice-4-span').text("4=>"+alphabet.substr(alphabet.indexOf($(this).val())+3,1));
//	//reset list of options for correct answer

	$('select#correctanswer').html('');
	for(i=1; i<=optionList.length; i++) {
		$('select#correctanswer').append("<option value="+i+">"+optionList[i-1]+"</option>");
	}
});

$("select[fieldtype='answerchoices']").change(function(){
	var id=$(this).attr("qid");
	var options=$(this).val();
	var optionList=options.split(/ /);
	
	$("select[fieldtype='correctanswer'][qid='"+id+"']").html("");
	for(i=0; i<optionList.length; i++) {
		$("select[fieldtype='correctanswer'][qid='"+id+"']").append("<option value="+i+">"+optionList[i]+"</option>");
	}
});

//code to open a new browser window with question page when user clicks view page 

$('button#view-page-button').click(function(){
	
	var isVisible = true;
	if ($('div#modify-page-image-row').hasClass("hidden")) {
		isVisible=false;
	}
	if (isVisible==false) {
		
		var section = $('select#section').val();
		var page = $('select#pagenumber').val();
		
		$('img#q-mod-img').attr("src", "/assets/"+section+"_pg"+page+".jpg");
		$('img#q-mod-img').attr("alt", section+"page "+page);
		
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
	var section = $('select#section').val();
	var page = parseInt((/[0-9]+/.exec(/pg[0-9]+/.exec(src))));
	if ($(this).attr("id")=="modify-image-prev-page") {
		if (page>1) {
			page=page-1;
		}
	}
	else {
		maxpage=$("input#maxpage-"+section).val();
		if (page<maxpage) {
			page=page+1;			
		}
	}
	//set the selected page option to the current page
	$('select#pagenumber').val(page);
	
	$('img#q-mod-img').attr("src", "/assets/"+section+"_pg"+page+".jpg");
	$('img#q-mod-img').attr("alt", section+"page "+page);
});


$('button.viewpagebtn').click(function(){
	$('button#modify-exst-image-prev-page').attr('qid', $(this).attr('qid'));
	$('button#modify-exst-image-next-page').attr('qid', $(this).attr('qid'));
	
	
	var isVisible = true;
	if ($('div#modify-existing-page-image-row').hasClass("hidden")) {
		isVisible=false;
	}
	if (isVisible==false) {
		$(this).text("Hide Page");	
		$('div#modify-existing-page-image-row').removeClass("hidden");		
	}
	else {
		$(this).text("View Page");
		$('div#modify-existing-page-image-row').addClass("hidden");
	}
				
	var currentRow=$("tr[questionid='"+$(this).attr("qid")+"']")
	var currentSection=currentRow.attr("secname");
	var currentPage=currentRow.attr("pgnum");
	
	$('img#q-mod-exst-img').attr("src", "/assets/"+currentSection+"_pg"+currentPage+".jpg");
});

$('button#modify-exst-image-prev-page, button#modify-exst-image-next-page').click(function(){
	var src = $('img#q-mod-exst-img').attr("src");
	var section = (/[a-z]+/.exec(/[a-z]+_/.exec(src)));
	var page = parseInt((/[0-9]+/.exec(/pg[0-9]+/.exec(src))));
	if ($(this).attr("id")=="modify-exst-image-prev-page") {
		if (page>1) {
			page=page-1;
		}
	}
	else {
		maxpage=$("input#maxpage-"+section).val();
		if (page<maxpage) {
			page=page+1;			
		}
	}
	//set the selected page option to the current page
	$("select[fieldtype='page']").val(page);
	
	$('img#q-mod-exst-img').attr("src", "/assets/"+section+"_pg"+page+".jpg");
	$('img#q-mod-exst-img').attr("alt", section+"page "+page);
});


$('a.mod-view-page-link').click(function(){
	window.open("viewimage/"+$(this).attr("linksection")+"/"+$(this).attr("linkpage"), 
				"_blank", "menubar=yes, fullscreen=yes, scrollbars=1,resizable=1,height=1500,width=1100");
	
});

$('a.view-explanation-link').click(function(){
	window.open("explanation/"+$(this).attr("questionid"), "_blank", "menubar=yes, fullscreen=yes, scrollbars=1,resizable=1,height=1500,width=1100");
	
});

});	

