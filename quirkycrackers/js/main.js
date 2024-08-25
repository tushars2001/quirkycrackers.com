function init(){
	
	try{
		if (cssua.ua.mobile) {
			$("#mobilesite").show();
		}
	}catch(e){}
	$("body").css("position","relative");
	$("body").css("top",$(".mainMenu").height());
	$('#mainGrid').css("width",screen.width*0.79);
	
	
			$('#mainGrid').css("text-align","center");
			<!--- $('#mainGrid').css("position","relative"); --->
			//$('#mainGrid').css("left",$(window).width()*0.1);
			$('.grid-item').css("width",$('#mainGrid').width()/3-20);
			$(".content").css("width",screen.width*.99-300);
            $(".sidead").css("width","300px");
			$('.grid').isotope({
			  // options
			  itemSelector: '.grid-item',
			  layoutMode: 'fitRows',
				fitRows: {
				  gutter: 10
				},
				 getSortData: {
			      title: '.title',	
			      price: '.price parseInt',
			      category: '[data-category]'
			    }
			  
			});
			$('.grid').isotope('layout');
			
			$(".options").css({
				"height":$(".wrapper").height()
			});
			$(".options").css({
				"width":$(".wrapper").width()
			});
			$(".hist_button").css("left",($(".wrapper").width()-250)/2);
			$(".hist_button").css("cursor","pointer");
			$(".hist_button").css("cursor","hand");
			
			$(".savestamp").each(function(idx,rec){
			$(rec).css({
				left:($($(rec).parent()).width()-143)/2,
				top:($($(rec).parent()).height()-147)/2
			});
			$($(".savebucks")[idx]).css({
				"top":(147-$($(".savebucks")[idx]).height())/2,
				"left":(143-$($(".savebucks")[idx]).width())/2
			}
			);
			
			
		});

	$( "#clickme" ).click(function() {
    	$( "#reportissue" ).slideUp( "slow");
    	$( "#helpusgrow" ).slideUp( "slow");
    	
	    if($( "#howitworks" ).is(':visible')){
	    	$( "#howitworks" ).slideUp( "slow");
	    }
	    else{
	    	 $( "#howitworks" ).slideDown( "slow");
	    }
	 
	});
	
	$( "#reportissueitem" ).click(function() {
		$( "#howitworks" ).slideUp( "slow");
		$( "#helpusgrow" ).slideUp( "slow");
		
	    if($( "#reportissue" ).is(':visible')){
	    	$( "#reportissue" ).slideUp( "slow");
	    }
	    else{
	    	 $( "#reportissue" ).slideDown( "slow");
	    }
	 
	});
	
	$( "#menuitem" ).click(function() {
		$( "#howitworks" ).slideUp( "slow");
		$( "#reportissue" ).slideUp( "slow");
		
	    if($( "#menu" ).is(':visible')){
	    	$( "#menu" ).slideUp( "slow");
	    }
	    else{
	    	 $( "#menu" ).slideDown( "slow");
	    }
	 
	});
	
	$(".sidead").css({
		"position":"absolute",
		"top":$(".content").position().top,
		"width":"300px",
		"left":$(".content").width()
		
	});
	
	$(window).scroll(fnOnScroll); 
	
}


function getchart(pid,title,img) {
	  $.ajax({
		type: 'GET',
	    url: '/quirkycrackers/chart.cfm?pid='+pid,
	   <!---  cache: false, --->
	    beforeSend : function(a){
	    				$( "#dialog" ).show();
	    				$( "#dialog" ).empty();
	    				$( "#dialog" ).append("Loading...");
	    				$( "#dialog" ).dialog({ 
						modal:true,
						      buttons: {
					        Close: function() {
					          $( this ).dialog( "close" );
					        }
					      },
						autoOpen: false,
						position: { 
							my: "top", 
							at: "top", 
							of: window
							 },
							height:screen.height/2,
							width:screen.width/2
					});
					
		    		$( "#dialog" ).dialog( "open" );
	    			 },
	    complete : function(results){
	    		$( "#dialog" ).empty();
	    		$(".ui-dialog").css("z-index","25");
	    		if(typeof title != "undefined"){
	    			//$( "#dialog" ).append("<div style='text-align:center'><div>"+title+"</div>"+"<div><img width='100' height='100' src='"+img+"'></div></div>");
	    		}
	    		$( "#dialog" ).append(results.responseText);
	    		$( "#dialog" ).dialog({ 
		
					autoOpen: false,
					modal:true,
						      buttons: {
					        Close: function() {
					          $( this ).dialog( "close" );
					        }
					      },
					position: { 
						my: "top", 
						at: "top", 
						of: window
						 },
							height:screen.height/2,
							width:screen.width/2
				});
	    		$( "#dialog" ).dialog( "open" );
	    		
	    		chart.render();
	    		
	    		$( "#dialog" ).resize(function() {
				  chart.render();
				});
	    	}
		});
}

function fnOnScroll(){
	if($(window).scrollTop() > $($(".grid")[0]).position().top - 50){
		$($(".sidead")[0]).css("position","fixed");
		$($(".sidead")[0]).css("top",$(".mainMenu").height());
	}
	else{
		$($(".sidead")[0]).css("position","absolute");
		$($(".sidead")[0]).css("top",$(".content").position().top);
	}
}

function goto(e,a,b){
	if($(e.srcElement).attr("class") == "slick-prev" || $(e.srcElement).attr("class") == "slick-next"){
	}
	else{
		window.open('http://findtrackbuy.com')
	}
}
/*
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
	
 }
 
 function logout(){
 	window.location="/quirkycrackers/logout/";
 }*/
