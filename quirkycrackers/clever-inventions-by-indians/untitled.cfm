<!DOCTYPE html>
<html>
	<head>
		<cfparam name="url.id" default="1">
		<cfparam name="url.shared_pic" default="0">
		
		<cfset previous = url.id - 1>
		<cfset next = url.id + 1>
		<cfquery name="getall" datasource="product" cachedwithin="#createtimespan(1,0,0,0)#">
			select * from qc_links
		</cfquery>
		<cfquery name="current" dbtype="query">
			select * from getall
			where record_id = #url.id#
		</cfquery>
		<title>Add Quirk to Life : Online Crazy Unique Stuff / Gift Ideas for Indian Buyers</title>
		<meta name="viewport" content="width=device-width, initial-scale = 1.0, maximum-scale=1.0, user-scalable=no" />
		<meta name="keywords" 			content="Online, Crazy, Stuff, Unique, gift, geek, quirky, India, unique gift, online gift, gift online, online home decor, gift for the home, gift for home, online home accessories, gift stuff, home office decor, gift unique, a unique gift, home décor online, indian home decor, online gift for her, indian gift, new gift ideas, unique online gift, home accessories online, unique home ideas, unique home accessories, indian home accessories, gift shot glasses, decor home online, ideas for home office, shot glass gift, shot glasses gift, unique home decor online, shot glass online, shot glasses online, home decor indian, office decor online, indian home ideas, ideas home office, bar accessories online, indian shot glass, online shot glasses, home office gift ideas, gift ideas for home office, home accessories ideas, crazy shot glasses, home bar gift ideas, ideas for a home office, the dark knight tumbler, indian home decor online, gift for kids online, home decorative online, shot glass gift ideas, crazy home accessories, in home office ideas, at home office ideas, unique shot glasses gift, office home ideas, accessories gifts ideas, home decor stuff online, buy quirky gifts online india, painting ideas for indian homes, unique corporate gifts, unique birthday gift, unique gifts online, unique gifts for women, unique birthday gifts, unique gift items, unique gift catalog, unique wedding gift, unique gift for her, unique fathers day gifts, unique christmas gifts, gifts unique, unique gifts for dad, unique gift for wife, unique gifts for him, unique gift shops, unique gift for men, unique birthday gifts for her, unique gifts women, unique birthday gifts for men, unique mens gifts, unique engagement gifts, find unique gift, unique cool gifts, home decorating, modern home decor, home decorations, home decorating ideas, home decorating catalogs, home and decor, contemporary home decor, discount home decor, inexpensive home decor, home decor store, decorating your home, home decor magazine, home decor shopping, home decorative, buy home decor, home decor sale, home decor magazines, decoration home, decorations for home, home decorative items, home decor furniture, eclectic home decor, home decor furnishings, home decorating items, best home decor, gifts online, online gift shopping, online gift shop, buy gifts online, online gift stores, birthday gifts online, buy gift online, online gift delivery, online gift shops, wedding gifts online, send gifts online, send gift online, order gifts online, office gifts online, online gift sites, kids gift online, online gift shop for kids, birthday gift ideas, unusual gift ideas, gift ideas for boys, gift ideas for women, original gift ideas, cool gift ideas, gift ideas for girlfriend, ladies gift ideas, gift ideas for children, good gift ideas, gift ideas for christmas, small gift ideas, online gift ideas, best gift ideas, awesome gift ideas, gift ideas for boyfriend, gift ideas for husband, gift ideas for boyfriends, wife gift ideas, crazy gift ideas, wedding gifts ideas, interesting gift ideas, gift ideas for new boyfriend, gift ideas for a friend, coffee cup gift ideas, mothers day gifts, gifts to bangalore, gifts to delhi, gadget gifts, gifts for mom, strange gifts, gift for friend, gift for dad, gifts for teachers, gift sites, weird gifts, gift on line, original gifts, gift for father, gifts for brothers, gift for a friend, perfect gifts, creative gifts, gifts for girlfriends, special gifts for her, gift for kids, gifts for parents, gifts for couples, quirky gifts, return gifts, unique gift ideas, unique gift idea, unique birthday gift ideas, unique wedding gift ideas, unique gifts ideas, unique gift ideas for men, unique gift ideas for women, unique gift ideas for boyfriend, birthday gifts, birthday gift, birthday gift for her, birthday gifts for him, birthday gifts for her, special birthday gift, birthday gift for husband, birthday gift for boyfriend, birthday gift for wife, great birthday gifts, unusual birthday gifts, birthday gifts for boyfriend, best b

