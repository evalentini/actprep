$('document').ready(function(){
	
	//alert every 3 seconds
	//setInterval(function(){alert("Hello")},3000);
	setInterval(function(){
		var minutes = parseInt($('input#minutes').val());
		var seconds = parseInt($('input#seconds').val());
		var textSeconds = "";
		if (seconds==59){
			seconds = 0;
			minutes = minutes + 1;
		}
		else {
			seconds = seconds + 1;
		}
		textSeconds=seconds;
		if (seconds<10) {
			textSeconds="0"+seconds;
		}
		$('div#timer').text(minutes+":"+textSeconds);
		$('input#minutes').val(minutes);
		$('input#seconds').val(seconds);
	},1000);
	
	$('button#prev-page, button#next-page').click(function(){
		
		var src = $('img#q-img').attr("src");
		var section = (/[a-z]+/.exec(/[a-z]+_/.exec(src)));
		var page = parseInt((/[0-9]+/.exec(/pg[0-9]+/.exec(src))));
		if ($(this).attr("id")=="prev-page") {
			page=page-1;
		}
		else {
			if (page<$("input#maxpage").val()){
				page=page+1;
			}
		}
		
		$('img#q-img').attr("src", "/assets/"+section+"_pg"+page+".jpg");
		$('img#q-img').attr("alt", section+"page "+page);
		
	});
});