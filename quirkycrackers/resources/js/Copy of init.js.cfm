<script>
  window.fbAsyncInit = function() {
    FB.init({
      appId      : '282444375289959',
      xfbml      : true,
      version    : 'v2.1'
    });
  };

  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "//connect.facebook.net/en_US/sdk.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));
</script>

<script language="javascript">
var minPID = 100000;
var lastPos = 0;
var wrap_h = 310;
var wrap_w = 300;
var prod_gap = 20;
var left_margin = (window.innerWidth-(wrap_w+(prod_gap))*3)/2;
if(left_margin <80) left_margin=80;
var slider_w = wrap_w*3+2*prod_gap;
var slider_h = 450;
var scrollLeft = $(window).scrollLeft();
var initload = 0;
var pin = 0;
var ajaxing=0;
var catId = -99;
var q1 = new Array();
var q2 = new Array();
var q3 = new Array();
var zout = 1;
var user_quirk = new Array();
var user_data = {};
var fromPrice = 0;
var toPrice = 0
var emailAjaxList = new Array();
var main_products;
var searchList = new Array();
var pageNum=1;
var showFeedback = 1;
user_data.first_name = '';
user_data.last_name = '';
user_data.email = '';
user_data.dob = '';
user_data.news_letter = '';
user_data.sex = '';
user_data.user_sk = '';

<cfoutput>
	<cfif isdefined("session.user_detail")>
		try {user_data = $.parseJSON('#session.user_detail#');
		user_data.user_sk = user_data.DATA[0][6];
		}
		catch(e){
			
		}
	</cfif>
</cfoutput>


function loginApply(){
	if(user_data.user_sk.length){
		
		$("#loginBar").append($("#login_login"));
		$("#login_login").css("display","block");
		$("#login_logout").css("display","none");
		
		$("#loginContent").append($("#login_content"));
		$("#login_content").css("display","block");
		$("#logout_content").css("display","none");
		
		if(user_data.DATA[0][0].length == 0){
			$("#userNameMsg").append("Dear User, <br>We would hate to refer you by your email, Kindly update your name with us.<br>");
		}
		else{
			$("#userNameMsg").append("Dear "+user_data.DATA[0][0]+", <br>Here you can update basics.<br>");
		}
		$("#first_name").attr("value",user_data.DATA[0][0]);
		$("#last_name").attr("value",user_data.DATA[0][1]);
		if(user_data.DATA[0][4] == 1) 
			$("#news_lettercb").attr("checked","checked");
		else
			$("#news_lettercb").attr("checked","");
		
		
		$.ajax({
			url:"/product/topFour/?user_sk="+user_data.user_sk,
			success : function(results){
				var data = $.parseJSON(results);
				var msg = '';
				if(data.USERPROD == 1){
					msg = 'Here are top 4 from your Saved List.';
				}
				else{
					msg = 'Here will be your Saved List. Once you have saved 4+ products.<br>In the mean time, these are top 4 favs';
				}
				var content = 
				[
						'<table style="color:white;width:100%; text-align:center">'
				,			'<tr><td style="font-size:small;color:white">'
				,					msg
				,				'</td>'
				,			'</tr><tr>'
				,				'<td align="center">'
				,					'<table bgcolor="black">'
				,						'<tr>'
				,							'<td height="110" width="160" title="'+data.TOP4.DATA[0][1]+'"><a href="/product/page/show/'+data.TOP4.DATA[0][0]+'"><img border="1" width="150" height="100" src="'+data.TOP4.DATA[0][2]+'"/></a></td>'
				,							'<td height="110" width="160" title="'+data.TOP4.DATA[1][1]+'"><a href="/product/page/show/'+data.TOP4.DATA[1][0]+'"><img border="1" width="150" height="100" src="'+data.TOP4.DATA[1][2]+'"/></a></td>'
				,						'</tr>'
				,						'<tr>'
				,							'<td height="110" width="160" title="'+data.TOP4.DATA[2][1]+'"><a href="/product/page/show/'+data.TOP4.DATA[2][0]+'"><img border="1" width="150" height="100" src="'+data.TOP4.DATA[2][2]+'"/></a></td>'
				,							'<td height="110" width="160" title="'+data.TOP4.DATA[3][1]+'"><a href="/product/page/show/'+data.TOP4.DATA[3][0]+'"><img border="1" width="150" height="100" src="'+data.TOP4.DATA[3][2]+'"/></a></td>'
				,						'</tr>'
				,						'<tr>'
				,							'<td colspan="2" style="font-size:small;color:white;text-align:center" onclick="$(\'#loginBar\').click();$(\'#menu_head\').click();loadByUser(user_data.user_sk);"><a href="javascript:void(0);" style="color:white">Browse --> My Quirkies contains all your stuff.</a></td>'
				,						'</tr>'
				,					'</table>'
				,				'</td>'
				,			'</tr>'
				,		'</table>'
				].join('')	;
				
				$("#loginTop4").append(content);
			}
		});
		
	}
	else{
		
		$("#loginBar").append($("#login_logout"));
		$("#login_logout").css("display","block");
		$("#login_login").css("display","none");
		
		$("#loginContent").append($("#logout_content"));
		$("#logout_content").css("display","block");
		$("#login_content").css("display","none");
	
	}
}

function clickLog(id){

	$.ajax({
				type: 'POST',
			    url: '/main/clickLog/id/'+id,
			    complete : function(results){
			    		
			    }
		});

	
}

