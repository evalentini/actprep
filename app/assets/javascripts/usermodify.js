
//create a random 10 character password


$('document').ready(function(){
	
	$('button#add-user-button').click(function(){
		$('tr#new-user-row').removeClass("hidden");
	});
	
	$('button#save-new-user').click(function(){
		//send ajax request to save new user
		$.ajax({
			type:"GET", 
			url:"/users/save.json",
			dataType:"JSON",
			data: 
				{
					email: $('input#new-user-email').val(),
					role: $('select#new-user-role').val(),
					username: $('input#new-user-username').val(),
					password: $('input#new-user-temppass').val()
				}
			
		}).done(function(data){
			//reload the page to get the new record 
			window.location.replace(window.location.href);
		});
	});
	
	$('button#cancel-new-user').click(function(){
		$('tr#new-user-row').addClass("hidden");
	});
	
	$('button.deleteUser').click(function(){
		var elementToDelete=($(this).parent().parent().attr("userid"));
		$.ajax({
			type:"GET",
			url:"/users/delete.json",
			dataType:"JSON",
			data: 
				{
					id:elementToDelete
				}
		}).done(function(data){
			window.location.replace(window.location.href);
		});
	});
	
	$('button.editUser').click(function(){
		$('div#alert-row').removeClass("hidden");
		$('span#alert-text').text("editing users...coming soon");
	});
	
	$('button#dismiss-alert').click(function(){
		$('div#alert-row').addClass("hidden");
	});
	
});