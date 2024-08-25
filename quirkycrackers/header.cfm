<div id="fb-root"></div>
	<script>
  window.fbAsyncInit = function() {
    FB.init({
      appId      : '585706938226278',
      xfbml      : true,
      version    : 'v2.5'
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
	<script>
		 user_sk = '';
		<cfif isdefined("client.user_sk")>
			<cfoutput>
				user_sk = '#client.user_sk#';
			</cfoutput>
		</cfif>
	</script>
	
	<div class="mainMenu">
		<!--- <span class="menuItem">
			About
		</span> --->
		<div class="menuContainer" style="display: inline-block;vertical-align: top;">
		<span style="cursor: pointer; cursor: hand;height:50px;display: inline-block;vertical-align: top;">
			<img id="menuitem" src="/quirkycrackers/resources/images/menu.png" height="50px" width="50px">
		</span>
		<span style="cursor: pointer; cursor: hand;height:50px;display: inline-block;vertical-align: top;">
			<a href="/quirkycrackers/">
				<img id="_mainLogo1" src="/quirkycrackers/resources/images/tnhp.png">
			</a>
		</span>
		<cfif not client.mobile>
			<span style="height:40px;display: inline-block;vertical-align: top;border-top:10px solid black;border-left:5px solid black">
				<input type="text" id="search" placeholder="Search...." size="35" style="height:30px;font-size:14;outline: 1;background-color:transparent;color:white;border: 0px solid;border-bottom:1px solid white" onkeydown="if (event.keyCode == 13) { go(); }">
			</span>
			<cfif isdefined("client.user_sk") and len(client.user_sk) and isdefined("client.first_name")>
				<span style="color:white;height:50px;display: inline-block;vertical-align: top;border-top:0px solid black;border-left:5px solid black;font-weight:bold">
					<cfoutput>Hello #client.first_name# <img onclick="logout();" alt="" width="25px" height="25px" src="/quirkycrackers/resources/images/logout.png" style="border-top:12.5px solid black;opacity:.8;cursor: pointer; cursor: hand;"/></cfoutput>
				</span>
			<cfelse>
				<span style="height:40px;display: inline-block;vertical-align: middle;border-top:10px solid black;border-left:5px solid black">
					<input class="mail_id" size="35" style="height:30px;font-size:14;outline: 1;background-color:transparent;color:white;border: 0px solid;border-bottom:1px solid white" placeholder="SendMe_weekly_update@mymail.com"  type="text" name="subscribe" id="subscribe" onkeydown="if (event.keyCode == 13) { subscribe_user($('#subscribe').val()); }">
					<img style="cursor: pointer; cursor: hand;vertical-align:middle" onclick="login();" src="/quirkycrackers/resources/images/buttonFbLogin.png"/> or <span onclick="window.location='/quirkycrackers/login/';" style="color:white;cursor: pointer; cursor: hand;">Login</span>
				</span>
			</cfif>
			<span style="height:50px;display: inline-block;vertical-align: top;">
				<div class="fb-like" style="top:0px;" data-href="http://www.facebook.com/tumsenahopaye" data-layout="button_count" data-action="like" data-show-faces="true" data-share="false"></div>
			</span>
		</cfif>
		<cfif not client.mobile>
			<span class="menuItem menuItemSmall"  id="mobilesite" style="display:none">
				<a href="/quirkycrackers/mobile/?m=1&force=1" style="text-decoration:none;color:white">Mobile Site</a>
			</span>
			</cfif>
		</div>
		<!--- <div style="height:15px"></div>
		<div class="loginCSS">
		<!--- <cfif isdefined("client.user_sk")>
				<span  class="menuItem"  onclick="window.location.href='/quirkycrackers/dashboard/';" >
					Dashboard
				</span>
				<span  class="menuItem"  onclick="window.location.href='/quirkycrackers/logout/';">
					Logout
				</span>
		<cfelse>
			<span  class="menuItem desktop1" onclick="window.location.href='/quirkycrackers/login/';" >
				Login/Register
			</span>
		</cfif> --->
		<cfif client.mobile>
				<span id="mobilesite"  class="menuItem desktop1" >
						<a href="/quirkycrackers/mobile/?m=0&force=1" style="text-decoration:none;color:white;font-size:x-small;">Desktop Site</a>
				</span>
			</cfif>
		
		</div> --->
		
	</div>
	<div id="menu" class="menudetails" <cfif isdefined("url.category") and len(url.category) and not client.mobile>style="display:block"</cfif> >
	<cfset request.view.menu = obj.getCategory()>
	<cfif client.mobile>
	<div id="mo_submenu" style="position:absolute;z-index:500;left:120px;">
		<span id="mo_srch" style="display: inline-block;">
			<input type="text" id="search" placeholder="Search...." size="25" style="height:30px;font-size:x-small;outline: 1;background-color:transparent;color:black;border: 0px solid;border-bottom:1px solid black" onkeydown="if (event.keyCode == 13) { go(); }">
			<img onclick="go();" width="20px" height="20px" style="vertical-align:middle;" src="resources/images/active-search-2-xxl.png"/>
		</span>
		<cfif isdefined("client.user_sk") and len(client.user_sk)>
			<span style="color:black;display: inline-block;font-weight:bold;border-top:10px solid white;">
				<cfoutput><cfif isdefined("client.first_name")>Hello #client.first_name#</cfif> <img onclick="logout();" style="vertical-align:middle;"  width="25px" height="25px" src="/quirkycrackers/resources/images/logout.png"/></cfoutput>
			</span>
		<cfelse>
			<span style="display: inline-block;">
				<input class="mail_id" size="25" style="height:30px;font-size:x-small;outline: 1;background-color:transparent;color:black;border: 0px solid;border-bottom:1px solid black" placeholder="SendMe_weekly_update@mymail.com"  type="text" name="subscribe" id="subscribe" onkeydown="if (event.keyCode == 13) { subscribe_user($('#subscribe').val()); }">
				<img onclick="subscribe_user($('#subscribe').val());" width="20px" height="20px" src="/quirkycrackers/resources/images/email.png"/>
				<br><br><img style="cursor: pointer; cursor: hand;vertical-align:middle" onclick="login();" src="/quirkycrackers/resources/images/buttonFbLogin.png"/> or <span onclick="window.location='/quirkycrackers/login/';" style="color:black;cursor: pointer; cursor: hand;">Login</span>
			</span>
		</cfif>
		<span style="display: inline-block;vertical-align: top;border-top:0px solid white;">
			<div class="fb-like" style="border-top:0px solid white;" data-href="http://www.facebook.com/tumsenahopaye" data-layout="button_count" data-action="like" data-show-faces="true" data-share="false"></div>
		</span>
	</div>
		<div class="browse" id="allDropsOptions" style="font-size:x-small;background-color:white;font-weight:bold;">
		<cfloop from="1" to="#request.view.menu.recordcount#" index="idx">
			<cfif isdefined("request.cat_title.id") and request.cat_title.id eq request.view.menu.id[idx]>
				<cfset color = "Red">
			<cfelse>
				<cfset color = "Black">
			</cfif>
				<cfoutput>
					<a style="text-decoration:none;" href="/quirkycrackers/?type=browse&category=#request.view.menu.id[idx]#">
					<div class="browsemenuItem" style="text-decoration:none;color:#color#;font-weight:bold;" id="menu_#request.view.menu.id[idx]#">
						#request.view.menu.name[idx]#
					</div>
					</a>
				</cfoutput>
		</cfloop>
		<a style="text-decoration:none;" href="/quirkycrackers/mobile/?m=0&force=1">
					<div class="browsemenuItem" style="text-decoration:none;color:black;font-weight:bold;" id="menu_desktop">
						Desktop Site
					</div>
					</a>
	</div>
	<cfelse>
		<table width="100%" style="text-align:center;font-size:small;background-color:#C20C0F"><tr>
			<cfoutput query="request.view.menu">
				<cfif isdefined("request.cat_title.id") and request.cat_title.id eq request.view.menu.id>
					<cfset color = "yellow">
				<cfelse>
					<cfset color = "white">
				</cfif>
				<td><a style="text-decoration:none;" href="/quirkycrackers/?type=browse&category=#request.view.menu.id#">
					<div class="menu_item" style="text-decoration:none;color:#color#;font-weight:bold;" id="menu_#request.view.menu.id#">#request.view.menu.name#</div>
				</a></td>
			</cfoutput>
		</tr></table>
	</cfif>
	</div>
	<cfif arrayIsEmpty(request.path)>
	<cfif isdefined("url.category") and len(url.category)>
		<div class="content" style="font-size:x-large;text-align:center;border-top:5px solid white;">
			<div><a href="http://findtrackbuy.com"><img alt="" src="/quirkycrackers/resources/images/ftb_qc_fp.jpg"/></a></div>
			<cfoutput>#request.cat_title.name#</cfoutput>
		</div>
		<div style="width:50%;text-align:center;position:relative;min-width:280px" id="rangecontent">
		<input type="text" id="range_2" />
		</div>
	<cfelseif (isdefined("url.page") and isnumeric(url.page) and url.page gt 1) or (isdefined("url.type") and url.type eq "search")>
	
	<cfelse>
		<div>
		<div class="slider" <cfif not client.mobile>style="float: left;"</cfif>>
			<cfquery name="slider" datasource="#application.dsn#" >
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
					<cfif slider.currentrow eq 2>
					
					
					</cfif>
					<cfif slider.idproduct_main eq -1>
						<div id="slider_#slider.idproduct_main#" class="slideContent" style="position:relative;display:block;border:0px solid black;text-align:center;">
						<!--- <div style="position:fixed;top:100px;left:0;">#slider.title#</div> --->
							<img class="mustLoad" alt="" src="/quirkycrackers/resources/images/slider/#slider.img#"/>
						<div style='position:absolute;top:10;right:0;text-align:center;width:300px;font-family: "Anton", sans-serif;'>
						</div>
						</div>
					<cfelse>
						<div id="slider_#slider.idproduct_main#" class="slideContent" style="position:relative;display:block;border:0px solid black;;text-align:center;">
								<!--- <div style="position:fixed;top:100px;left:0;">#slider.title#</div> --->
								<a href="#slider.link#" target="_blank" onclick="clickLog(#slider.idproduct_main#);">
									<img class="mustLoad" alt="" width="600px" height="400px" data-lazy="/quirkycrackers/resources/images/slider/#slider.img#"/>
								</a>
								<div style='position:relative;top:-30px;border: 2px solid;border-radius: 5px;left:1px;background:white;text-align:center;font-family: "Anton", sans-serif;'>
									<div class='slid_title' style="font-family: 'Anton', sans-serif;">
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
				</cfoutput>
		</div>
		<cfif not client.mobile>
			<div class="mainad" style="text-align:center;background-color:rgb(186, 2, 16);float: left;cursor: pointer; cursor: hand;" onclick="goto(event);">
				<div style="width:100%;background-color:rgb(186, 2, 16);">
					<div style="color:yellow;text-align:center;width:100%;font-size:<cfif client.mobile>x-</cfif>large;">
					Our Other Venture: FindTrackBuy.com
					</div>
					
						<div style="text-align:center;color:white;">How this Tool Saves You Bucks</div>
						<cfoutput>
						<div class="scenario" id="s1content" style="display:block;"> 
							<div class="step">
								<div class="data">Step - 1: I want to buy a pair of Shoes</div>
								<div class="images"><img width="500px" height="250px" src="/quirkycrackers/images/hiw/#request.files#/1_1.jpg"/></div>
							</div>
							<div class="step">
								<div class="data">Step - 2: I searched Shoes and checked price history of my fav shoes.</div>
								<div class="images"><img width="500px" height="250px" src="/quirkycrackers//images/hiw/#request.files#/1_2.jpg"/></div>
							</div>
							<div class="step">
								<div class="data">Step - 3: I want to wait untill it drops by 10% atleast.<br>I track it.</div>
								<div class="images"><img  width="500px" height="250px" src="/quirkycrackers/images/hiw/#request.files#/1_3.jpg"/></div>
							</div>
							<div class="step">
								<div class="data">Step - 4: We will send you alert when price drops<br>You buy it. You save bucks!</div>
								<div class="images"><img width="500px" height="250px" src="/quirkycrackers/images/hiw/#request.files#/1_4.jpg"/></div>
							</div>
						</div>
					</cfoutput>
				</div>
					<img alt="" src="/quirkycrackers/resources/images/ftb_qc_fp.jpg"/>
			</div>
			<br style="clear: left;" />
		</cfif>
		</div>
	</cfif>
	</cfif>
	<!--- <div id="howitworks" class="menudItemetails" >
		<div class="gap"></div>
		<div style="font-size:large;color:gray">Find.</div>
		<div class="itemlist">Browse products</div>
		<div class="itemlist">Search Products by Keywords</div>
		<div class="itemlist">If you didn't find what you are looking for yet, just copy-paste product link from Amazon/Flipkart</div>
		<div style="font-size:large;color:gray">Track.</div>
		<div class="itemlist">Click on Track Link and enter your email/phone</div>
		<div class="itemlist">Enter your expected price of purchase.</div>
		<div class="itemlist">We will track your product and notify you about price drops.</div>
		<div class="itemlist">In the meantime, you can always come back and check how your products are doing. Check products price history</div>
		<div style="font-size:large;color:gray">Buy.</div>
		<div class="itemlist">Once the price drops, we notify you about it and you buy it!</div>
		<div class="gap"></div>
	</div> --->
	<!--- <div id="reportissue" class="menudItemetails">
		<div class="gap"></div>
		<div class="itemlist">We are new. We are human. We do mistakes!</div>
		<div class="itemlist">Please report if you come up with any issue.</div>
		<div class="itemlist">Please let us know what issue you face, please quote product id if you see any product related issues.</div>
		<div class="itemlist"><textarea name="issue" cols="100" rows="5" id="issue" placeholder="Please provide issue description. Like: Product B0012879 has a major price mismatch.."></textarea></div>
		<div class="itemlist"><button type="submit" onclick="sendIssue(user_sk);">Send</button></div>
		<div class="itemlist" id="issuealert" style="color:red"></div>
		<div class="itemlist">*We use data provided by Flipkart and Amazon.</div>
		<div class="gap"></div>
	</div> --->
	<cfif not client.mobile>
		<div class="content" style="width:80%;">
	</cfif>
	<!--- <div class="mainHead"><a href="/quirkycrackers/" style="text-decoration: none;color:gray">Find.Track.Buy.</a><span style="font-size:xx-small">Beta</span></div>
	<div class="gap"></div> --->
