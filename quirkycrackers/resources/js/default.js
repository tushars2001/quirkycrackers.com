function defaults(){
		
	$('.slider').slick({
	  lazyLoad: 'ondemand',
	  autoplay: true,
	  autoplaySpeed: 12000,
	  slidesToShow: 1,
	  arrows: true
	});
	
	$.ajax({
		url:"/main/getProducts/param/"+(new Date()),
		success : function(results){
			products = $.parseJSON(results);
		},
		failuer : function(results){
		},
		beforeSend : function(results){
			$('#midMain').prepend('<table id="loading" width="100%"><tr><td align="center" height="600px"><img src="/resources/images/ajax-loading.gif" /></td></tr></table>');
		},
		complete : function(results){
			$( "#midMain" ).empty();
			initload=1;
			initPage();
		}
			
	});

	scrollLeft = $(window).scrollLeft();
	
	window.onresize = resize;
		
	$(".slider").css({
		"left":left_margin,
		"width":slider_w,
		"height": slider_h
	});
	
	$(".mainBanner").css({
		"left":(left_margin+400)
	});
	
	$(".slideContent").mouseover(function(){
		
	});
	
	$(".slideContent").mouseout(function(){
		
	});

}

initPage = function(){
		//$("#midMain").append('<div class="fb-like" style="position:absolute; top:-30px" data-href="https://www.facebook.com/tumsenahopaye" data-layout="standard" data-action="like" data-show-faces="true" data-share="true"></div>');
		for(i=0; i<products.ROWCOUNT; i++){
			
			if(products.DATA.idproduct_main[i] < minPID)
				minPID = products.DATA.idproduct_main[i];
				
			$("#midMain").append('<div class="product_wrap" style="position:relative" id="product_'+products.DATA.idproduct_main[i]+'"></div>');
			
			$("#product_"+products.DATA.idproduct_main[i]).append(
				'<div class="product_title" style="background-color:black;border:5px solid black;color:white;text-decoration:none;" id="product_title_'+products.DATA.idproduct_main[i]+'"><b><a target="_blank" href="/product/page/show/'+products.DATA.idproduct_main[i]+'" style="text-decoration: none;color:white;">'+products.DATA.title[i]+'</a></b></div>'
			);//background-color:#3b5998
			
			$("#product_"+products.DATA.idproduct_main[i]).append(
				'<a href="'+products.DATA.link[i]+'" target="_blank"><div class="product_img" id="product_img_'+products.DATA.idproduct_main[i]+'"><img width="300px" height="200px"  src="'+products.DATA.img_source[i]+'"></div></a>'
			);
			
			$("#product_"+products.DATA.idproduct_main[i]).append(
				'<div class="product_price" style="background-color:#3b5998;position:absolute;top:215;left:0;height:20px;border:3px solid #3b5998;color:white;" id="product_price_'+products.DATA.idproduct_main[i]+'"><img alt="" src="/resources/images/rs.png"/>'+products.DATA.last_price[i]+' </div>'
			);
			$("#product_"+products.DATA.idproduct_main[i]).append(
				'<div class="product_desc" style="position:absolute;top:240;left:0;" id="product_desc_'+products.DATA.idproduct_main[i]+'">'+products.DATA.short_desc[i]+' </div>'
			);
			$("#product_"+products.DATA.idproduct_main[i]).append(
				'<div class="product_ratings" style="background-color:white" id="product_price_'+products.DATA.idproduct_main[i]+'"></div>'
			);
			
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
			
			$("#_mainLogo").effect("size",{to:{height:'60',width:'750'}},150,function(){
				$('#_mainLogo').css("width",750);
	  			$('#_mainLogo').css("height",60);
			});
		}
	} 
    positionProducts();
} //resize ends

function runEffect(option1,option2,zoom) {
      var selectedEffect = "size";
 
       $("#_mainLogo").effect( selectedEffect, option2, 150,function(){
      	$('#_mainLogo').css("width",option2.to.width);
      	$('#_mainLogo').css("height",option2.to.height); 
      	
      	
      });
} //runEffect ends --->

var positionProducts = function(){
			
	if(left_margin < 0) left_margin=0;
	$(".product_wrap").each(function(idx,rec){
		
		var pos = (function(row,col){
			return {'top':(row-1)*370+slider_h,'left': ((col-1)*(wrap_w+prod_gap)+left_margin)};						
		})(
				(function(num){
						return Math.ceil(num/3);
				})(idx+1),
				(function(num){
					if(num % 3 == 0) return 3;
					if((num+1) % 3 == 0) return 2;
					if((num+2) % 3 == 0) return 1;
				})(idx+1)
			);
			
		$("#"+rec.getAttribute("id")).css({
			"top":pos.top,
			"left":pos.left
		});
		
		var $rate = $('#rating').clone();
		$rate.attr('id', "rating_"+rec.getAttribute("id"));
		$rate.css({
			"top":pos.top+80+115,
			"left":pos.left+150-40+15,
			"display":"none"
		});
		
		
		$rate.mouseover(function(){
				$(this).css("display","block");
			});
			
			$rate.mouseout(function(){
				$(this).css("display","none");
			});
		
		$rate.click(function(){shareFB(rec.getAttribute("id").split("_")[1]);});
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

}; //positionProducts ends