initPage = function(products){
	pageNum++;
		for(i=0; i<products.length; i++){
			
			try{
				if(products[i][0] <= -99){
					<!--- var randnum = Math.floor((Math.random() * 3)); --->
					var randnum = 0;
						$("#midMain").append('<div class="product_wrap" style="position:relative" id="product_'+products[i][0]+'"></div>');
						if($($(".amazonAd")[randnum]).html().trim().indexOf('class="ticker"')>0){
							$("#product_"+products[i][0]).append(
							'<div  style="background-color:black;border:5px solid black;color:white;text-decoration:none;" id="product_title_'+products[i][0]+'"><b>Quick Quirk</b></div>'
							);//background-color:#3b5998
							$("#product_"+products[i][0]).append(
								'<div  style="position:absolute;top:230;left:0;font-size:80%" id="product_desc_'+products[i][0]+'">While you are browsing our super cool products listing, why not hold on and taste a quirky bite!</div>'
							);
							var $clone = $($(".amazonAd")[randnum]).html();
							$("#product_"+products[i][0]).append("<div style='position:absolute;'>"+$clone+"</div>");
							$clone.css("display","block");
						}
						else{
							$("#product_"+products[i][0]).append(
								'<div  style="background-color:black;border:1px solid black;color:white;text-decoration:none;font-size:x-small;" id="product_title_'+products[i][0]+'"><b>'+products[i][1]+'</b></div>'
							);//background-color:#3b5998
							$("#product_"+products[i][0]).append(
								'<div  style="position:absolute;top:265;left:0;font-size:x-small;" id="product_desc_'+products[i][0]+'">While this Ad might be of your interest, it help us running this site for you. We run just 1 Ad in 18 to 24 of our products. For us your experience with our site matters most. <br>Your support is sincerely appreciated.</div>'
							);
							var $clone = $($(".amazonAd")[randnum]).html();
							$("#product_"+products[i][0]).append("<div style='position:absolute;'>"+$clone+"</div>");
							$clone.css("display","block");
						}
				
				}
				else{
					
					$("#midMain").append('<div class="product_wrap" style="position:relative" id="product_'+products[i][0]+'"></div>');
			
				$("#product_"+products[i][0]).append(
					'<div class="product_title" style="background-color:black;border:5px solid black;color:white;text-decoration:none;" id="product_title_'+products[i][0]+'"><b><a target="_blank" href="/product/page/show/'+products[i][14]+'" style="text-decoration: none;color:white;">'+products[i][1]+'</a></b></div>'
				);//background-color:#3b5998
				
				$("#product_"+products[i][0]).append(
					'<a href="'+products[i][4]+'" target="_blank" onclick="clickLog('+products[i][0]+');"><div class="product_img" id="product_img_'+products[i][0]+'"><img width="300px" height="200px"  src="'+products[i][3]+'"></div></a>'
				);
				
				if(products[i][7] == 0){
					$("#product_"+products[i][0]).append(
					'<div class="product_price" style="background-color:black;position:absolute;top:215;left:0;height:20px;border:3px solid black;color:white;" id="product_price_'+products[i][0]+'">Concept</div>'
					);
				}
				else{
					$("#product_"+products[i][0]).append(
					'<div class="product_price" style="background-color:black;position:absolute;top:215;left:0;height:20px;border:3px solid black;color:white;" id="product_price_'+products[i][0]+'"><img alt="" src="/resources/images/rs.png"/>'+products[i][7]+' </div>'
					);
				}
				
				$("#product_"+products[i][0]).append(
					'<a href="'+products[i][4]+'" target="_blank"><div class="product_checkout" style="background-color:black;position:absolute;top:215;right:0;height:20px;border:3px solid black;color:white;" id="product_checkout_'+products[i][0]+'">Check Out</div></a>'
					);
					
				
				$("#product_"+products[i][0]).append(
					'<div class="product_desc" style="position:absolute;top:240;left:0;" id="product_desc_'+products[i][0]+'">'+products[i][2]+' </div>'
				);
				$("#product_"+products[i][0]).append(
					'<div class="product_ratings" style="background-color:white" id="product_price_'+products[i][0]+'"></div>'
				);
				
				}
			
			}
			catch(e){}
		}
		
		$(".product_wrap").css(
			{
				"height":wrap_h, 
				"width":wrap_w,
				"position" : "absolute",
				"text-align":"center"
				,"border":"1px solid black"
				,"background-color":"rgb(255, 251, 205)"
			}
		);
		$(".product_desc").css(
			{
				"font-size":"75%",
				"text-align":"left",
				"border":"3px solid rgb(255, 251, 205)"
			}
		);
		
		
		$(".product_title").css("font-family","arial,sans-serif");
		$(".product_title").css("text-decoration","none");
		
		positionProducts();
		
  } //init Ends
  
