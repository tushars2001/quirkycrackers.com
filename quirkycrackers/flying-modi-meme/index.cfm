<!DOCTYPE html>
<cfif isdefined("url.utm_source") and isdefined("url.utm_medium") and isdefined("url.utm_campaign") and isdefined("url.email_id")>
	
	<cfif url.utm_medium eq  "email_r">
		<cftry>
			<cfquery name="getall" datasource="product">
				update email_random set accessed=accessed+1
				where 
				email_id =  '#url.email_id#'
				and campagin='modimeme'
			</cfquery>
		<cfcatch>
		</cfcatch>
		</cftry>
		
		<cfif isdefined("url.active") and url.active eq 0>
			<cftry>
				<cfquery name="getall" datasource="product">
					update email_random set active=0
					where 
					email_id =  '#url.email_id#'
				</cfquery>
			<cfcatch>
			</cfcatch>
			</cftry>
		</cfif>
		
	<cfelse>
		<cfif len(url.email_id)>
			<cftry>
				<cfquery name="getall" datasource="product">
					update email_campaign set accessed=accessed+1
					where 
					email_id =  '#url.email_id#'
					and campagin='modimeme'
				</cfquery>
			<cfcatch>
			</cfcatch>
			</cftry>
		</cfif>	
	</cfif>
	
