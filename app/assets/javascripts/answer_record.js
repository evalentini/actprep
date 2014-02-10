$('document').ready(function(){

	//alert every 3 seconds
	//setInterval(function(){alert("Hello")},3000);
	
	//added comment 
	
	
	setInterval(function(){
		if ($('input#minutes').length) {
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
			//$('div#timer').text(minutes+":"+textSeconds);
			$('input#timerminute').val(minutes);
			$('input#timersecond').val(textSeconds);
			$('input#minutes').val(minutes);
			$('input#seconds').val(seconds);
			
			//change color of second and minute input as appropriate
			var currentSection=$('input#currentquestionsection').val();
			var elapsedSeconds=minutes*60+seconds;
			if (currentSection=="english") {
				if(elapsedSeconds<80) {
					$('input#timerminute, input#timersecond').attr("class", "greentime");
				}
				else {
					if(elapsedSeconds<100) {
						$('input#timerminute, input#timersecond').attr("class", "yellowtime");
					}
					else {
						$('input#timerminute, input#timersecond ').attr("class", "redtime");
					}
				}
			}
			
			if (currentSection=="science") {
				if(elapsedSeconds<55) {
					$('input#timerminute, input#timersecond').attr("class", "greentime");
				}
				else {
					if(elapsedSeconds<68) {
						$('input#timerminute, input#timersecond').attr("class", "yellowtime");
					}
					else {
						$('input#timerminute, input#timersecond ').attr("class", "redtime");
					}
				}
			}
			
			if (currentSection=="math") {
				if(elapsedSeconds<48) {
					$('input#timerminute, input#timersecond').attr("class", "greentime");
				}
				else {
					if(elapsedSeconds<60) {
						$('input#timerminute, input#timersecond').attr("class", "yellowtime");
					}
					else {
						$('input#timerminute, input#timersecond ').attr("class", "redtime");
					}
				}
			}
			
			if (currentSection=="reading") {
				if(elapsedSeconds<42) {
					$('input#timerminute, input#timersecond').attr("class", "greentime");
				}
				else {
					if(elapsedSeconds<52) {
						$('input#timerminute, input#timersecond').attr("class", "yellowtime");
					}
					else {
						$('input#timerminute, input#timersecond ').attr("class", "redtime");
					}
				}
			}
			
		}
	},1000);
	
	$('button#prev-page, button#next-page').click(function(){
		
		var src = $('img#q-img').attr("src");
		var section = (/[a-z]+/.exec(/[a-z]+_/.exec(src)));
		var page = parseInt((/[0-9]+/.exec(/pg[0-9]+/.exec(src))));
		if ($(this).attr("id")=="prev-page") {
			if (page>1) {
				page=page-1;				
			}
		}
		else {
			maxpage=$("input#maxpage-"+section).val();
			if (page<$("input#maxpage").val()){
				page=page+1;
			}
		}
		
		$('img#q-img').attr("src", "/assets/"+section+"_pg"+page+".jpg");
		$('img#q-img').attr("alt", section+"page "+page);
		
	});
});