function fnOnScroll(e) {
			  		
	if(($(window).scrollTop() >= ($(document).height() - $(window).height() - 300))
		&& initload
	){
		
		initPageNew();
		$.ajax({
				type: 'POST',
			    url: '/main/pageRequest/',
			    complete : function(results){
			    		 (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
					  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
					  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
					  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
					
					  ga('create', 'UA-54318348-1', 'auto');
					  ga('require', 'displayfeatures');
					  ga('send', 'pageview');
			    }
		});
	}

    //$('#containerTop').css('top', $(this).scrollTop() + "px");
    
    if($(window).scrollTop() == 0 && scrollLeft == $(window).scrollLeft()
    	&& $( window ).width()>(screen.width-(screen.width*20/100))
    ){
  		zout = 1;
  	}
  	else if(($(window).scrollTop()>20 ) ||($( window ).width()<(screen.width-(screen.width*20/100)))){
  		zout=0;
  		//$('#_mainTop').css("position","fixed");
  			runEffect({ to: { height: "32px",'font-size': '100%' } },
  					{to:{height:'56px',width:'261px'}}
  			);
  			<!--- $("div#minishare").css("top","32"); --->
  			$("#containerTop").css("position","fixed");
  			$("#containerTop").css("top","0");
  			
  	}
  	
	scrollLeft = $(window).scrollLeft();
	
	if($(window).scrollTop() > 5000){
		if(!showFeedback)
		{
			showFeedback=1
			feedback(showFeedback);
		}
	}
	else{
		showFeedback = 0;
		feedback(showFeedback);
	}
	
	if($(window).scrollTop() > 10000 && pageNum%15 == 0){
		likeUs();
	}
	
	$( "#feedbackForm" ).css({"top":$(window).height() - 75,"left":$(window).width() - 200});
	if($(window).scrollTop() < 800){
		$( "#feedbackForm" ).fadeOut( "slow", function() {
		});
	}
}

function feedback(show){
	if(show==1){
		
		
		var top = $(window).height() - 75;
		var left = $(window).width() - 200;
		<!--- $(document.body).append(

			[
				'<div id="feedbackForm" style="position:fixed; border-top-left-radius: 8px;border-top-right-radius: 8px;z-index:7001; width:200; height:75;top:'+top+';left:'+left+';background-color:black;display:none">'
  		    	,'<div style="color:yellow;text-align:center;font-size:200%;">'
  		    	,'<img class="stars" id="1_star" alt="" width="30" height="30" src="/resources/images/star.png"/>&nbsp;'
  		    	,'<img class="stars" id="2_star" alt="" width="30" height="30" src="/resources/images/star.png"/>&nbsp;'
  		    	,'<img class="stars" id="3_star" alt="" width="30" height="30" src="/resources/images/star.png"/>&nbsp;'
  		    	,'<img class="stars" id="4_star" alt="" width="30" height="30" src="/resources/images/star.png"/>&nbsp;'
  		    	,'<img class="stars" id="5_star" alt="" width="30" height="30" src="/resources/images/star.png"/>'
  		    	,'</div>'
  		    	,'<div style="color:yellow"><textarea cols="25" placeholder="Your words matter..."></textarea></div>'
  		    	,'</div>'
  		    ].join('')
		); --->
		$( "#feedbackForm" ).css({"top":top,"left":left});
		$( ".stars" ).css("opacity",".3");
		
		$( ".stars" ).mouseover( function(){

			var id = $(this).attr("id").split('_')[0];
			
			for(var i=1; i<=id; i++){
				$("#"+i+"_star").css("opacity","1");
			}
			
			for(var i=parseInt(id)+1; i<=5; i++){
				$("#"+i+"_star").css("opacity",".3");
			}
			
		} );
		
		$( ".stars" ).mouseout( function(){
			var id = $(this).attr("id").split('_')[0];
			//$(this).css("opacity","1");
		} );
		
		$( ".stars" ).click( function(){
			var id = $(this).attr("id").split('_')[0];
			$.ajax({
				type: 'POST',
			    url: '/misc/feedback/',
			    data: { 
			        'id': id, 
			        'user_sk': user_data.user_sk 
			    },
				success : function(results){
				},
				failuer : function(results){
				},
				beforeSend : function(results){
					$("#feedbackForm").css("cursor","progress");
				},
				complete : function(results){
					$("#feedbackForm").css("cursor","default");
					$("#feedbackFormMsg").empty();
					$("#feedbackFormMsg").append(('<div style="color:yellow;text-align:center;border:10;">Thank you!</div>'));
					$( "#feedbackFormMsg" ).fadeOut( "5000", function() {
						$( "#feedbackForm" ).fadeOut( "slow", function() {
							$( "#feedbackForm" ).remove();
							likeUs();
						});
					});
					
					
				}
					
			});
		} );
		
		$( "#feedbackForm" ).fadeIn( "slow", function() {
		});
	} <!--- else {
			try{
				$( "#feedbackForm" ).fadeOut( "slow", function() {
					$("#feedbackForm").remove();
				});
			}catch(e){}	
	} --->

}

function likeUs(){
	var top = 75;
	var left = 2;
	$(document.body).append(

			[
				'<div id="likeUs" style="position:fixed; z-index:7001; width:210; height:158;top:'+top+';left:'+left+';display:none;">'
  		    	,'<div style="color:yellow;text-align:center;font-size:200%;">'
  		    	,'<img alt="" src="/resources/images/likearrow.png"/>&nbsp;'
  		    	,'</div>'
  		    ].join('')
		);
	$( "#likeUs" ).fadeIn( "slow", function() {
	});
	
	$( "#likeUs" ).fadeOut( 6000, function() {
		$( "#likeUs" ).remove();
	});
}

 function resize()
{
	
 if($( window ).width()<(screen.width-(screen.width*20/100))){
		$("#_mainLogo").effect("size",{to:{height:'24',width:'282'}},150,function(){
			$('#_mainLogo').css("width",282);
      		$('#_mainLogo').css("height",24);
		});
    }
    else{
    	if($('#_mainLogo').css("width") == "282px"){
    		
    	}
    } 
    
   // loginMain
    positionProducts();
    try{
		$( "#feedbackForm" ).css({"top":$(window).height() - 75,"left":$(window).width() - 200});
	} catch(e) {
	
	}
	
	$("#menu_head").css({"top":$(window).height()/2-$("#menu_head").height()/2,"left":0,"display":"block"});
	$("#loginBar").css({"top":$(window).height()/2-$("#loginBar").height()/2,"right":0,"display":"block"});
	$("#loginContent").css({"top":$(window).height()/2-$("#loginContent").height()/2});
	$("#menu_items").css({"top":$(window).height()/2-$("#menu_items").height()/2});
	
	
} //resize ends
 



function runEffect(option1,option2,zoom) {
      var selectedEffect = "size";
 
       $("#_mainLogo").effect( selectedEffect, option2, 150,function(){
      	$('#_mainLogo').css("width",option2.to.width);
      	$('#_mainLogo').css("height",option2.to.height); 
      });
} //runEffect ends

var positionProducts = function(){
			if(left_margin < 0) left_margin=0;
			var cols = 3;
			if (cssua.ua.mobile) {
					cols = 2;
					left_margin = (window.innerWidth-(wrap_w+(prod_gap))*2)/2;
			}		
	
	$(".product_wrap").each(function(idx,rec){
		
		var pos = (function(row,col){
			return {'top':(row-1)*370+slider_h,'left': ((col-1)*(wrap_w+prod_gap)+left_margin)};						
		})(
				(function(num){
						return Math.ceil(num/cols);
				})(idx+1),
				(function(num){
					if(num % cols == 0) return cols;
					if((num+1) % cols == 0) return (cols-1);
					if((num+2) % cols == 0) return (cols-2);
				})(idx+1)
			);
			
		$("#"+rec.getAttribute("id")).css({
			"top":pos.top,
			"left":pos.left
		});
		
		var $rate = $('#rating').clone();
		try{
			$("#rating_"+rec.getAttribute("id")).remove();
		}
		catch(e){}
		var display_d = "none";
		if (cssua.ua.mobile) {
					display_d = "none";
				}		
		if($("#product_price_"+rec.getAttribute("id").split("_")[1]).text() != 'Concept'){		
		$rate.attr('id', "rating_"+rec.getAttribute("id"));
		$rate.css({
			"top":pos.top+80+30,
			"left":pos.left+10,
			"display":display_d
		});
		}
		
		$rate.mouseover(function(){
				$(this).css("display","block");
			});
			
			$rate.mouseout(function(){
				$(this).css("display",display_d);
			});
		
		 $("#product_img_"+rec.getAttribute("id").split("_")[1]).mouseenter(function(){
		 		$("#rating_"+rec.getAttribute("id")).css("display","block");
		 }); 
		 
		   $("#product_img_"+rec.getAttribute("id").split("_")[1]).mouseleave(function(){
		 		$("#rating_"+rec.getAttribute("id")).css("display","none");
		 }); 
		 
		 $("#rating_"+rec.getAttribute("id")).mouseenter(function(){
		 		$("#rating_"+rec.getAttribute("id")).css("display","block");
		 }); 
		 
		$(document.body).append($rate);
		
		lastPos = pos.top;
	
	}); 
	
	$("#containerDown").css("top",lastPos+(wrap_h+20)+82);

} //positionProducts ends

function fnmenu_head(show) {    
	if($('#menu_items').css("display") == "none" || show == 1){
		$('#menu_items').css("display","block");                                
        $('#menu_items').animate({'left':'0px'},500);
        $(this).animate({'left':'140px'},500);
	}
	else
	{
        $('#menu_items').animate({'left':'-140px'},500,function(){
        	$('#menu_items').css("display","none"); 
        });
        $(this).animate({'left':'0px'},500);
	}
}

function fnloginBar(event) {
	
	if($('#loginContent').css("display") == "none"){
		$('#loginContent').css("display","block");                                
        $('#loginContent').animate({'right':'0px'},750,function(){
        	 $("#cover").css({
	        	display: "block",
	        	opacity:2
	        });
        });
        $(this).animate({'right':'410px'},750);
       
	}
	else
	{
        $('#loginContent').animate({'right':'-410px'},750,function(){
        	$('#loginContent').css("display","none");
        	$("#cover").css({
	        	display: "none",
	        	opacity:2
       		 });
       		 $("#loginMsg").text("");
        });
        $(this).animate({'right':'0px'},750);
	}
}

function aboutUs(){
	$.ajax({
				url:"/main/aboutUs/",
				success : function(results){
					//$("#aboutUs").empty();
					$(".pop_ups_main").empty();
					$(".pop_ups_main").hide();
					$("#aboutUs").append(results);
					$("#aboutUs").css("display","block");
				},
				failuer : function(results){
				},
				beforeSend : function(results){
					$("#loadingImg").css({
							"display":"block"
						});
				},
				complete : function(results){
					$("#loadingImg").css({
							"display":"none"
						});
				}
					
			});
		
		
} ///aboutUs ends
			
function contactUs1(content){
	$.ajax({
				url:"/main/contactUs/content/"+content,
				success : function(results){
					$(".pop_ups_main").empty();
					$(".pop_ups_main").hide();
					$("#contactUs").append(results);
					$("#contactUs").css("display","block");
					$(".paneContent").each(function(idx,rec){
						
						$(rec).css("left",(function(){
							return ($($(".paneWin")[idx]).width()-$(rec).width())/2;
						})());
					});
				},
				failuer : function(results){
				},
				beforeSend : function(results){
					$("#loadingImg").css({
							"display":"block"
						});
				},
				complete : function(results){
					$("#loadingImg").css({
							"display":"none"
						});
				}
					
			});
		
		
} ///contactUs ends

function privacyPop(){
	$.ajax({
				url:"/main/privacy/",
				success : function(results){
					//$("#aboutUs").empty();
					$(".pop_ups_main").empty();
					$(".pop_ups_main").hide();
					$("#privacy").append(results);
					$("#privacy").css("display","block");
				},
				failuer : function(results){
				},
				beforeSend : function(results){
					$("#loadingImg").css({
							"display":"block"
						});
				},
				complete : function(results){
					$("#loadingImg").css({
							"display":"none"
						});
				}
					
			});
		
		
} ///privacyPop ends

function contentRemovalPop(){
	$.ajax({
				url:"/main/contentRemoval/",
				success : function(results){
					//$("#aboutUs").empty();
					$(".pop_ups_main").empty();
					$(".pop_ups_main").hide();
					$("#contentRemoval").append(results);
					$("#contentRemoval").css("display","block");
				},
				failuer : function(results){
				},
				beforeSend : function(results){
					$("#loadingImg").css({
							"display":"block"
						});
				},
				complete : function(results){
					$("#loadingImg").css({
							"display":"none"
						});
				}
					
			});
		
		
} ///contentRemovalPop ends

function resetPassword(){
	$.ajax({
				url:"/main/resetPassword/",
				success : function(results){
					$(".pop_ups_main").empty();
					$(".pop_ups_main").hide();
					$("#resetPassword").append(results);
					$("#resetPassword").css("display","block");
					$(".paneContent").each(function(idx,rec){
						
						$(rec).css("left",(function(){
							return ($($(".paneWin")[idx]).width()-$(rec).width())/2;
						})());
					});
				},
				failuer : function(results){
				},
				beforeSend : function(results){
					$("#loadingImg").css({
							"display":"block"
						});
				},
				complete : function(results){
					$("#loadingImg").css({
							"display":"none"
						});
				}
					
			});
		
		
} ///resetPassword ends
			
function closeThis(what){
	var scroll = $(window).scrollTop();
	$( "#"+what ).animate({
		    width: [ "toggle", "swing" ],
		    height: [ "toggle", "swing" ],
		    opacity: "toggle"
		  }, 200, "linear", function() {
		  	$(window).scrollTop(scroll);
	 });
} ///closeThis ends
			
function shareFB(cmp){
	var id = $(cmp).parent().parent().parent().attr("id").split('_')[2];
	var shareTo = '';
	if($(cmp).attr("class").split("_")[1] == 'tw'){
		shareTo = 'twitter';
	}
	if($(cmp).attr("class").split("_")[1] == 'fb'){
		shareTo = 'fb';
	}
	if($(cmp).attr("class").split("_")[1] == 'fav'){
		shareTo = 'quirk';
	}
	
	var services = {
			twitter: "https://twitter.com/intent/tweet?text=",
			facebook: "https://www.facebook.com/sharer/sharer.php?u=",
			quirk: "/main/quirkit/id/"
		};
	
	if(shareTo == "twitter") { // add a  wee message for twitter users
		the_url = services["twitter"] + "&url=http%3A%2F%2Fwww.quirkycrackers.com%2Fproduct%2Fpage%2Fshow%2F" + id;
		var share_window = window.open(the_url, 'sharer', 'width=600,height=400,top=200,left=200');
	} 
	
	if(shareTo == "fb") { // add a  wee message for twitter users
		the_url = services["facebook"] + "&u=http%3A%2F%2Fwww.quirkycrackers.com%2Fproduct%2Fpage%2Fshow%2F" +id+'&display=popup&ref=plugin';
		var share_window = window.open(the_url, 'sharer', 'width=600,height=400,top=200,left=200');
	} 
	
	if(shareTo == 'quirk'){
		if($.inArray( id,user_quirk )<0){
			if(isLoggedIn()){
				countUp(id);
				saveFav(id);
				greyOut(id);
			}
			else{
				countUp(id);
				askLogin(id,"Thanks for Quirking it up! You may sign in/up  to save this as your favorite Quirk.");
			}
			user_quirk.push(id);
			//$('a#...').attr('onclick','').unbind('click');
		}
	}
	
	userActivity(id,shareTo);
} ///shareFB ends

function isLoggedIn(){
	if(user_data.user_sk.length) return true;
	return false;
}//isLoggedIn ends

function userActivity(id,shareTo){
	$.ajax({
		url:"/user/activity/id/"+id+"/shareTo/"+shareTo+"/user_sk/"+user_data.user_sk,
		success : function(results){}
	});
}//userActivity ends

function countUp(id){

	$.ajax({
		url:"/product/countup/id/"+id,
		complete : function(results){
			if(isLoggedIn() || 1==1){
				var msg = "Thanks!";
				$( "#topMessage" ).empty();
				$( "#topMessage" ).append(msg);
				
				$( "#topMessage" ).css(
					{
						"top":screen.height/2,
					"left":screen.width/2
					}
				);
				$( "#topMessage" ).fadeIn( 1000);
				
				$( "#topMessage" ).fadeOut( 2000, function() {
					$( "#topMessage" ).empty();
				});
			}
		}
	});

}//countUp ends

function saveFav(id){
	
	$.ajax({
		url:"/product/fav/id/"+id+"/user_sk/"+user_data.user_sk,
		complete : function(results){
			if(isLoggedIn() || 1==1){
				var msg = "Saved as your Fav!!";
				$( "#topMessage" ).empty();
				$( "#topMessage" ).append(msg);
				
				$( "#topMessage" ).css(
					{
						"top":screen.height/2,
					"left":screen.width/2
					}
				);
				$( "#topMessage" ).fadeIn( 1000);
				
				$( "#topMessage" ).fadeOut( 2000, function() {
					$( "#topMessage" ).empty();
				});
			}
		}
	});

}//saveFav ends

function greyOut(id){

}//greyOut ends

function askLogin(id,msg){
	$("#loginMsg").text(msg);
	$('#loginBar').click();
}//askLogin ends

function showMenu(show){
	if(show){
	 $("#menu_main").css({
		"left":($("#menu_icon").offset().left-200)+$("#menu_icon").width()/2,
		"top":$("#toprest").offset().top+$("#menu_icon").height()/2,
		"display":"block",
		"z-index":"6000"
	});
	}
	else{
		 $("#menu_main").css({
		"display":"none"
	});
	}
} //showMenu ends

function pinup(){
	if(pin){ 
		pin=0; 
		$("#pinupdiv").empty();
		$("#pinupdiv").append("Auto Load is ON");
		} 
	else {
		pin=1; 
		$("#pinupdiv").empty();
		$("#pinupdiv").append("Auto Load is OFF");
		}
};//pinup ends
			
function loadMore(){
	$.ajax({
			url:"/main/getProducts/catid/"+catId+"/fromPID/"+minPID,
			success : function(results){
				products = $.parseJSON(results);
			},
			failuer : function(results){
			},
			beforeSend : function(results){
				$("#loading").empty();
				$("#loading").append("Loading...");
				if(ajaxing) results.abort();
				if(!ajaxing) ajaxing=1;
				//$('#midMain').prepend('<table id="loading" width="100%"><tr><td align="center" height="600px"><img src="/resources/images/ajax-loading.gif" /></td></tr></table>');
			},
			complete : function(results){
				//$( "#midMain" ).empty();
				initPage();
				ajaxing = 0;
				$("#loading").empty();
				$("#loading").append("Load More Products");
			}
					
			});
}; //loadMore end

function loadByRange(fromNumber,toNumber,by){
	fromPrice = fromNumber;
	toPrice = toNumber;
	if(by == 'C') loadByCat(catId);
	else <cfoutput>loadByUser('#session.user_sk#');</cfoutput>
}

function loadByCat(cat){
	catId = cat;
	minPID = 100000;
	slider_w = 0;
	slider_h = 150;
	pageNum=1;
	$.ajax({
				url:"/main/getProductsByCat/catId/"+catId+"/fromPID/"+minPID+"/fromPrice/"+fromPrice+"/toPrice/"+toPrice,
				success : function(results){
					//Destry existing
					products = $.parseJSON(results);
					q1 = $.parseJSON(results).Q1.DATA;
					q2 = $.parseJSON(results).Q2.DATA;
					q3 = $.parseJSON(results).Q3.DATA;
					$(".product_wrap").remove();
					$(".slider").remove();
					initPageNew();
					$("#catMenu").empty();
					$("#catMenu").append("<h1>"+$("#menu_"+catId).text()+"</h1>"+"<span id='price_range'></span>");
					$('head').append('<link rel="stylesheet"  href="/resources/js/ion.rangeSlider-1.9.3/css/normalize.min.css"></link>');
					$('head').append('<link rel="stylesheet"  href="/resources/js/ion.rangeSlider-1.9.3/css/ion.rangeSlider.css"></link>');
					$('head').append('<link rel="stylesheet"  href="/resources/js/ion.rangeSlider-1.9.3/css/ion.rangeSlider.skinFlat.css"></link>');
					
					$("#range_1").remove();
					$("#price_range").empty();
					$("#price_range").append('<input type="text" id="range_1" />');
					
					$("#range_1").ionRangeSlider(
						{
						    min: 0,
						    max: 8000,
						    from: fromPrice,
						    to: toPrice,
						    type: 'double',
						    step: 100,
						    postfix: " Rs.",
						    maxPostfix : "+",
						    //,hasGrid: true,
						    //gridMargin: 15,
						    onLoad: function (obj) {        // callback is called after slider load and update
						       /// console.log(obj);
						    },
						    onChange: function (obj) {      // callback is called on every slider change
						       /// console.log(obj);
						    },
						    onFinish: function (obj) {      // callback is called on slider action is finished
						       // console.log(obj);
						       loadByRange(obj.fromNumber,obj.toNumber,'C');
						    }
						}
					); 
					
					$("#catMenu").css({
						position : "absolute",
						top : "70",
						left : left_margin,
						width : 3*wrap_w+2*prod_gap
						//,'background-color':"yellow"
					});
					$(window).scrollTop(0);
					
					$("div[id^='menu_']").css("color","white");
					$("#menu_"+catId).css("color","yellow");
					
				},
				failuer : function(results){
				},
				beforeSend : function(results){
					$("#loadingImg").css({
							"display":"block"
						});
					if(ajaxing) results.abort();
					if(!ajaxing) ajaxing=1;
				},
				complete : function(results){
					//$( "#midMain" ).empty();
					ajaxing = 0;
					$("#loadingImg").css({
							"display":"none"
						});
				}
					
			});

} ///loadByCat end

function loadByUser(user_sk){
	minPID = 100000;
	slider_w = 0;
	slider_h = 150;
	$.ajax({
				url:"/main/getProductsByUser/user_sk/"+user_sk+"/fromPID/"+minPID+"/fromPrice/"+fromPrice+"/toPrice/"+toPrice,
				success : function(results){
					//Destry existing
					products = $.parseJSON(results);
					q1 = $.parseJSON(results).Q1.DATA;
					q2 = $.parseJSON(results).Q2.DATA;
					q3 = $.parseJSON(results).Q3.DATA;
					q1 = q1.concat(q2);
					q1 = q1.concat(q3);
					q2 = [];
					q3 = [];
					$(".product_wrap").remove();
					$(".slider").remove();
					initPageNew(1);
					$("#catMenu").empty();
					$("#catMenu").append("<h1>"+$("#menu_"+user_sk).text()+"</h1>"+"<span id='price_range'></span>");
					$('head').append('<link rel="stylesheet"  href="/resources/js/ion.rangeSlider-1.9.3/css/normalize.min.css"></link>');
					$('head').append('<link rel="stylesheet"  href="/resources/js/ion.rangeSlider-1.9.3/css/ion.rangeSlider.css"></link>');
					$('head').append('<link rel="stylesheet"  href="/resources/js/ion.rangeSlider-1.9.3/css/ion.rangeSlider.skinFlat.css"></link>');
					
					$("#price_range").append('<input type="text" id="range_1" />');
					
					$("#range_1").ionRangeSlider(
						{
						    min: 0,
						    max: 8000,
						    from: fromPrice,
						    to: toPrice,
						    type: 'double',
						    step: 100,
						    postfix: " Rs.",
						    maxPostfix : "+",
						    //,hasGrid: true,
						    //gridMargin: 15,
						    onLoad: function (obj) {        // callback is called after slider load and update
						       /// console.log(obj);
						    },
						    onChange: function (obj) {      // callback is called on every slider change
						       /// console.log(obj);
						    },
						    onFinish: function (obj) {      // callback is called on slider action is finished
						        loadByRange(obj.fromNumber,obj.toNumber,'U');
						    }
						}
					); 
					
					$("#catMenu").css({
						position : "absolute",
						top : "70",
						left : left_margin,
						width : 3*wrap_w+2*prod_gap
						//,'background-color':"yellow"
					});
					$(window).scrollTop(0);
					
					$("div[id^='menu_']").css("color","white");
					$("#menu_"+user_sk).css("color","yellow");
					
				},
				failuer : function(results){
				},
				beforeSend : function(results){
					$("#loading").empty();
					$("#loading").append("Loading...");
					if(ajaxing) results.abort();
					if(!ajaxing) ajaxing=1;
				},
				complete : function(results){
					//$( "#midMain" ).empty();
					ajaxing = 0;
					$("#loading").empty();
					$("#loading").append("Load More Products");
				}
					
			});

} ///loadByUser end

function loadRandom(){
	minPID = 100000;
	slider_w = 0;
	slider_h = 150;
	$.ajax({
				url:"/main/getRandomProduct/fromPID/"+minPID+"/fromPrice/"+fromPrice+"/toPrice/"+toPrice+"/ran/"+Math.random(),
				success : function(results){
					//Destry existing
					products = $.parseJSON(results);
					q1 = $.parseJSON(results).Q1.DATA;
					q2 = $.parseJSON(results).Q2.DATA;
					q3 = $.parseJSON(results).Q3.DATA;
					$(".product_wrap").remove();
					$(".slider").remove();
					initPageNew();
					$("#catMenu").empty();
					$("#catMenu").append("<table><tr><td><h1>Random Products</h1></td></tr></table>"+"<span id='price_range'></span>");
					$('head').append('<link rel="stylesheet"  href="/resources/js/ion.rangeSlider-1.9.3/css/normalize.min.css"></link>');
					$('head').append('<link rel="stylesheet"  href="/resources/js/ion.rangeSlider-1.9.3/css/ion.rangeSlider.css"></link>');
					$('head').append('<link rel="stylesheet"  href="/resources/js/ion.rangeSlider-1.9.3/css/ion.rangeSlider.skinFlat.css"></link>');
					
					$("#price_range").append('<input type="text" id="range_1" />');
					
					$("#range_1").ionRangeSlider(
						{
						    min: 0,
						    max: 8000,
						    from: fromPrice,
						    to: toPrice,
						    type: 'double',
						    step: 100,
						    postfix: " Rs.",
						    maxPostfix : "+",
						    //,hasGrid: true,
						    //gridMargin: 15,
						    onLoad: function (obj) {        // callback is called after slider load and update
						       /// console.log(obj);
						    },
						    onChange: function (obj) {      // callback is called on every slider change
						       /// console.log(obj);
						    },
						    onFinish: function (obj) {      // callback is called on slider action is finished
						        fromPrice = obj.fromNumber;
						        toPrice = obj.toNumber;
						        loadRandom();
						    }
						}
					); 
					
					$("#catMenu").css({
						position : "absolute",
						top : "70",
						left : left_margin,
						width : 3*wrap_w+2*prod_gap
						//,'background-color':"yellow"
					});
					$(window).scrollTop(0);
					
					$("div[id^='menu_']").css("color","white");
					$("#menu_"+user_data.user_sk).css("color","yellow");
					
				},
				failuer : function(results){
				},
				beforeSend : function(results){
					$("#loading").empty();
					$("#loadingImgRandom").css({
							"display":"block"
						});
					if(ajaxing) results.abort();
					if(!ajaxing) ajaxing=1;
				},
				complete : function(results){
					//$( "#midMain" ).empty();
					ajaxing = 0;
					$("#loading").empty();
					$("#loadingImgRandom").css({
							"display":"none"
						});
				}
					
			});

} ///loadRandom end

function loadQuirkyAt(source){
	minPID = 100000;
	slider_w = 0;
	slider_h = 150;
	var source_desc = '';
	if(source == 1){
		source_desc = 'Flipkart';
	}
	if(source == 21){
		source_desc = 'SnapDeal';
	}
	if(source == 20){
		source_desc = 'Amazon';
	}
	$.ajax({
				url:"/main/getSourceProduct/fromPID/"+minPID+"/fromPrice/"+fromPrice+"/toPrice/"+toPrice+"/ran/"+Math.random()+"/source_id/"+source,
				success : function(results){
					//Destry existing
					products = $.parseJSON(results);
					q1 = $.parseJSON(results).Q1.DATA;
					q2 = $.parseJSON(results).Q2.DATA;
					q3 = $.parseJSON(results).Q3.DATA;
					$(".product_wrap").remove();
					$(".slider").remove();
					initPageNew();
					$("#catMenu").empty();
					$("#catMenu").append("<table><tr><td><h1>Quirky @ "+source_desc+"</h1></td></tr></table>"+"<span id='price_range'></span>");
					$('head').append('<link rel="stylesheet"  href="/resources/js/ion.rangeSlider-1.9.3/css/normalize.min.css"></link>');
					$('head').append('<link rel="stylesheet"  href="/resources/js/ion.rangeSlider-1.9.3/css/ion.rangeSlider.css"></link>');
					$('head').append('<link rel="stylesheet"  href="/resources/js/ion.rangeSlider-1.9.3/css/ion.rangeSlider.skinFlat.css"></link>');
					
					$("#price_range").append('<input type="text" id="range_1" />');
					
					$("#range_1").ionRangeSlider(
						{
						    min: 0,
						    max: 8000,
						    from: fromPrice,
						    to: toPrice,
						    type: 'double',
						    step: 100,
						    postfix: " Rs.",
						    maxPostfix : "+",
						    //,hasGrid: true,
						    //gridMargin: 15,
						    onLoad: function (obj) {        // callback is called after slider load and update
						       /// console.log(obj);
						    },
						    onChange: function (obj) {      // callback is called on every slider change
						       /// console.log(obj);
						    },
						    onFinish: function (obj) {      // callback is called on slider action is finished
						        fromPrice = obj.fromNumber;
						        toPrice = obj.toNumber;
						        loadQuirkyAt(source);
						    }
						}
					); 
					
					$("#catMenu").css({
						position : "absolute",
						top : "70",
						left : left_margin,
						width : 3*wrap_w+2*prod_gap
						//,'background-color':"yellow"
					});
					$(window).scrollTop(0);
					
					$("div[id^='menu_']").css("color","white");
					$("#menu_"+user_data.user_sk).css("color","yellow");
					
				},
				failuer : function(results){
				},
				beforeSend : function(results){
					$("#loading").empty();
					$("#loadingImg").css({
							"display":"block"
						});
					if(ajaxing) results.abort();
					if(!ajaxing) ajaxing=1;
				},
				complete : function(results){
					//$( "#midMain" ).empty();
					ajaxing = 0;
					$("#loading").empty();
					$("#loadingImg").css({
							"display":"none"
						});
				}
					
			});

} ///loadRandom end

function loadByKeyword(keyword){
	minPID = 100000;
	slider_w = 0;
	slider_h = 150;
	q1 = searchList;
	$(".product_wrap").remove();
	$(".slider").remove();
	$(".tempDiv").remove();
	$(document.body).append("<div class='tempDiv' style='width:900;position:absolute;top:120;left:200;font-size:x-large;'><a href='/'><b>X</b></a> Search Result for <b>" + keyword.toUpperCase()+"</b></div>");
	pin=1; ///don't scroll
	initPageNew(2);
} ///loadByKeyword end
			
function postNews(cmp){
	cmp = document.getElementById('news_letter');
	if($.trim(cmp.value).length){
	
		if(isValidEmailAddress( cmp.value )){
			$.ajax({
					url:"/main/news/email/"+cmp.value,
					success : function(results){
						result = $.parseJSON(results);
						if(result.EXISTS)
							cmp.value = 'You are already with Us!';
						else
							cmp.value = 'Thanks! Please check your email (junk as well)';	
					},
					failuer : function(results){
					},
					beforeSend : function(results){
					},
					complete : function(results){
					}
						
			});
			}
		else
			{
				cmp.value = "Sure it's an email!";
		}
	}
	else{
		cmp.value = "Send me Weekly Surprises @ this email Id";
	}

}//postNews ends
			
function isValidEmailAddress(emailAddress) {
    var pattern = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i);
    return pattern.test(emailAddress);
}; //isValidEmailAddress ends