</cfif>
<html>
	<head>
		<cfparam name="url.id" default="1">
		<cfparam name="url.shared_pic" default="0">
		
		<cfset previous = url.id - 1>
		<cfset next = url.id + 1>
		<cfquery name="getall" datasource="product" cachedwithin="#createtimespan(1,0,0,0)#">
			select * from qc_links_modimeme
		</cfquery>
		<cfquery name="current" dbtype="query">
			select * from getall
			where record_id = #url.id#
		</cfquery>
		<title>Add Quirk to Life : Online Crazy Unique Stuff / Gift Ideas for Indian Buyers</title>
		<meta name="viewport" content="width=device-width, initial-scale = 1.0, maximum-scale=1.0, user-scalable=no" />
		<meta name="keywords" 			content="modi meme,india, indian, india history, indian history, gandhi, nehru, dhoni, dhoni boy, bhagat singh">
		<meta name="description" 		content="Funny Flying Modi Meme.">
		<meta property="og:title"   	content="Funny Flying Modi Meme" />
		<cfif url.shared_pic eq 1>
			<cfoutput>
				<meta property="og:image"       content="#current.link#" /> 
				<meta property="og:description" content='#current.description#' /> 
			</cfoutput>
		<cfelse>
			<meta property="og:image"       content="http://quirkycrackers.com/quirkycrackers/indian-history-in-pictures/history.jpg" /> 
			<meta property="og:description" content="Funny Flying Modi Meme." /> 
		</cfif>
		<script language="javascript" src="ccua.min.js"></script>
		
		<!--- <link rel="stylesheet" type="text/css" href="../js/jquery-ui.min.css"/> --->
		<!--- <script language="javascript" src="../js/jquery-1.11.1.min.js"></script> --->
		<script language="javascript" src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
		<!--- <script language="javascript" src="../js/jquery-ui.min.js"></script> --->
		<!--- <script language="javascript" src="/quirkycrackers/js/jquery.resizecrop-1.0.3.min.js"></script> --->
		<script language="javascript" src="https://resize-crop.googlecode.com/files/jquery.resizecrop-1.0.3.min.js"></script>
		<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/jquery.slick/1.5.9/slick.css"/>
		<script type="text/javascript" src="//cdn.jsdelivr.net/jquery.slick/1.5.9/slick.min.js"></script>
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
		    <cfif isdefined("url.active") and url.active eq 0>
				alert("You are unsubscribed!")
			</cfif>
		    $(".img_img").one("load", function() {
			  
		    	img_width = $(".img_img")[0].width;
			    img_height = $(".img_img")[0].height;
			    $("#preview").show();
		    	if($(".img_img")[0].width > $(window).width()){
		    		img_ration = $(".img_img")[0].width/$(".img_img")[0].height;
			    	$('.img_img').css("width",$(window).width()*.9);
			    	$('.img_img').css("height",$(window).width()*.9/img_ration);
		    	}
		    	$(".img").css("width","100%"); 
		    	var g3 = '		<div style="width:100%;text-align:center;">'
						+'<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"><\/script>'
						
						+'<ins class="adsbygoogle"'
						+'     style="display:block"'
						 +'    data-ad-client="ca-pub-9042848322034372"'
						  +'   data-ad-slot="2771478442"'
						   +'  data-ad-format="auto"></ins>'
						+'<script>'
						+'(adsbygoogle = window.adsbygoogle || []).push({});'
						+'<\/script>'
					+'</div>';
			$(".goog_ad_top").append(g3);
		    	if (!cssua.ua.mobile) {
				 $(".goog_ad_desktop").empty();
				 $(".goog_ad_desktop").width(($(window).width()-$(".img_img").width())/2);
				 $(".goog_ad_desktop").width($(".goog_ad_desktop").width()*.9);
				 $(".goog_ad_desktop").height($(".img_img").height());
				 $(".goog_ad_desktop").show();
				 var g1 = '<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"><\/script>'
							+'			<ins class="adsbygoogle"'
							+'			     style="display:block"'
							+'			     data-ad-client="ca-pub-9042848322034372"'
							+'			     data-ad-slot="2771478442"'
							+'			     data-ad-format="auto"></ins>'
							+'			<script>'
							+'			(adsbygoogle = window.adsbygoogle || []).push({});'
							+'			<\/script>';
							
					var g2 = '		<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"><\/script>'
							+'<ins class="adsbygoogle"'
							+'     style="display:block"'
							 +'    data-ad-client="ca-pub-9042848322034372"'
							 +'    data-ad-slot="6901478845"'
							  +'   data-ad-format="auto"></ins>'
							+'<script>'
							+'(adsbygoogle = window.adsbygoogle || []).push({});'
							+'<\/script>';
							
					
					
				  
				  $($(".goog_ad_desktop")[0]).append(g2);
				  setTimeout(function(){
				  	$($(".goog_ad_desktop")[1]).append(g2);
				  },1000);
				  
				}
		    	
			}).each(function() {
			  if(this.complete) $(this).load();
			});

		    <!--- $('.img_img').load(function(){
		    	
		    }); --->
		    $("#preview2").css("width",$(window).width());
		    
		    //$(".img").css("max-width",$(window).width());
		     //$(".img").css("overflow","auto");
		     $("#preview").css("left",$(window).width()*.05);
		     $(".topcont").css("max-width",$(window).width());
		     //$("#previewtop").css("max-width",$(window).width());
		     $('.slider').slick({
		  		  infinite: true,
				  slidesToShow: 1,
				  slidesToScroll: 1,
				  autoplay: true,
				  autoplaySpeed: 3000,
				  arrows: false
				});
			var left = $(window).width()/2-150;
			
			$(".slider").css("left",left);
		});
			
			function enlarge(){
				$('.img_img').css("width",img_width);
			    $('.img_img').css("height",img_height);
			}
		</script>
		<style>
		body{
			margin:0;
		}
		 #preview {
		 	width:90%;
		 	position:relative;
		 	max-height:100px;
		 	overflow:auto;
		 	border:1px solid black;
		 	border-radius: 15px;
		 }
		 .goog_ad_desktop{
		 	display:none;
		 }
		 #previewtop {
		 	max-height:100px;
		 	overflow:auto;
		 	width:100%;
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
			<!----<div style="width:100%;text-align:center;background-color:yellow;color:red;font-weight:bold;">
			<a href="../../modiji/" target="_blank" style="text-decoration:none;color:red;">Where is Modiji</a>
			</div>---->
			<div style="width:100%;text-align:center;font-size:x-large;">
			Funny Flying Modi Meme
			</div>
			<div style="width:100%;text-align:center;font-size:small;color:white;background-color:blue;">
			<a style="text-decoration:none;color:white;" href="http://quirkycrackers.com/quirkycrackers/flying-modi-by-indians/?utm_source=flying-modi&utm_medium=website&utm_campaign=raresachin">20 Clever Indian Inventions</a>
			</div>
			<div style="width:100%;text-align:center;font-size:small;color:red;background-color:yellow;">
			<a style="text-decoration:none;color:red;font-weight:bold;" href="http://quirkycrackers.com/quirkycrackers/indian-history-in-pictures/?utm_source=flying-modi&utm_medium=website&utm_campaign=indiahistory">Rarest of Rare Indian History Pics (200+)</a>
			</div>
			<div style="width:100%;text-align:center;font-size:small;color:red;background-color:blue;">
			<a style="text-decoration:none;color:white;font-weight:bold;" href="http://quirkycrackers.com/quirkycrackers/rarest-of-rare-sachin/?utm_source=flying-modi&utm_medium=website&utm_campaign=indiahistory">Rarest of Rare Sachin's Pic</a>
			</div>
			<div style="width:100%;text-align:center;font-size:small;color:red">
			On Mobile, tap image for actual size. And don't forget to share this awesome collection!
			</div>
			<table style="text-align:center;align:center;width:100%;">
				<tr><td class="goog_ad_top">
					
				</td></tr>
				<tr><td>
					<cfif previous gt 0><span style="border-right:5px solid white;"><a href="./?id=#previous#">Previous</a></span></cfif>
					<cfif next lte getall.recordcount>
						<span style="border-left:5px solid white;"><a href="./?id=#next#">Next</a></span>
					<cfelse>
						<span style="border-left:5px solid white;"><a href="../rarest-of-rare-sachin/?utm_source=flying-modi&utm_medium=next&utm_campaign=indiahistory">Next Post</a></span>
					</cfif>
					<span><div class="fb-share-button" data-href="http://quirkycrackers.com/quirkycrackers/flying-modi-meme/?utm_source=share_from_site&utm_medium=fb_share&utm_campaign=modimeme" data-layout="button"></div></span>
					<span><div class="fb-like" data-href="https://www.facebook.com/tumsenahopaye/" data-layout="button_count" data-action="like" data-show-faces="false" data-share="false"></div></span>
				</td></tr>
				<tr>
					<td style="background-color:black;color:white;">#current.description#</td>
				</tr>
				<tr>
					<td class="img" style="color:white;text-align:center;overflow: hidden;">
						<table style="width:100%;text-align:center;">
							<tr>
								<td>
									<div class="goog_ad_desktop">
										
									</div>
								</td>
								<td>
									<img onclick="enlarge();" src="#current.link#" class="img_img">
								</td>
								<td>
									<div class="goog_ad_desktop">
										
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						Like or Share This Pic
						<span><div class="fb-share-button" data-href="http://quirkycrackers.com/quirkycrackers/flying-modi-meme/?id=#url.id#&shared_pic=1&utm_source=share_from_site&utm_medium=fb_share&utm_campaign=modimeme" data-layout="button"></div></span>
						<span><div class="fb-like" data-href="http://quirkycrackers.com/quirkycrackers/flying-modi-meme/?id=#url.id#&shared_pic=1&utm_source=share_from_site&utm_medium=fb_share&utm_campaign=modimeme" data-layout="button" data-action="like" data-show-faces="false" data-share="false"></div></span>
					</td>
				</tr>
				
				<tr>
					<td>
						<div class="topcont">
							<div id="previewtop">
								<cfoutput>
								<cfloop from="#url.id+1#" to="#url.id+3#" index="idx">
									<span title="#getall.description[idx]#"><a href="./?id=#getall.record_id[idx]#"><img src="#getall.link[idx]#"  class="resize"></a></span>
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
		<!----<div style="width:100%;text-align:center;max-height:200px;overflow:auto;">
			<cfoutput><div class="fb-comments" data-href="http://quirkycrackers.com/quirkycrackers/indian-history-in-pictures/?id=#url.id#&shared_pic=1&utm_source=share_from_site&utm_medium=fb_share&utm_campaign=modimeme" data-numposts="5"></div></cfoutput>
		</div>----->
		<div id="preview">
			<div >
				<ol>
			<cfoutput query="getall">
				<li><span style="font-size:small;"><a href="./?id=#getall.record_id#">#getall.description#<!--- <img src="#getall.link#"  class="resize"> ---></a></span></li>
			</cfoutput>
			</ol>
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
				<span title="#getall.description#"><a href="./?id=#getall.record_id#"><img src="#getall.link#"  class="resize"></a></span>
			</cfoutput> --->
			</div>
		</div>
		<div style="height:25px"></div>
		<div style="width:90%;text-align:center;border-bottom:5px solid white;font-size:x-small;">Hosted at: <a href="http://www.quirkycrackers.com/?utm_source=modiji_qc&utm_medium=self&utm_campaign=indianhistory" >QuirkyCrackers</a> | Supported By: <a href="http://www.findtrackbuy.com/?utm_source=modiji_ftb&utm_medium=self&utm_campaign=indianhistory" >FindTrackBuy</a> | <!--- <a href= "https://www.facebook.com/sufyan.sadiq"> --->FB Credit - Sufyan Sadiq<!--- </a> ---></div>