irthday gifts, cool birthday gifts, gift for children birthday, gift ideas for men, mens gift ideas, men gift ideas, gifts ideas for men, mens gifts ideas, cool gift ideas for men, perfect gift for boyfriend, boyfriend gifts, gifts for boyfriend, gift for boyfriend, gifts for my boyfriend, christmas gifts for boyfriend, gifts for boyfriends, gifts for a boyfriend, gift for my boyfriend, gifts for your boyfriend, special gifts for boyfriend, special gift for boyfriend, unique gifts for boyfriend, romantic gifts for boyfriend, anniversary gifts for boyfriend, good gifts for boyfriends, best gift for boyfriend, creative gifts for boyfriend, cute gifts for boyfriend, best gifts for boyfriend, unique valentine gifts, unique anniversary gifts, unique gifts for guys, unique mothers day gifts, unique gift item, unique gift for him, unique gift for women, unique gifts for her, unique gifts for husband, unique gifts for girls, unique luxury gifts, unique xmas gifts, unique cheap gifts, unique friendship gifts, unique gifts for friends, unique personalised gifts">
		<meta name="description" 		content="I bet you have not seen most of these 200+ historic pictures of India.">
		<meta property="og:title"   	content="Indian History in Pictures" />
		<cfif url.shared_pic eq 1>
			<cfoutput>
				<meta property="og:image"       content="#current.description#" /> 
				<meta property="og:description" content='#current.link#' /> 
			</cfoutput>
		<cfelse>
			<meta property="og:image"       content="http://quirkycrackers.com/quirkycrackers/indian-history-in-pictures/history.png" /> 
			<meta property="og:description" content="I bet you have not seen most of these 200+ historic pictures of India. Like Death sentence judgement poster of Bhagat Singh, Sukhdev, Rajguru and others, 1930." /> 
		</cfif>
		<link rel="stylesheet" type="text/css" href="../js/jquery-ui.min.css"/>
		<script language="javascript" src="../js/jquery-1.11.1.min.js"></script>
		<script language="javascript" src="../js/jquery-ui.min.js"></script>
		<script language="javascript" src="/quirkycrackers/js/jquery.resizecrop-1.0.3.min.js"></script>
		<link rel="stylesheet" type="text/css" href="/quirkycrackers/js/slick-master/slick/slick.css"/>
		<script language="javascript" src="/quirkycrackers/js/slick-master/slick/slick.min.js"></script>
		<script>
			var img_ration;
			var img_width;
			var img_height;
			$(document).ready(function(){
				$('.resize').resizecrop({
		      width:100,
		      height:100
		    }); 
		    
		    $('.bgimg').resizecrop({
		      width:100,
		      height:100
		    });
		    
		    $('.img_img').load(function(){
		    	img_width = $(".img_img")[0].width;
			    img_height = $(".img_img")[0].height;
			    $("#preview").show();
		    	if($(".img_img")[0].width > $(window).width()){
		    		img_ration = $(".img_img")[0].width/$(".img_img")[0].height;
			    	$('.img_img').css("width",$(window).width());
			    	$('.img_img').css("width",$(window).width()/img_ration);
		    	}
		    	
		    });
		    $("#preview2").css("width",$(window).width());
		    $(".img").css("width","100%"); 
		    $(".img").css("max-width",$(window).width());
		     $(".img").css("overflow","auto");
		     $("#preview").css("left",$(window).width()*.05);
		     $(".topcont").css("max-width",$(window).width());
		     $("#previewtop").css("max-width",$(window).width());
		     $('.slider').slick({
		  		infinite: true,
				  slidesToShow: 1,
				  slidesToScroll: 1,
				  //lazyLoad: 'ondemand',
				  //centerMode: true,
				  //centerPadding: '60px',
				  //slidesToShow: 3,
				  autoplay: true,
				  autoplaySpeed: 5000,
				  //slidesToShow: 1,
				  arrows: false,
				  dots:true
				});
			var left = $(window).width()/2-150;
			
			$(".slider").css("left",left);
		});
			
			function enlarge(){
				$('.img_img').css("width",img_width);
			    $('.img_img').css("width",img_height);
			}
		</script>
		<style>
		 #preview {
		 	width:90%;
		 	position:relative;
		 	max-height:100px;
		 	overflow:auto;
		 }
		 #previewtop {
		 	max-height:100px;
		 	overflow:auto;
		 	width:1100px;
		 }
		  #preview2 {
		 	position:fixed;
		 	top:0px;
		 	left:0px;
		 	z-index:2;
		 }
		 .bgimg{
		 	opacity:1;
		 	display:block;
		 	float:left;
		 }
		</style>
	</head>
	<body>
		<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.5&appId=1684862888425977";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

		
		<script>
	  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	
	  <cfoutput>ga('create', 'UA-54318348-1', 'auto');</cfoutput>
	  ga('require', 'displayfeatures');
	  ga('send', 'pageview');
	
	</script>
		<cfoutput>
			<div style="width:100%;text-align:center;font-size:x-large;">
			Indian History in Pictures
			</div>
			<div style="width:100%;text-align:center;font-size:small;color:red">
			On Mobile, tap image for actual size. And don't forget to share this awesome collection!
			</div>
			<table style="text-align:center;align:center;width:100%;">
				<tr><td>
					<cfif previous gt 0><span style="border-right:5px solid white;"><a href="./?id=#previous#">Previous</a></span></cfif>
					<cfif next lte 216><span style="border-left:5px solid white;"><a href="./?id=#next#">Next</a></span></cfif>
					<span><div class="fb-share-button" data-href="http://quirkycrackers.com/quirkycrackers/indian-history-in-pictures/?utm_source=share_from_site&utm_medium=fb_share&utm_campaign=indiahistory" data-layout="button"></div></span>
					<span><div class="fb-like" data-href="https://www.facebook.com/tumsenahopaye/" data-layout="button_count" data-action="like" data-show-faces="false" data-share="false"></div></span>
				</td></tr>
				<tr>
					<td style="background-color:black;color:white;">#current.link#</td>
				</tr>
				<tr>
					<td class="img" style="color:white;"><img onclick="enlarge();" src="#current.description#" class="img_img"></td>
				</tr>
				<tr>
					<td>
						Like or Share This Pic
						<span><div class="fb-share-button" data-href="http://quirkycrackers.com/quirkycrackers/indian-history-in-pictures/?id=#url.id#&shared_pic=1&utm_source=share_from_site&utm_medium=fb_share&utm_campaign=indiahistory" data-layout="button"></div></span>
						<span><div class="fb-like" data-href="http://quirkycrackers.com/quirkycrackers/indian-history-in-pictures/?id=#url.id#&shared_pic=1&utm_source=share_from_site&utm_medium=fb_share&utm_campaign=indiahistory" data-layout="button_count" data-action="like" data-show-faces="false" data-share="false"></div></span>
					</td>
				</tr>
				<tr><td>
					<div style="width:100%;text-align:center;">
						<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
						<!-- FTB_ADAP -->
						<ins class="adsbygoogle"
						     style="display:block"
						     data-ad-client="ca-pub-9042848322034372"
						     data-ad-slot="2771478442"
						     data-ad-format="auto"></ins>
						<script>
						(adsbygoogle = window.adsbygoogle || []).push({});
						</script>
					</div>
				</td></tr>
				<tr>
					<td>
						<div class="topcont">
							<div id="previewtop">
								<cfoutput>
								<cfloop from="#url.id+1#" to="#url.id+10#" index="idx">
									<span title="#getall.link[idx]#"><a href="./?id=#getall.record_id[idx]#"><img src="#getall.description[idx]#"  class="resize"></a></span>
									<!--- <cfif idx eq 5>
										<span style="border:1px solid black"><script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
										<!-- text dis small -->
										<ins class="adsbygoogle"
										     style="display:inline-block;width:125px;height:125px"
										     data-ad-client="ca-pub-9042848322034372"
										     data-ad-slot="9554540843"></ins>
										<script>
										(adsbygoogle = window.adsbygoogle || []).push({});
										</script></span>
									</cfif> --->
								</cfloop>
								</cfoutput>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</cfoutput>
		<div style="width:100%;text-align:center;max-height:200px;overflow:auto;">
			<cfoutput><div class="fb-comments" data-href="http://quirkycrackers.com/quirkycrackers/indian-history-in-pictures/?id=#url.id#&shared_pic=1&utm_source=share_from_site&utm_medium=fb_share&utm_campaign=indiahistory" data-numposts="5"></div></cfoutput>
		</div>
		<div id="preview">
			<div style="width:1000px">
				<ul>
			<cfoutput query="getall">
				<li><span title="#getall.link#"><a href="./?id=#getall.record_id#">#getall.link#<!--- <img src="#getall.description#"  class="resize"> ---></a></span></li>
			</cfoutput>
			</ul>
			<!--- <div>
				<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
				<!-- text links -->
				<ins class="adsbygoogle"
				     style="display:inline-block;width:468px;height:15px"
				     data-ad-client="ca-pub-9042848322034372"
				     data-ad-slot="2986630046"></ins>
				<script>
				(adsbygoogle = window.adsbygoogle || []).push({});
				</script>
			</div> --->
			<!--- <cfoutput query="getall">
				<span title="#getall.link#"><a href="./?id=#getall.record_id#"><img src="#getall.description#"  class="resize"></a></span>
			</cfoutput> --->
			</div>
		</div>
		<div style="height:25px"></div>
		<div style="width:90%;text-align:center;border-bottom:5px solid white;font-size:x-small;">Hosted at: <a href="http://www.quirkycrackers.com/?utm_source=modiji_qc&utm_medium=self&utm_campaign=indianhistory" >QuirkyCrackers</a> | Supported By: <a href="http://www.findtrackbuy.com/?utm_source=modiji_ftb&utm_medium=self&utm_campaign=indianhistory" >FindTrackBuy</a> | <!--- <a href= "https://www.facebook.com/sufyan.sadiq"> --->FB Credit - Sufyan Sadiq<!--- </a> ---></div>