function suggest(cmp){
	$("#suggestions").empty();
	$("#suggestions").append("<div onclick=\"document.getElementById('news_letter').value = $(this).text();document.getElementById('suggestions').style.display='none'\">"+cmp.value+"@gmail.com</div>");
	$("#suggestions").append("<div onclick=\"document.getElementById('news_letter').value = $(this).text();document.getElementById('suggestions').style.display='none'\">"+cmp.value+"@yahoo.com</div>");
	$("#suggestions").append("<div onclick=\"document.getElementById('news_letter').value = $(this).text();document.getElementById('suggestions').style.display='none'\">"+cmp.value+"@hotmail.com</div>");
	$("#suggestions").css({
		display:"block",
		'z-index':1000,
		'font-size':'small',
		"background-color":"white",
		position:"absolute",
		top:$("#news_letter").offset().top+20,
		left:$("#news_letter").offset().left
	});
	
	
	if(!$.trim(cmp.value).length) $("#suggestions").css({display:"none"});
}
				
function process(user){
	var buffer = new Array();
	var poped;
	var len = 0;
	var total = q1.length+q2.length+q3.length;
	//console.log(q1.length+','+q2.length+','+q3.length);
	if(user == 1){
		
		for(var i=0; i<total; i++)
		{
			poped = q1.pop();
			if (typeof poped != 'undefined')
			{
				for(var i=0; i< 9;i++){
					if(typeof buffer[i] == 'undefined') //if center is empty
					{
						buffer[i] = poped;
						break;
					}
				}
			}
		}	

	}
	else if(user == 2){
		
		for(var i=0; i<total; i++)
		{
			poped = q1.pop();
			if (typeof poped != 'undefined')
			{
				buffer[i] = poped;
			}
		}	

	}
	else
	{
		//while((q1.length+q2.length+q3.length))
		{	
		if(pageNum == 1){
			
			for(var i=0; i<9; i++)
			{
				poped = q1.pop();
				if (typeof poped != 'undefined')
				{
					for(var i=0; i< 9;i++){
						if(typeof buffer[i] == 'undefined') //if center is empty
						{
							buffer[i] = poped;
							break;
						}
					}
				}
			}	
		
		}
		else
		for(var i=0; i<3 && q1.length; i++)
		{
			if((q1.length+q2.length+q3.length)%19==0 && (q1.length+q2.length+q3.length)>0 && pageNum>1){
			//	console.log((q1.length+q2.length+q3.length));
			 buffer.push([
						-99*pageNum, 
						"Advertisement", 
						"", 
						"", 
						"", 
						1, 
						"", 
						0, 
						"", 
						1, 
						"", 1, 1, ""]);
			} 
			//else 
			poped = q1.pop();
			//console.log(q1.length);
			if (typeof poped != 'undefined')
			{
				for(var j=0; j< 9;j++){
					if(typeof buffer[1] == 'undefined') //if center is empty
					{
						buffer[1] = poped;
						len++;
						break;
					}
					else if(typeof buffer[4] == 'undefined') //if center is empty
					{
						buffer[4] = poped;
						len++;
						break;
					}
					else if(typeof buffer[7] == 'undefined') //if center is empty
					{
						buffer[7] = poped;
						len++;
						break;
					}
				}
			}
		}
		//console.log(q1.length+','+q2.length+','+q3.length);
		for(var i=len-1; i<7 && q2.length; i++)
		{
			if((q1.length+q2.length+q3.length)%19==0 && (q1.length+q2.length+q3.length)>0 && pageNum>1){
				//console.log((q1.length+q2.length+q3.length));
			 buffer.push([
						-99*pageNum, 
						"Advertisement", 
						"", 
						"", 
						"", 
						1, 
						"", 
						0, 
						"", 
						1, 
						"", 1, 1, ""]);
			} 
			//else 
			poped = q2.pop();
			if (typeof poped != 'undefined')
			{
				for(var i=0; i< 9;i++){
					if(typeof buffer[i] == 'undefined') //if center is empty
					{
						buffer[i] = poped;
						len++;
						break;
					}
				}
			}
		}
		//console.log(q1.length+','+q2.length+','+q3.length);
		for(var i=len-1; i<8 && q3.length; i++)
		{
			if((q1.length+q2.length+q3.length)%19==0 && (q1.length+q2.length+q3.length)>0 && pageNum>1){
				//console.log((q1.length+q2.length+q3.length));
			 buffer.push([
						-99*pageNum, 
						"Advertisement", 
						"", 
						"", 
						"", 
						1, 
						"", 
						0, 
						"", 
						1, 
						"", 1, 1, ""]);
			} 
			//else 
			poped = q3.pop();
			if (typeof poped != 'undefined')
			{
				for(var i=0; i< 9;i++){
					if(typeof buffer[i] == 'undefined') //if center is empty
					{
						buffer[i] = poped;
						break;
					}
				}
			}
		}
		}	
	}
	
	//console.log(q1.length+','+q2.length+','+q3.length);
	return buffer;
}
				
