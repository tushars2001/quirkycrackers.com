function fit(){
			
	$(".product_img").each(function(idx,rec){
			
			var thisImg = $(rec).find('img');
			var width = $(thisImg).width();    // Current image width
			var height = $(thisImg).height();  // Current image height
			
			 // Check if the current width is larger than the max
	        if(width > 300){
	            ratio = 300 / width;   // get ratio for scaling image
	            $(thisImg).css("width", 300); // Set new width
	            $(thisImg).css("height", height * ratio);  // Scale height based on ratio
	            height = height * ratio;    // Reset height to match scaled image
	            width = width * ratio;    // Reset width to match scaled image
	        }
	
	        // Check if current height is larger than max
	        if(height > 200){
	            ratio = 200 / height; // get ratio for scaling image
	            $(thisImg).css("height", 200);   // Set new height
	            $(thisImg).css("width", width * ratio);    // Scale width based on ratio
	            width = width * ratio;    // Reset width to match scaled image
	            height = height * ratio;    // Reset height to match scaled image
	        }
			
		});

} //fit ends

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