<script language="javascript">


	
$( document ).ready(function() {
				try{
					//window.requestAnimationFrame = true;
					vendors.length=0;
				}catch(e){}
				$("#mainLoad").remove();
				$("#containerTop").show();
				$("#menu_head").css({"top":$(window).height()/2-$("#menu_head").height()/2,"left":0,"display":"block"});
				$("#loginBar").css({"top":$(window).height()/2-$("#loginBar").height()/2,"right":0,"display":"block"});
				$("#loginContent").css({"top":$(window).height()/2-$("#loginContent").height()/2});
				$("#menu_items").css({"top":$(window).height()/2-$("#menu_items").height()/2});
				$("#lsw").css({"top":$(window).height()/2-$("#lsw").height()/2});
				$("#lsw").css({"left":$(window).width()/2-$("#lsw").width()/2});
	
				$('#containerMain').css("top",$("#containerTop").height()+20);
				$("#containerMain").css("min-width",(wrap_w+20)*3-50);
				$('#midMain').css("top",0);
				$( "#loadingImg" ).css({"top":$(window).height() - 143,"left":$(window).width()/2 - 75});
				$( "#loadingImgRandom" ).css({"top":$(window).height() - 143,"left":$(window).width()/2 - 75});
				$('#loadingImgRandom').css({top:'20%',left:'50%',margin:'-'+($('#loadingImgRandom').height() / 2)+'px 0 0 -'+($('#loadingImgRandom').width() / 2)+'px'});
				$('.slider').slick({
				  lazyLoad: 'ondemand',
				  autoplay: true,
				  autoplaySpeed: 6000,
				  slidesToShow: 1,
				  arrows: false,
				  dots:true
				});

				$.ajax({
					url:"/main/getProducts/param/123",
					success : function(results){
						products = $.parseJSON(results);
						if(typeof main_products == 'undefined') main_products = products;
						q1 = $.parseJSON(results).Q1.DATA;
						q2 = $.parseJSON(results).Q2.DATA;
						q3 = $.parseJSON(results).Q3.DATA;
						initPageNew();
					},
					failuer : function(results){
					},
					beforeSend : function(results){
						$("#loadingImg").css({
							"display":"block"
						});
					},
					complete : function(results){
						initload=1;
						$("#loadingImg").css({
							"display":"none"
						});
						
						<cfoutput>
						<cfif isdefined("request.vars.keyword") and len(trim(request.vars.keyword))>
							autoSearch('#request.vars.keyword#');
						</cfif>
						<cfif isdefined("request.vars.participate") and len(trim(request.vars.participate))>
							login();
						</cfif>
						
						</cfoutput>
						<cfif (isdefined("request.vars.loggedIn") and len(request.vars.loggedIn)) or isdefined("session.user_detail")>
						<cfelse>
						$("#cover").show();
						$("#lsw").show();
						</cfif>
					}
						
				});
				
			  $(window).scroll(fnOnScroll); 
				    
			  window.onresize = resize;
				
				$("#aboutUs").css({
					"position": "fixed",
					"top":(function(){return ($(window).scrollTop()+80);})(),
					"left":(function(){return $(window).width()*(.1)})(),
					"display":"none",
					"overflow": "auto",
					"height":"550px",
					"width":(function(){return $(window).width()*(.8)})(),
					"background-color":"white",
					"z-index":5000,
					"min-width":500,
					"border":"5px solid black"
					
				});
				
				$("#contactUs").css({
					"position": "fixed",
					"top":(function(){return ($(window).scrollTop()+80);})(),
					"left":(function(){return $(window).width()*(.1)})(),
					"display":"none",
					"height":"300px",
					"width":(function(){return $(window).width()*(.8)})(),
					"background-color":"white",
					"z-index":5000,
					"min-width":200,
					"border":"5px solid black"
					
				});
				
				$("#privacy").css({
					"position": "fixed",
					"top":(function(){return ($(window).scrollTop()+80);})(),
					"left":(function(){return $(window).width()*(.1)})(),
					"display":"none",
					"overflow": "auto",
					"height":"200px",
					"width":(function(){return $(window).width()*(.8)})(),
					"background-color":"white",
					"z-index":5000,
					"min-width":500,
					"border":"5px solid black"
					
				});
				
				$("#contentRemoval").css({
					"position": "fixed",
					"top":(function(){return ($(window).scrollTop()+80);})(),
					"left":(function(){return $(window).width()*(.1)})(),
					"display":"none",
					"overflow": "auto",
					"height":"500px",
					"width":(function(){return $(window).width()*(.8)})(),
					"background-color":"white",
					"z-index":5000,
					"min-width":500,
					"border":"5px solid black"
					
				});
				
				$("#resetPassword").css({
					"position": "fixed",
					"top":(function(){return ($(window).scrollTop()+80);})(),
					"left":(function(){return $(window).width()*(.1)})(),
					"display":"none",
					"overflow": "auto",
					"height":"500px",
					"width":(function(){return $(window).width()*(.8)})(),
					"background-color":"white",
					"z-index":5000,
					"max-width":500,
					"max-height":200,
					"border":"5px solid black"
					
				});
				
				if (!cssua.ua.mobile || 1) {
					$(".slider").css({
						"left":left_margin-75,
						"width":600,
						"height": 404
					});
				}
				else{
					$(".slider").remove();
					slider_w = 0;
					slider_h = 0;
							runEffect({ to: { height: "32px",'font-size': '100%' } },
		  					{to:{height:'24',width:'282'}}
		  			);
		  			<!--- $("div#minishare").css("top","32"); --->
		  			$("#containerTop").css("position","fixed");
		  			$("#containerTop").css("top","0");
				}
				
				$(".mainBanner").css({
					"left":(left_margin+400)
				});
				
				$(".menu_item").mouseover(function(){
					$(this).css("color","yellow");
				});
				
				$(".menu_item").mouseout(function(){
					
					if($(this).attr("id").indexOf(catId) == -1)
					$(this).css("color","white");
				});
				
				$.miniShare( { 
				    message: "Spread the Word"
				});
				
				$(".menu_item").css("text-decoration","none");
				
				$('#menu_head').click(fnmenu_head);
				
				$('#loginBar').click(fnloginBar);
				
				$('#topLogin').css({top:screen.height/2,left:screen.width/2});
				$('#topLogout').css({top:screen.height/2+50,left:screen.width/2});
				
				<cfoutput query="slider">
					<cfif slider.idproduct_main neq -1>
					var $rate = $('##rating').clone();
					
					var display_d = "block";
					if (cssua.ua.mobile) {
								display_d = "block";
					}		
							
					$rate.attr('id', "##slider_share_#slider.idproduct_main#");
					$rate.css({
						"display":display_d,
						"top":0,
						"left":0
					});
					 
					<cfif slider.last_price neq 0>
						$("##slider_#slider.idproduct_main#").append($rate);
					</cfif>
					</cfif>
				</cfoutput>
				
				$('img.mustLoad').on('load',function(){
				        $('.slideContent').css("display","block");
				});
				try{
					//$("#slider_-1").css({"left":(slider_w/2-450/2)});
				} catch(e){
				
				}
				$("#miniFB").prepend($("div#minishare"))
				loginApply();
				try{ start(); } catch(e){ }
								
			}); //----on ready end
</script>
<style>
.pluginButton {
	background:red;
}
</style>