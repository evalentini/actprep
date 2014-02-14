# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	
	jQuery(document).ready ->
		
		elements=["#confirmpassword", "#password", "#lastname", "#firstname", "#email"]
		enames={}
		enames["#confirmpassword"]= "Password Confirmation"
		enames["#password"]= "Password"
		enames["#lastname"]= "Last Name"
		enames["#firstname"]= "First Name"
		enames["#email"]= "Email"
		
		emailPattern = /// ^ #begin of line
		([\w.-]+) #one or more letters, numbers, _ . or -
		@ #followed by an @ sign
		([\w.-]+) #then one or more letters, numbers, _ . or -
		\. #followed by a period
		([a-zA-Z.]{2,6}) #followed by 2 to 6 letters or periods
		$ ///i #end of line and ignore case
		
		jQuery("#email, #firstname, #lastname, #password").change ->
				jQuery("#signup").removeClass("btn-danger")
				jQuery("#signup").removeClass("btn-success")
				jQuery("#signup").removeAttr("disabled")
				jQuery("#signup").addClass("btn-success")
				jQuery('#signup').text("Sign Up")
				error=false
				etext=""
				#check whether passwords match 
				if jQuery("#password").val()!=jQuery("#confirmpassword").val()
					error=true
					etext="Passwords Dont Match"
					
				#check whether everything was entered

				etext = "Enter #{enames[element]} " for element in elements when jQuery("#{element}").val()==""
				error=true for element in elements when jQuery("#{element}").val()==""
				
				#check whether email is valid	
				unless jQuery("#email").val().match emailPattern
					error=true
					etext="Invalid Email"
				
				if error==true
					jQuery("#signup").addClass("btn-danger")
					jQuery("#signup").attr("disabled", "disabled")
					jQuery("#signup").text(etext)
					
			jQuery("#confirmpassword").keyup ->
				jQuery("#signup").removeClass("btn-danger")
				jQuery("#signup").removeClass("btn-success")
				jQuery("#signup").removeAttr("disabled")
				jQuery("#signup").addClass("btn-success")
				jQuery('#signup').text("Sign Up")
				error=false
				etext=""
				#check whether passwords match 
				if jQuery("#password").val()!=jQuery("#confirmpassword").val()
					error=true
					etext="Passwords Dont Match"
					
				#check whether everything was entered

				etext = "Enter #{enames[element]} " for element in elements when jQuery("#{element}").val()==""
				error=true for element in elements when jQuery("#{element}").val()==""
				
				#check whether email is valid	
				unless jQuery("#email").val().match emailPattern
					error=true
					etext="Invalid Email"
				
				if error==true
					jQuery("#signup").addClass("btn-danger")
					jQuery("#signup").attr("disabled", "disabled")
					jQuery("#signup").text(etext)
		