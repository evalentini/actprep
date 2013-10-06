
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
			//window.location.replace(window.location.href);
		});
		window.location.replace(window.location.href);
	});
	
	$('button.editUser').click(function(){
		//add code
		//get the row
		row=$(this).parent().parent();
		row_id=row.attr('userid');
		email=row.children('td.user-mod-email');
		email.html("<input type='text' id='user-mod-email' name='user-mod-email' value='"+email.text()+"'>");
		
		username=row.children('td.user-mod-username')
		username.html("<input type='text' id='user-mod-username' name='user-mod-username' value='"+username.text()+"'>");
		
		role=row.children('td.user-mod-role');
		var current_role=role.text();
		var role_html="<select id='user-mod-role' name='user-mod-role'>";
			
			//set the student option
			role_html=role_html+" <option value='student'";
			if (current_role=="student") {
				role_html=role_html+" selected='selected'";
			} 
			role_html=role_html+">student</option>";

			//set the administrator option
			role_html=role_html+" <option value='admin'";
			if (current_role=="admin") {
				role_html=role_html+" selected='selected'";
			} 
			role_html=role_html+">admin</option>";
		
			role_html=role_html+" </select>";
		role.html(role_html);
		
		//set a temporary password
		temppass=row.children('td.user-mod-temppass');
		
		//run ajax to get new temporary password 
		$.ajax({
			type:"GET",
			url:"/users/temppass.json",
			dataType:"JSON",
			data:
			{
				user_id:row_id
			}
		}).done(function(data){
			temppass.html("<input id='user-mod-pwd' type='text' disabled='disabled' value='"+data.pwd+"'>");
	    });
		
		//change edit user button to save
		$(this).parent().prepend(" <button class='btn btn-primary btn-mini saveUser'>save</button>");
		$(this).parent().prepend(" <button class='btn btn-primary btn-mini cancelUserEdit'>cancel</button>");
		$(this).remove();
		$('button#add-user-button').remove();
		
	});
	
	$('button#dismiss-alert').click(function(){
		$('div#alert-row').addClass("hidden");
	});
	
	//if the cancel button is clicked just reload the page
	
	$(document).on("click", "button.cancelUserEdit", function(){
		window.location.replace(window.location.href);
	});
	
	$(document).on("click", "button.saveUser", function(){
		$.ajax({
			type:"GET",
			url:"/users/edituser.json",
			dataType:"JSON",
			data:
			{
				id: $(this).parent().parent().attr('userid'),
				email: $('input#user-mod-email').val(),
				username: $('input#user-mod-username').val(),
				role: $('select#user-mod-role').val(),
				pwd: $('input#user-mod-pwd').val()
			}
		}).done(function(data){
			window.location.replace(window.location.href);
		});
	});
	
});