function initPageNew(user){
	var data = process(user);
	if(data.length)
		initPage(data);
	/*--- else
		getdata(); ---*/
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
		email = fbRes.email
		fb_id = fbRes.id;
	}
	else{
		
		email = document.getElementById("regis_email").value;
		password = document.getElementById("password").value;
		isEmailOk = isValidEmailAddress(email);
		isPasswordOk = password.length ;
		
		if(isEmailOk == false || isPasswordOk <7 ){
			$("#login_alert").append("Please provide valid email and 6+ long password");
			return;
		}
		
	}
	
	$.ajax({
		    type: 'POST',
		    url: '/main/register/',
		    data: { 
		        'email': email, 
		        'password': password,
		        'fb_id':fb_id,
		        'fb_resObj':fb_resObj
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
		    		location.reload();
		    	}
		    }
		});
 }
  
  function update(){
	var new_letter = document.getElementById("news_lettercb").checked?1:0 ;
	
  	$.ajax({
	    type: 'POST',
	    url: '/main/userUpdate/',
	    data: { 
	        'first_name': document.getElementById("first_name").value, 
	        'last_name': document.getElementById("last_name").value, // <-- the $ sign in the parameter name seems unusual, I would avoid it
	        'news_letter': new_letter,
	        'user_sk' : user_data.user_sk
	    },
	    success: function(res){
	    	var msg = "Updated!";
				$( "#topMessage" ).empty();
				$( "#topMessage" ).append(msg);
				
				$( "#topMessage" ).css(
					{
						"top":screen.height/2,
					"left":screen.width/2
					}
				);
				$( "#topMessage" ).fadeIn( 1000);
				
				$( "#topMessage" ).fadeOut( 2000, function() {
					$( "#topMessage" ).empty();
				});
	    }
	});
  }
  
  function logout(){
  	$.ajax({
	    type: 'POST',
	    url: '/main/logout/',
	    success: function(res){
	        location.reload();
	    }
	});
  }
  
  function login_validate(whatis,value){
 	if(whatis == 'email'){
 		if(!isValidEmailAddress(value)){
 			$("#regis_email").attr("value","Sure it's an email!'") ;
 		}
 	}
  }
  
  function checkEmail(email){
  	if(isValidEmailAddress(email)){
  		$.ajax({
	    type: 'POST',
	    url: '/user/checkEmail/email/'+email,
	    success: function(res){
	    	if(res.ISEXISTS){
	    	
	    	}
	    	else{
	    		$("#isExist").empty();
	    		$("#isExist").append("You are not with us yet.");
	    	}
	        location.reload();
	    }
	});
  	}
  }
  
  function getEmailAjax(ch,email){
  	if(ch == '@'){
  		$.ajax({
		    type: 'GET',
		    url: '/misc/getEmailAjax/email/'+email,
		    success: function(res){
		    	if(res.length){
		    		emailAjaxList.length = 0;
		    		emailAjaxList.push(res.toString().split(','));
		    	}
		    }
		});
  	}
  	
  }
  
  function checkExistingUser(email){
  	$("#isExist").empty();
  	if(isValidEmailAddress(email)){
	  	if($.inArray( email.toLowerCase(), emailAjaxList[0] ) >= 0){//exist
	  		
	  	}
	  	else{//not exist
	  		$("#isExist").append("Entering password will create NEW account with us");
	  	}
  	}
  	
  }
  
  function buildProdLists(ch, keyword){
  	if(keyword.length > 2){
  		searchList.length=0;
  		isSearching = 1;
  		$(main_products.Q1.DATA).each(function(idx,rec){
  			if(rec[1].toLowerCase().indexOf(keyword.toLowerCase())>=0){
  				searchList.push(rec);
  				return true;
  			}
  			else if(rec[2].toLowerCase().indexOf(keyword.toLowerCase())>=0){
  				searchList.push(rec);
  				return true;
  			}
  			else if(rec[13].toLowerCase().indexOf(keyword.toLowerCase())>=0){
  				searchList.push(rec);
  				return true;
  			}
  		});
  		$(main_products.Q2.DATA).each(function(idx,rec){
  			if(rec[1].toLowerCase().indexOf(keyword.toLowerCase())>=0){
  				searchList.push(rec);
  				return true;
  			}
  			else if(rec[2].toLowerCase().indexOf(keyword.toLowerCase())>=0){
  				searchList.push(rec);
  				return true;
  			}
  			else if(rec[13].toLowerCase().indexOf(keyword.toLowerCase())>=0){
  				searchList.push(rec);
  				return true;
  			}
  		});
  		$(main_products.Q3.DATA).each(function(idx,rec){
  			if(rec[1].toLowerCase().indexOf(keyword.toLowerCase())>=0){
  				searchList.push(rec);
  				return true;
  			}
  			else if(rec[2].toLowerCase().indexOf(keyword.toLowerCase())>=0){
  				searchList.push(rec);
  				return true;
  			}
  			else if(rec[13].toLowerCase().indexOf(keyword.toLowerCase())>=0){
  				searchList.push(rec);
  				return true;
  			}
  		});
  		loadByKeyword(keyword);
  		//console.log(searchList.length);
  		//console.log(keyword);
  		
  	}
  }
  
   function autoSearch(keyword){
  	$("#search_prod").val(keyword);
  	buildProdLists('',keyword);
  }
  
  function clearTemp(){
  	$(".tempDiv").remove();
  }
  
 <!---  function resetPassword(){
  	$("#isExist").empty();
  	
  	if($.inArray( email.toLowerCase(), emailAjaxList[0] ) >= 0){//exist
  		
  	}
  	else{//not exist
  		$("#isExist").append("Entering password will create NEW account with us");
  	}
  	
  } --->
