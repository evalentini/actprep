
addopt = (value) -> "<option value=#{value}>#{value}</option>"
	
jQuery ->
	
	jQuery(document).ready ->
		#store option values for newstudentselect
		semailoptions=[]
		jQuery("select#newstudentselect > option").each -> 
			semailoptions.push jQuery(this).attr("value")
	
		jQuery("input#newstudent").keyup ->
			
			#remove all email options 
			jQuery("select#newstudentselect").empty()
			#update list of email options
			part=jQuery("input#newstudent").val()
			#loop through each email
			optlist=""
			optlist += addopt(email) for email in semailoptions when email.substring(0,part.length)==part
			jQuery("select#newstudentselect").append(optlist)
		jQuery("button#sendfriendrequest").click -> 
			semail=jQuery("select#newstudentselect").val()
			jQuery.ajax({type:"POST", url: "/users/sendfriendrequest.json", data: {email: semail}, dataType:"HTML"}).success ->
				#do nothing
