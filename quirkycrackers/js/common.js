function QuicksetupAccount(pid){
		 var user_sk = $("#user_sk").val();
		 var password = $("#password_"+pid).val();
		 
		 if($.trim(password.length<=4)){
				$("#alertmsg").append("<br>No complications, but password must be at least 4 characters long.");
				$("#emailalert_"+pid).empty();
				$("#emailalert_"+pid).append("<br>No complications, but password must be at least 4 characters long.");
				return;
			}
		 
		 $.ajax({
			type: 'GET',
			    url: '/quirkycrackers/cmp.cfc?method=setupAccount&user_sk='+user_sk+'&password='+password,
		    beforeSend : function(a){
		    				$("#passwordbox_"+pid).empty();
		    			 },
		    complete : function(results){
						},
			success : function(results){
						if(results.ERROR == 1){
							$("#passwordbox_"+pid).empty();
							$("#passwordbox_"+pid).append("We apologies! Please try again! :(");
						}
						else{
							$("#passwordbox_"+pid).empty();
							$("#passwordbox_"+pid).append("Thanks for setting up account! An email is sent to your email id. <br>Don't forget to check your SPAM folder and mark email as NO Sapm!");
						}
					  },
			error : function(){
				console.log("ERROR");
				$("#emailalert_"+pid).empty();
				$("#emailalert_"+pid).append("We apologies! Please try again! :(");
			}
		});
}

function sendIssue(user_sk){
	
	$.ajax({
	type: 'GET',
    url: '/quirkycrackers/cmp.cfc?method=addIssue&user_sk='+user_sk+'&issue='+$("#issue").val(),
    beforeSend : function(a){
    	$( "#issuealert" ).empty();
    	$( "#issuealert" ).append("Thanks for reporting issue!")
    			 },
    complete : function(results){
    		$( "#reportissue" ).slideUp( "slow",function(){
    			$( "#issuealert" ).empty();
    		});
    	}
	});
	
}

function dropMenuItems() {
    if($( "#allDropsOptions" ).is(':visible')){
    	$( "#allDropsOptions" ).slideUp( "fast");
    }
    else{
    	 $( "#allDropsOptions" ).slideDown( "fast");
    }
	 
};

function subscribe_user(email){
  	if(isValidEmailAddress(email)){
  		$.ajax({
		    type: 'GET',
		    url: '/quirkycrackers/users/?subscribe='+email,
		    success: function(res){
		    	$("#subscribe").attr("placeholder","Thank you!");
  				$("#subscribe").val("");
		    }
		});
  	}
  	else{
  		$("#subscribe").attr("placeholder",email+" Doesn't Look valid mail");
  		$("#subscribe").val("");
  		//qc_msg('Please enter valid email address.')
  	}
  }
  
  function login(){
    try{closeFooter();}catch(e){}
  	FB.login(function(response) {
  		//console.log(response);
	   if (response.authResponse) {
	     FB.api('/me?fields=email,first_name,last_name', function(response) {
	     	//console.log("Inner response");
	     	//console.log(response);
	     	if(typeof response == "object" && 'email' in response){
	     		register(response);
	     	}
	     	else {
		     	var s = '<div class="runtimealert" style="border:1px solid black;color:white;background-color:blue;z-index:501;position:fixed;min-width:300px;min-height:200px;max-width:600px;max-height:400px;top:10;left:10;">';
		     	s += '<ul>';
		     	s += '<li>There is some problem in Registering you.</li>';
		     	s += '<li>Email is needed to keep you updated.</li>';
		     	s += '<li>Please try again.</li>';
		     	s += '<li style="cursor: pointer; cursor: hand;" onclick="$('+"'"+'.runtimealert'+"'"+').hide();">Close.</li>';
		     	s += '</ul>';
		     	s += '<script>$(".runtimealert").css({"top":(window.innerHeight-$(".runtimealert").height())/2,"left":(window.innerWidth-$(".runtimealert").width())/2,});</script>';
		     	s += '</div>';
	
		     	$("body").append(s);
		     	FB.api('/me/permissions', 'delete', function(response) {
				    console.log(response); // true
				});
	     	}
	     	 
	     });
	   } else {
	     //console.log('User cancelled login or did not fully authorize.');
	   }
	 },{scope: 'email',return_scopes: true});
  }
  
  function register(fbRes){
	
	var email = '';
	var password = '';
	var isEmailOk = '';
	var isPasswordOk = '' ;
	var fb_id = '' ;
	var fb_resObj = '' ;
	
	if(typeof fbRes == 'object'){
		fb_resObj = JSON.stringify(fbRes);
		fb_id = fbRes.id;
		email = fbRes.email;
		$.ajax({
		    type: 'POST',
		    url: '/quirkycrackers/users/',
		    data: { 
		        'email': email, 
		        'password': 'fbpass',
		        'fb_id':fb_id,
		        'fb_resObj':fb_resObj,
		        'couponCode':'0',
		        'register':'1'
		    },
		    success: function(res){
		    	res = $.parseJSON(res);
		    	$("#login_alert").empty();
		    	if(res.LOGUSER == false){
		    		$("#login_alert").append(res.MSG);
			    		if(res.EXISTS == true){
			    			$("#login_alert").append('<a href="javascript:void(0);"><div onclick="resetPassword();">Click here to recieve your password in email</div>');
			    		}
		    	}
		    	else{
		    		if(typeof res == "object" && 'PASSHASH' in res && res.PASSHASH.length > 0 ){
		    			window.location="/quirkycrackers/";
		    		}
		    		else{
		    			window.location="/quirkycrackers/login/?email="+email+"&msgcode=0&msg='Thanks for Registering.<br>You can set your password to experience various personalized Features.'";
		    		}
		    			
		    	}
		    }
		});
	}
	/*else{
		
		email = document.getElementById("regis_email").value;
		password = document.getElementById("password").value;
		isEmailOk = isValidEmailAddress(email);
		isPasswordOk = password.length ;
		
		if(isEmailOk == false || isPasswordOk <7 ){
			$("#login_alert").append("Please provide valid email and 6+ long password");
			return;
		}
		
	}*/
	
 }
 
 function logout(){
 	window.location="/quirkycrackers/logout/";
 }