</script>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-54318348-1', 'auto');
  ga('require', 'displayfeatures');
  ga('send', 'pageview');

</script>

<script>

<!--- window.fbAsyncInit = function() {
  FB.init({
    appId      : '282444375289959',
    cookie     : true,  // enable cookies to allow the server to access 
                        // the session
    xfbml      : true,  // parse social plugins on this page
    version    : 'v2.1' // use version 2.1
  })
  };
  
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk')); --->

  
  function statusChangeCallback(response) {
    console.log('statusChangeCallback');
    console.log(response);
    // The response object is returned with a status field that lets the
    // app know the current login status of the person.
    // Full docs on the response object can be found in the documentation
    // for FB.getLoginStatus().
    if (response.status === 'connected') {
      // Logged into your app and Facebook.
      testAPI();
    } else if (response.status === 'not_authorized') {
      // The person is logged into Facebook, but not your app.
      document.getElementById('status').innerHTML = 'Please log ' +
        'into this app.';
    } else {
      // The person is not logged into Facebook, so we're not sure if
      // they are logged into this app or not.
      document.getElementById('status').innerHTML = 'Please log ' +
        'into Facebook.';
    }
  };
  
  FB.getLoginStatus(function(response) {
    statusChangeCallback(response);
  });
  
   function checkLoginState() {
    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });
  };
  
  function testAPI() {
    console.log('Welcome!  Fetching your information.... ');
    FB.api('/me', function(response) {
      console.log('Successful login for: ' + response.name);
      document.getElementById('status').innerHTML =
        'Thanks for logging in, ' + response.name + '!';
    });
  }
  
  function loginFB(){
  	
  	FB.login(function(response){
	   FB.api('/me', function(response) {
	   		register(response);
	   });
	});
  
  }
  
