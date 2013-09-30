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
});