<table style="width:100%"><tr><td style="text-align:center;">
<div class="slider" style="width:300px">
			<!---<cfquery name="slider" datasource="product" >
					SELECT sld.img, pm.title,pm.short_desc, pm.last_price, pm.idproduct_main,
					CONCAT(pm.description,coalesce(si.affiliateParam, '')) as link
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
					
				</cfoutput>----->
				<!--- <div id="slider_1" class="slideContent" style="position:relative;display:block;border:0px solid black;;text-align:center;">
					<a href="http://www.quirkycrackers.com/?utm_source=modiji_qc&utm_medium=self&utm_campaign=indianhistory" target="_blank">
						<img class="mustLoad" alt="" width="300px" height="200px" data-lazy="https://scontent.fmaa1-2.fna.fbcdn.net/hphotos-xft1/v/t1.0-9/12341607_911950845556507_5168728349777835796_n.jpg?oh=c7077c2b0116ee4432d2ee2e619c4d63&oe=5714813D"/>
					</a>
					<div style='position:relative;top:-30px;border: 2px solid;border-radius: 5px;left:1px;background:white;text-align:center;font-family: "Anton", sans-serif;'>
						<div class='slid_title' style="font-family: 'Anton', sans-serif;font-size:small;">
							Finger Nose Hair Trimmer
						</div>
					</div>
				</div>
				<div id="slider_2" class="slideContent" style="position:relative;display:block;border:0px solid black;;text-align:center;">
					<a href="http://www.quirkycrackers.com/?utm_source=modiji_qc&utm_medium=self&utm_campaign=indianhistory" target="_blank">
						<img class="mustLoad" alt="" width="300px" height="200px" data-lazy="https://scontent.fmaa1-2.fna.fbcdn.net/hphotos-xpt1/v/t1.0-9/12345478_911950822223176_4457462912614462253_n.jpg?oh=7cca1ebb7d3596c8e68a91eee2ef0900&oe=5719B9AE"/>
					</a>
					<div style='position:relative;top:-30px;border: 2px solid;border-radius: 5px;left:1px;background:white;text-align:center;font-family: "Anton", sans-serif;'>
						<div class='slid_title' style="font-family: 'Anton', sans-serif;font-size:small;">
							Shot Glass Thela
						</div>
					</div>
				</div>
				<div id="slider_3" class="slideContent" style="position:relative;display:block;border:0px solid black;;text-align:center;">
					<a href="http://www.quirkycrackers.com/?utm_source=modiji_qc&utm_medium=self&utm_campaign=indianhistory" target="_blank">
						<img class="mustLoad" alt="" width="300px" height="200px" data-lazy="https://scontent.fmaa1-2.fna.fbcdn.net/hphotos-xaf1/v/t1.0-9/12348158_911950805556511_3497496835708798631_n.jpg?oh=55cab28371e013f627778767dd7836d8&oe=56E417C2"/>
					</a>
					<div style='position:relative;top:-30px;border: 2px solid;border-radius: 5px;left:1px;background:white;text-align:center;font-family: "Anton", sans-serif;'>
						<div class='slid_title' style="font-family: 'Anton', sans-serif;font-size:small;">
							Aeroplane Cocktail Shaker
						</div>
					</div>
				</div>
				<div id="slider_4" class="slideContent" style="position:relative;display:block;border:0px solid black;;text-align:center;">
					<a href="http://www.quirkycrackers.com/?utm_source=modiji_qc&utm_medium=self&utm_campaign=indianhistory" target="_blank">
						<img class="mustLoad" alt="" width="300px" height="200px" data-lazy="https://scontent.fmaa1-2.fna.fbcdn.net/hphotos-xla1/v/t1.0-9/12341620_911950808889844_2653595647089765598_n.jpg?oh=aa9428b59328596cab6b0ba99d37e52b&oe=56E4E217"/>
					</a>
					<div style='position:relative;top:-30px;border: 2px solid;border-radius: 5px;left:1px;background:white;text-align:center;font-family: "Anton", sans-serif;'>
						<div class='slid_title' style="font-family: 'Anton', sans-serif;font-size:small;">
							STARFISH & SLIPPERS HOOK
						</div>
					</div>
				</div> --->
				<div id="slider_1" class="slideContent" style="position:relative;display:block;border:0px solid black;;text-align:center;">
					<a href="http://goo.gl/oVMpxE" target="_blank">
						<img class="mustLoad" alt="" width="300px" height="200px" data-lazy="1.jpg"/>
					</a>
					<!--- <div style='position:relative;top:-30px;border: 2px solid;border-radius: 5px;left:1px;background:white;text-align:center;font-family: "Anton", sans-serif;'>
						<div class='slid_title' style="font-family: 'Anton', sans-serif;font-size:small;">
							Finger Nose Hair Trimmer
						</div>
					</div> --->
				</div>
				<div id="slider_3" class="slideContent" style="position:relative;display:block;border:0px solid black;;text-align:center;">
					<a href="http://goo.gl/cUyZC0" target="_blank">
						<img class="mustLoad" alt="" width="300px" height="200px" data-lazy="2.jpg"/>
					</a>
					<!--- <div style='position:relative;top:-30px;border: 2px solid;border-radius: 5px;left:1px;background:white;text-align:center;font-family: "Anton", sans-serif;'>
						<div class='slid_title' style="font-family: 'Anton', sans-serif;font-size:small;">
							Aeroplane Cocktail Shaker
						</div>
					</div> --->
				</div>
				<!--- <div id="slider_1" class="slideContent" style="position:relative;display:block;border:0px solid black;;text-align:center;">
					<a href="http://www.amazon.in/gp/product/B00FXLC9V4/ref=as_li_tl?ie=UTF8&camp=3626&creative=24822&creativeASIN=B00FXLC9V4&linkCode=as2&tag=t00fd-21" target="_blank">
						<img class="mustLoad" alt="" width="300px" height="200px" data-lazy="4.jpg"/>
					</a>
					<!--- <div style='position:relative;top:-30px;border: 2px solid;border-radius: 5px;left:1px;background:white;text-align:center;font-family: "Anton", sans-serif;'>
						<div class='slid_title' style="font-family: 'Anton', sans-serif;font-size:small;">
							Finger Nose Hair Trimmer
						</div>
					</div> --->
				</div>
				<div id="slider_3" class="slideContent" style="position:relative;display:block;border:0px solid black;;text-align:center;">
					<a href="http://www.amazon.in/gp/product/B015CLCNLA/ref=as_li_tl?ie=UTF8&camp=3626&creative=24822&creativeASIN=B015CLCNLA&linkCode=as2&tag=t00fd-21" target="_blank">
						<img class="mustLoad" alt="" width="300px" height="200px" data-lazy="3.jpg"/>
					</a>
					<!--- <div style='position:relative;top:-30px;border: 2px solid;border-radius: 5px;left:1px;background:white;text-align:center;font-family: "Anton", sans-serif;'>
						<div class='slid_title' style="font-family: 'Anton', sans-serif;font-size:small;">
							Aeroplane Cocktail Shaker
						</div>
					</div> --->
				</div>
				<div id="slider_4" class="slideContent" style="position:relative;display:block;border:0px solid black;;text-align:center;">
					<a href="http://www.amazon.in/gp/product/B018U7PG30/ref=as_li_tl?ie=UTF8&camp=3626&creative=24822&creativeASIN=B018U7PG30&linkCode=as2&tag=t00fd-21" target="_blank">
						<img class="mustLoad" alt="" width="300px" height="200px" data-lazy="1.jpg"/>
					</a>
					<!--- <div style='position:relative;top:-30px;border: 2px solid;border-radius: 5px;left:1px;background:white;text-align:center;font-family: "Anton", sans-serif;'>
						<div class='slid_title' style="font-family: 'Anton', sans-serif;font-size:small;">
							STARFISH & SLIPPERS HOOK
						</div>
					</div> --->
				</div> --->
		</div>
</td></tr></table>		
<!--- <div id="preview2">
				<!--- <ul>
			<cfoutput query="getall">
				<li><span title="#getall.description#"><a href="./?id=#getall.record_id#">#getall.description#<!--- <img src="#getall.link#"  class="resize"> ---></a></span></li>
			</cfoutput>
			</ul> --->
			<cfoutput query="getall">
				<img src="#getall.link#"  class="bgimg">
			</cfoutput>
		</div> --->
	</body>
</html>