<table style="width:100%"><tr><td style="text-align:center;">
<div class="slider" style="width:300px">
			<cfquery name="slider" datasource="product" >
					SELECT sld.img, pm.title,pm.short_desc, pm.last_price, pm.idproduct_main,
					CONCAT(pm.link,coalesce(si.affiliateParam, '')) as link
					FROM slider sld left join product_main pm 
					on sld.prod_id = pm.idproduct_main
					left join prod_sources si
					on pm.source_id = si.idprod_sources 
					where sld.`show`=1
					limit 0,5
			</cfquery>
			<cfoutput query="slider">
					<cfif slider.idproduct_main eq -1>
						<div id="slider_#slider.idproduct_main#" class="slideContent" style="position:relative;display:block;border:0px solid black;text-align:center;">
						<!--- <div style="position:fixed;top:100px;left:0;">#slider.title#</div> --->
							<img class="mustLoad" alt="" src="/quirkycrackers/resources/images/slider/#slider.img#"/>
						<div style='position:absolute;top:10;right:0;text-align:center;width:300px;font-family: "Anton", sans-serif;'>
						</div>
						</div>
					<cfelse>
						<cfif slider.idproduct_main neq -2>
						<div id="slider_#slider.idproduct_main#" class="slideContent" style="position:relative;display:block;border:0px solid black;;text-align:center;">
								<!--- <div style="position:fixed;top:100px;left:0;">#slider.title#</div> --->
								<a href="http://www.quirkycrackers.com/?utm_source=modiji_qc&utm_medium=self&utm_campaign=indianhistory" target="_blank" onclick="clickLog(#slider.idproduct_main#);">
									<img class="mustLoad" alt="" width="300px" height="200px" data-lazy="/quirkycrackers/resources/images/slider/#slider.img#"/>
								</a>
								<div style='position:relative;top:-30px;border: 2px solid;border-radius: 5px;left:1px;background:white;text-align:center;font-family: "Anton", sans-serif;'>
									<div class='slid_title' style="font-family: 'Anton', sans-serif;font-size:small;">
										#slider.title#
										<cfif len(slider.last_price)>
											<cfif slider.last_price eq 0> -CONCEPT<cfelse> -Rs. #slider.last_price#*</cfif>
									</cfif>
									</div>
									<!--- <div class='slid_desc' style="text-align:left;">
										<h3>#slider.short_desc#</h3>
									</div> --->
									
								</div>
						</div>
						</cfif>
					</cfif>
				</cfoutput>
		</div>
</td></tr></table>	
<!--- <div id="preview2">
				<!--- <ul>
			<cfoutput query="getall">
				<li><span title="#getall.link#"><a href="./?id=#getall.record_id#">#getall.link#<!--- <img src="#getall.description#"  class="resize"> ---></a></span></li>
			</cfoutput>
			</ul> --->
			<cfoutput query="getall">
				<img src="#getall.description#"  class="bgimg">
			</cfoutput>
		</div> --->
	</body>
</html>