</script>
<!----Needs to get rid of it--->
<!--- <cfquery name="slider" datasource="#application.dsn#">
SELECT sld.img, pm.title,pm.short_desc, pm.last_price, pm.idproduct_main
FROM `slider` sld, product_main pm 
where pm.idproduct_main = sld.prod_id and sld.`show`=1
</cfquery> --->
<cfparam name="thisPage" default="">
<cfsavecontent variable="menu_cf">
<cfif isdefined("session.user_sk") and len(session.user_sk)>
<a href="" onclick="return false;">
	<div class="menu_item" style="text-decoration:none;color:white;border:2px solid black" <cfoutput>onclick="clearTemp();fromPrice=0;toPrice=0;loadByUser('#session.user_sk#');" id="menu_#session.user_sk#"</cfoutput>>My Quirkies &nbsp;<img alt="" width="20" height="20" src="/resources/images/fav_fav.png"/>
</div>
</a>
</cfif>
<cfoutput query="request.view.menu">
			<a href="" onclick="return false;">
				<div class="menu_item" style="text-decoration:none;color:white;border:2px solid black" onclick="clearTemp();fromPrice=0;toPrice=0;loadByCat('#request.view.menu.id#');" id="menu_#request.view.menu.id#">#request.view.menu.name#</div>
			</a>
		</cfoutput>
</cfsavecontent>