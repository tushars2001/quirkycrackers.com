<!DOCTYPE html>
<cfsetting showdebugoutput="false">
<cfset application.dsn = 'product'>
<cfset categories.fk = ''>
<cfset categories.az = ''>
<cfparam name="url.type" default="trends">
<cfparam name="session.fluctuate" default="0">
<cfset obj = createObject("component","cmp")>
<cfparam name="url.param" default="">
<cfparam name="description" default="">
<cfparam name="invalidlink" default="0">
<cfparam name="url.page" default="1">
<cfset catparam = ''>
<cfparam name="url.fkcategory" default="">
<cfparam name="url.azcategory" default="">
<cfparam name="url.category" default="">
<cfparam name="featuredproduct" default="">
<cfif not len(url.fkcategory)>
	<cfset url.fkcategory = listappend(url.fkcategory,categories.fk)>
	<cfset url.fkcategory = ListRemoveDuplicates(url.fkcategory)>
</cfif>
<cfif not len(url.azcategory)>
	<cfset url.azcategory = listappend(url.azcategory,categories.az)>
	<cfset url.azcategory = ListRemoveDuplicates(url.azcategory)>
</cfif>
<cfif not len(url.category)>
	<cfset url.category = ''>
</cfif>
<cfset catparam = '&fkcategory=#url.fkcategory#&azcategory=#url.azcategory#&category=#url.category#'>
<!--- <script>
  window.fbAsyncInit = function() {
    FB.init({
      appId      : '1684862888425977',
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
</script> --->
<script language="javascript">
	<cfoutput>
		meterparams = {
		droprange:{from:'#session.rangeFrom#',to:'#session.rangeto#'},
		pricerange:{from:'#session.prangeFrom#',to:'#session.prangeFrom#'},
		since:'#session.dropsince#',
		saveme:'#session.saveme#'
	};
	
	var _paging = {page:1,type:'#url.type#',param:'#url.param#',catparam:'#catparam#',mode:'ajax',ajaxing:false};
	</cfoutput>

	(function msite(){
		var sw = screen.width;
		var sh = screen.height;
		var small = sw;
		if(sw > sh) small = sh;
		<cfoutput>
		if(small < 640){
			<cfif not client.mobile and not session.force>
				<cfoutput>
					window.location.href = 'http://#cgi.SERVER_NAME#:#cgi.SERVER_PORT#/quirkycrackers/mobile/?#cgi.QUERY_STRING#';
				</cfoutput>
			</cfif>
		}
		else{
			<cfif client.mobile and session.force>
				<cfoutput>
					window.location.href = 'http://#cgi.SERVER_NAME#:#cgi.SERVER_PORT#/quirkycrackers/mobile/?#cgi.QUERY_STRING#';
				</cfoutput>
			</cfif>
		}
		</cfoutput>
	})();

</script>


<cfif url.type eq 'trends'>
	<cfset session.dropsince = -1>
<cfelse>
	<cfif session.dropsince eq -1 or len(session.dropsince) eq 0>
		<cfset session.dropsince = 1>
	</cfif>
</cfif>

<cfset session.usermsg = ''>
<cfset msgcnt = 0>
<cfif session.fluctuate eq 1>
	<cfset msgcnt = msgcnt+1>
	<cfset session.usermsg = "#session.usermsg#These are fluctuaters; products whose prices changes frequently. ">
</cfif>
<cfif len(session.saveme) and  session.saveme neq 0>
	<cfset some = "some">
	<cfif session.saveme eq 100>
		<cfset some = "0 to 100">
	</cfif>
	<cfif session.saveme eq 500>
		<cfset some = "100 to 500">
	</cfif>
	<cfif session.saveme eq 1000>
		<cfset some = "500 to 1000">
	</cfif>
	<cfif session.saveme eq 1001>
		<cfset some = "More then 1000">
	</cfif>
	<cfset in =''>
	<cfif isdefined("url.category") and url.category neq "All Drops">
		<cfset msgcnt = msgcnt+1>
		<cfset in =' in #url.category# segment'>
	</cfif>
	<cfset msgcnt = msgcnt+1>
	<cfset session.usermsg = "#session.usermsg#You are Saving #some# bucks #in#. ">
</cfif>
<cfif len(session.dropsince)>
	<cfset days = "ever">
	<cfif session.dropsince eq 0>
		<cfset days = "ever">
		<cfset msgcnt = msgcnt+1>
	</cfif>
	<cfif session.dropsince eq 1>
		<cfset days = "yesterday">
		<cfset msgcnt = msgcnt+1>
	</cfif>
	<cfif session.dropsince eq 7>
		<cfset days = "last week">
		<cfset msgcnt = msgcnt+1>
	</cfif>
	<cfset by = ''>
	<cfif len(session.rangeFrom) and (session.rangeFrom gt -100 or session.rangeTo lt 100)>
		<cfset by = ' by #session.rangeFrom#% to #session.rangeTo#%'>
		<cfset msgcnt = msgcnt+1>
		<!--- <cfset session.usermsg = "#session.usermsg#Price drop is #session.rangeFrom#% to #session.rangeTo#%. "> --->
	</cfif>
	<cfset session.usermsg = "#session.usermsg#Price dropped since #days##by#. ">
</cfif>

<cfif len(session.prangeFrom) and (session.prangeFrom gt 0 or session.prangeTo lt 25000)>
	<cfset plus = ''>
	<cfif session.prangeTo eq 25000>
		<cfset plus = '+'>
	</cfif>
	<cfset msgcnt = msgcnt+1>
	<cfset session.usermsg = "#session.usermsg#Price range is Rs. #session.prangeFrom#/- to Rs. #session.prangeTo##plus#/-. ">
</cfif>
<cfif isdefined("url.type")>
	<cfif url.type eq 'link'>
		<cftry>
			<cfif obj.isFKlink(url.param)>
				<cfset pid = obj.fkurlparse(url.param)>
				<cfset data =  obj.flipkartPID(pid)>
				<cfset data = DeserializeJSON(data)>
			<cfelseif obj.isAZlink(url.param)>
				<cfset pid = obj.azurlparse(url.param)>
				<cfset azdata = obj.ItemLookup(pid)>
				<cfset azdata = obj.ConvertXmlToStruct(azdata,structnew())>
			<cfelse>
				<cfset invalidlink = 1>
			</cfif>
		<cfcatch>
			<cfset invalidlink = 1>
		</cfcatch>
		</cftry>
		
		
		<cfset movers = obj.getMovers(1)>
		
		<cfif not invalidlink>
			<cfset moversthis = obj.getMovers(page=1,pid=pid)>
			<cfif obj.isFKlink(url.param)>
				<cfset pdetails = obj.fkDetails(data.productBaseInfo.productAttributes)>
			</cfif>
			<cfif obj.isAZlink(url.param)>
				<cfset pdetails = obj.azDetails(azdata.Items.Item)>
			</cfif>
	
			<cfset pdetails.title = REReplace(pdetails.title, "[^0-9a-zA-Z _]", "", "ALL")>
			<cfif  moversthis.recordcount eq 0 or moversthis.last_price neq pdetails.price>
					<cfset obj.addUsersMovers(pdetails)>
					<cftry>
						<cfset obj.recal(pid)>
					<cfcatch></cfcatch>
					</cftry>
					<cfset moversthis = obj.getMovers(page=1,pid=pid)>
			</cfif>
		</cfif>
		<!--- 
		<cfquery name="joinm" dbtype="query">
			select * from moversthis
			union
			select * from movers
		</cfquery>
		
		<cfset movers = joinm> --->
		
		<cfset obj.searchLog(url.param,2)>
	</cfif>
	<cfif url.type eq 'search'>
	
			<cfset page = 1>
			<cfset fkcat = ''>
			<cfset azcat = ''>
			<cfset categories.fk = ''>
			<cfset categories.az = ''>
			
			<cfif isdefined("url.page") and isnumeric(url.page) and url.page gt 1>
				<cfset page = url.page>
			</cfif>
			
			<cfif isdefined("url.fkcategory")>
				<cfset fkcat = url.fkcategory>
			</cfif>
			<cfif isdefined("url.azcategory")>
				<cfset azcat = url.azcategory>
			</cfif>
			
			<cfset session.dropsince = 0>
			<cfset from = (url.page - 1)*17>
			<!--- <cfset movers = obj.getFKAZKeyword(url.param,page,url.category)> --->
			<cfset movers = products.getProductsBySearch(search_string=url.param,from=from)>
			
			<!--- <cfset allData =  obj.flipkartKeyword(url.param,page,fkcat)>
			<cfif allData.datatype eq "nonjson">
				<cfset data = DeserializeJSON(allData.data)>
				<cfif page eq 1>
					<cfset categories.fk  = obj.getFKCategories(data)>
				</cfif>
			<cfelse>
				<cfset data = allData.data>
				<cfif page eq 1>
					<cfset categories.fk  = ListRemoveDuplicates(allData.data.category)>
				</cfif>
			</cfif>
			<cfset azdata = obj.azKeyword(url.param,page,azcat)>
			<cfset azdata = obj.ConvertXmlToStruct(azdata,structnew())>
			<cfif page eq 1>
				<cfset categories.az  = obj.getAZCategories(azdata)>
			</cfif> --->
	</cfif>
	<cfif url.type eq 'browse'>
		<cfif not isdefined("url.category")>
			<cfset url.category = 'All Drops'>
		</cfif>
		<cfif not isdefined("url.page")>
			<cfset url.page = 1>
		</cfif>
		<cfset request.cat_title = obj.getCategory(url.category)>
		<cfset from = (page-1)*17>
		<!--- <cfset movers = obj.getMovers(url.page,url.category)> --->
		<!--- <cfset movers = obj.trending()> --->
		<cfif not isnumeric(session.prangefrom)>
			<cfset session.prangefrom = 0>
		</cfif>
		<cfif not isnumeric(session.prangeto)>
			<cfset session.prangeto = 25000>
		</cfif>
		<cfif url.category eq 29>
			<cfset movers = products.getWhatsNew(fromprice=session.prangefrom,toprice=session.prangeto)>
		<cfelse>
			<cfset movers = products.getProductsByCat(catId=url.category,from=from,fromprice=session.prangefrom,toprice=session.prangeto)>
		</cfif>
		
	</cfif>
	<cfif url.type eq 'trends'>
		<cfif not isdefined("url.page")>
			<cfset url.page = 1>
		</cfif>
		<cfset from = (url.page - 1)*17>
		<!--- <cfset movers = obj.getMovers(url.page,url.category)> --->
		<cfset movers = products.getMainProducts(from)>
		<!--- <cfset movers = obj.getFKAZKeyword(url.category,page)> --->
	</cfif>
</cfif>

<cfif isdefined("url.feature") and len(url.feature) and isnumeric(url.feature)>
	<cfset featuredproduct = products.getFeaturedProduct(url.feature)>
</cfif>

<html>
<head>
	<cfif client.mobile>
	<meta name="viewport" content="width=device-width, initial-scale = 1.0, maximum-scale=1.0, user-scalable=no" />
	</cfif>
	<title>Add Quirk to Life : Online Crazy Unique Stuff / Gift Ideas for Indian Buyers</title>
		<meta name="keywords" 			content="Online, Crazy, Stuff, Unique, gift, geek, quirky, India, unique gift, online gift, gift online, online home decor, gift for the home, gift for home, online home accessories, gift stuff, home office decor, gift unique, a unique gift, home dÃ©cor online, indian home decor, online gift for her, indian gift, new gift ideas, unique online gift, home accessories online, unique home ideas, unique home accessories, indian home accessories, gift shot glasses, decor home online, ideas for home office, shot glass gift, shot glasses gift, unique home decor online, shot glass online, shot glasses online, home decor indian, office decor online, indian home ideas, ideas home office, bar accessories online, indian shot glass, online shot glasses, home office gift ideas, gift ideas for home office, home accessories ideas, crazy shot glasses, home bar gift ideas, ideas for a home office, the dark knight tumbler, indian home decor online, gift for kids online, home decorative online, shot glass gift ideas, crazy home accessories, in home office ideas, at home office ideas, unique shot glasses gift, office home ideas, accessories gifts ideas, home decor stuff online, buy quirky gifts online india, painting ideas for indian homes, unique corporate gifts, unique birthday gift, unique gifts online, unique gifts for women, unique birthday gifts, unique gift items, unique gift catalog, unique wedding gift, unique gift for her, unique fathers day gifts, unique christmas gifts, gifts unique, unique gifts for dad, unique gift for wife, unique gifts for him, unique gift shops, unique gift for men, unique birthday gifts for her, unique gifts women, unique birthday gifts for men, unique mens gifts, unique engagement gifts, find unique gift, unique cool gifts, home decorating, modern home decor, home decorations, home decorating ideas, home decorating catalogs, home and decor, contemporary home decor, discount home decor, inexpensive home decor, home decor store, decorating your home, home decor magazine, home decor shopping, home decorative, buy home decor, home decor sale, home decor magazines, decoration home, decorations for home, home decorative items, home decor furniture, eclectic home decor, home decor furnishings, home decorating items, best home decor, gifts online, online gift shopping, online gift shop, buy gifts online, online gift stores, birthday gifts online, buy gift online, online gift delivery, online gift shops, wedding gifts online, send gifts online, send gift online, order gifts online, office gifts online, online gift sites, kids gift online, online gift shop for kids, birthday gift ideas, unusual gift ideas, gift ideas for boys, gift ideas for women, original gift ideas, cool gift ideas, gift ideas for girlfriend, ladies gift ideas, gift ideas for children, good gift ideas, gift ideas for christmas, small gift ideas, online gift ideas, best gift ideas, awesome gift ideas, gift ideas for boyfriend, gift ideas for husband, gift ideas for boyfriends, wife gift ideas, crazy gift ideas, wedding gifts ideas, interesting gift ideas, gift ideas for new boyfriend, gift ideas for a friend, coffee cup gift ideas, mothers day gifts, gifts to bangalore, gifts to delhi, gadget gifts, gifts for mom, strange gifts, gift for friend, gift for dad, gifts for teachers, gift sites, weird gifts, gift on line, original gifts, gift for father, gifts for brothers, gift for a friend, perfect gifts, creative gifts, gifts for girlfriends, special gifts for her, gift for kids, gifts for parents, gifts for couples, quirky gifts, return gifts, unique gift ideas, unique gift idea, unique birthday gift ideas, unique wedding gift ideas, unique gifts ideas, unique gift ideas for men, unique gift ideas for women, unique gift ideas for boyfriend, birthday gifts, birthday gift, birthday gift for her, birthday gifts for him, birthday gifts for her, special birthday gift, birthday gift for husband, birthday gift for boyfriend, birthday gift for wife, great birthday gifts, unusual birthday gifts, birthday gifts for boyfriend, best birthday gifts, cool birthday gifts, gift for children birthday, gift ideas for men, mens gift ideas, men gift ideas, gifts ideas for men, mens gifts ideas, cool gift ideas for men, perfect gift for boyfriend, boyfriend gifts, gifts for boyfriend, gift for boyfriend, gifts for my boyfriend, christmas gifts for boyfriend, gifts for boyfriends, gifts for a boyfriend, gift for my boyfriend, gifts for your boyfriend, special gifts for boyfriend, special gift for boyfriend, unique gifts for boyfriend, romantic gifts for boyfriend, anniversary gifts for boyfriend, good gifts for boyfriends, best gift for boyfriend, creative gifts for boyfriend, cute gifts for boyfriend, best gifts for boyfriend, unique valentine gifts, unique anniversary gifts, unique gifts for guys, unique mothers day gifts, unique gift item, unique gift for him, unique gift for women, unique gifts for her, unique gifts for husband, unique gifts for girls, unique luxury gifts, unique xmas gifts, unique cheap gifts, unique friendship gifts, unique gifts for friends, unique personalised gifts">
		<meta name="description" 		content="QuirkyCrackers is where you'll find cool and unique gift ideas. You'll never give a boring gift again with our never ending list of cool products.">
		<cfoutput>
			
			<cfif isquery(featuredproduct) and featuredproduct.recordcount>
				<meta property="og:title"   	content="#featuredproduct.title#" />
				<meta property="og:image"       content="http://www.quirkycrackers.com/quirkycrackers#featuredproduct.img_source#" /> 
				<meta property="og:description" content="#featuredproduct.short_desc#" /> 
			<cfelse>
				<meta property="og:title"   	content="Add Quirk to Life : Online Crazy Unique Stuff / Gift Ideas for Indian Buyers" />
				<meta property="og:image"       content="http://www.quirkycrackers.com/resources/mobile_66.jpg" /> 
				<meta property="og:description" content="QuirkyCrackers is where you'll find cool and unique gift ideas. You'll never give a boring gift again with our never ending list of cool products." /> 
			</cfif>
		</cfoutput>
	<script language="javascript" src="/quirkycrackers/js/cssua.min.js"></script>
	<script language="javascript" src="/quirkycrackers/js/common.js"></script>
	<script language="javascript" src="/quirkycrackers/js/utils.js"></script>
	<link rel="shortcut icon" href="/quirkycrackers/images/favicon.ico">
	<!--- <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"> --->
	<link rel="stylesheet" href="/quirkycrackers/js/jquery-ui.theme.min.css">
	<cfoutput><link rel="stylesheet" href="/quirkycrackers/js/#request.files#.css"></cfoutput>
	<!--- <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"> --->
	<script language="javascript" src="/quirkycrackers/js/jquery-1.11.1.min.js"></script>
	<script language="javascript" src="/quirkycrackers/js/jquery-ui.min.js"></script>
	<script language="javascript" src="/quirkycrackers/js/jquery.resizecrop-1.0.3.min.js"></script>
	<!--- <script language="javascript" src="/quirkycrackers/js/masonry.pkgd.min.js"></script> --->
	<script language="javascript" src="/quirkycrackers/js/isotope.pkgd.min.js"></script>
	<script type="text/javascript" src="/quirkycrackers/js/canvasjs-1.7.0/jquery.canvasjs.min.js"></script>
	<cfoutput><script language="javascript" src="/quirkycrackers/js/#request.files#.js"></script></cfoutput>
	<link rel="stylesheet"  href="/quirkycrackers/js/ion.rangeSlider-1.9.3/css/normalize.min.css"></link>
	<link rel="stylesheet"  href="/quirkycrackers/js/ion.rangeSlider-1.9.3/css/ion.rangeSlider.css"></link>
	<link rel="stylesheet"  href="/quirkycrackers/js/ion.rangeSlider-1.9.3/css/ion.rangeSlider.skinFlat.css"></link>
	<script src="/quirkycrackers/js/ion.rangeSlider-1.9.3/js/ion-rangeSlider/ion.rangeSlider.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/quirkycrackers/js/slick-master/slick/slick.css"/>
	<script language="javascript" src="/quirkycrackers/js/slick-master/slick/slick.min.js"></script>
	<script language="javascript">
		
		function submitform(val,type){
			<cfoutput>
				window.location.href = 'http://#cgi.SERVER_NAME#:#cgi.SERVER_PORT#/#application.cgi_SCRIPT_NAME#?type='+type+'&param='+val;
			</cfoutput>
		}
	</script>
	
	<script type="text/javascript" language="javascript">
  
		  $(document).ready(function(){
		    <!--- $('.resize').resizecrop({
		      width:200,
		      height:200,
		      vertical:"top"
		    });   --->
		    <cfif client.mobile>
		     $('.mustLoad').resizecrop({
		      width:300,
		      height:200,
		      vertical:"top"
		    }); 
		    </cfif>
		    $("body").css("min-width",screen.width*.99);
		    $(".menuContainer").css("min-width",screen.width*.99);
		    $(".mainMenu").css("min-width",screen.width*.99);
		    
		    $(".block").on("click",function(){$(".block").css("display","none");});
		    
		    psort=true;
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
			$('#maintable').css("text-align","center");
			$('#maintable').css("position","relative");
			$('#maintable').css("left",screen.width*0.1);
			$('.scenario').slick({
				  lazyLoad: 'ondemand',
				  autoplay: false,
				  autoplaySpeed: 5000,
				  arrows: true,
				  width:500,
				  height:250,
				  dots:false
				  //,centerMode: true
  				  //,centerPadding: '60px'
				});
			<!--- $('.grid').isotope({ sortBy: 'title' }); --->
		   <!---    $('.grid').masonry({
			  // options
			  itemSelector: '.grid-item',
			  columnWidth: 300
			}); --->
		    
			init();
			<cftry>
				<cfoutput>
					<cfif isdefined("session.sort")>
					var sortby = '';
					sortby = '#StructKeyArray(session.sort)[1]#';
					try {
						$(".sortby_"+sortby).empty();
						$(".sortby_"+sortby).append("<img src='/quirkycrackers/images/#session.sort[StructKeyArray(session.sort)[1]]#.png'>");
					}
					catch(e){}
					</cfif>
				</cfoutput>
			<cfcatch>
			</cfcatch>
			</cftry>
			$("#range_1").ionRangeSlider(
				{
				    min: -100,
				    max: 100,
				    <cfif (isdefined('session.rangeFrom') and session.rangeFrom gte -100) and (isdefined('session.rangeTo') and session.rangeTo lte 100)>
						<cfoutput>
							from: #session.rangeFrom#,
				   	 		to: #session.rangeTo#,
						</cfoutput>
					<cfelse>
						from: -100,
				    	to: 100,
					</cfif>
				    type: 'double',
				    step: 1,
				    postfix: " % drop",
				    <!--- maxPostfix : "+", --->
				    //,hasGrid: true,
				    //gridMargin: 15,
				    onLoad: function (obj) {        // callback is called after slider load and update
				       /// console.log(obj);
				    },
				    onChange: function (obj) {      // callback is called on every slider change
				       //console.log(obj);
				    },
				    onFinish: function (obj) {      // callback is called on slider action is finished
				      <!---  console.log(obj); --->
				      meterparams.droprange.from = obj.from;
				      meterparams.droprange.to = obj.to;
				      <cfif client.mobile>
				      	return;
				      </cfif>
				       $.ajax({
							type: 'get',
						    url: '/quirkycrackers/cmp.cfc?method=setRange&from='+obj.from+'&vto='+obj.to,
						   <!---  cache: false, --->
						    beforeSend : function(a){
						    			 },
						    complete : function(results){
						    				location.reload();
						    			}
						});
				       //loadByRange(obj.from,obj.to,'C');
				    }
				}
			);  
			
			$("#range_2").ionRangeSlider(
				{
				    min: 0,
				    max: 25000,
				    <cfif (isdefined('session.prangeFrom') and session.prangeFrom gte 0) and (isdefined('session.prangeTo') and session.prangeTo lte 25000)>
						<cfoutput>
							from: #session.prangeFrom#,
				   	 		to: #session.prangeTo#,
						</cfoutput>
					<cfelse>
						from: 0,
				    	to: 25000,
					</cfif>
				    type: 'double',
				    step: 10,
				    prefix: "Rs. ",
				     maxPostfix : "+",
				    <!--- maxPostfix : "+", --->
				    //,hasGrid: true,
				    //gridMargin: 15,
				    onLoad: function (obj) {        // callback is called after slider load and update
				       /// console.log(obj);
				    },
				    onChange: function (obj) {      // callback is called on every slider change
				       //console.log(obj);
				    },
				    onFinish: function (obj) {      // callback is called on slider action is finished
				      <!---  console.log(obj); --->
				      
				      meterparams.pricerange.from = obj.from;
				      meterparams.pricerange.to = obj.to;
				    
				       $.ajax({
							type: 'get',
						    url: '/quirkycrackers/cmp.cfc?method=setPriceRange&from='+obj.from+'&vto='+obj.to,
						   <!---  cache: false, --->
						    beforeSend : function(a){
						    			 },
						    complete : function(results){
						    				location.reload();
						    			}
						});
				       //loadByRange(obj.from,obj.to,'C');
				    }
				}
			);  
						
			//$("#rangecontent").css("left",($(window).width()- $("#rangecontent").width())/2);
			<cfif not client.mobile>
				$("#rangecontent").css("left",($(".content").width()- $("#rangecontent").width())/2);
			</cfif>
			//setInterval(function(){$(".footerpopup").slideDown( "slow")}(),5000);
			//$('#meter').slideToggle(10);
			
			setTimeout(function () {
					$(".block").css("display","block");
					$(".footerpopup").slideDown( "slow");
                    //showLoginPopup();
            }, 2000);
            
			$(".sideadgoog").css("top",($(".sidead").height()-$(".sideadgoog").height())/2);
		    $(".mainad").css({
		    	"width":screen.width*.99-600,
		    	"height":"400px"
		    });
		    $(".scenario").css({
				"left":($(".mainad").width()-$('.scenario').width())/2
			});
			
			window.onscroll = function() {getNext()};
			
			<cfif isquery(featuredproduct) and featuredproduct.recordcount>
				$("#featurepid").slideDown();
				$("#featuretable").css("left",($(window).width()-300)/2);
			</cfif>
		    //$(".mainad").append('<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></\script><ins class="adsbygoogle" style="display:block" data-ad-client="ca-pub-9042848322034372" data-ad-slot="2771478442" data-ad-format="auto"></ins><script>(adsbygoogle = window.adsbygoogle || []).push({});</\script>');
		  }); 
		  
		   
		  
		  
		 <!--- function login(){
		  	FB.login(function(response) {
		  		//console.log(response);
			   if (response.authResponse) {
			     FB.api('/me', function(response) {
			     	//console.log("Inner response");
			     	//console.log(response);
			     	register(response);
			     });
			   } else {
			     //console.log('User cancelled login or did not fully authorize.');
			   }
			 },{scope: 'email',return_scopes: true});
		  }
		  
		function showLoginPopup(){
			
			 $.ajax({
						type: 'get',
					    url: '/quirkycrackers/showLoginPopup.cfm',
					   <!---  cache: false, --->
					    beforeSend : function(a){
					    			 },
					    complete : function(results){
					    				//location.reload();
					    			},
					    success : function(results){
					    	
					    	$( "#loginPopup" ).empty();
				    		$( "#loginPopup" ).append(results);
				    		$( "#loginPopup" ).dialog({ 
								autoOpen: false,
								modal:true,
									      buttons: {
								        Close: function() {
								          	$( this ).dialog( "close" );
								          	closeFooter();
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
				    		$( "#loginPopup" ).dialog( "open" );
					    
					    }
					});
		
		} --->

		
		function ValidUrl(str) {
		  var pattern = new RegExp('^(https?:\\/\\/)?'+ // protocol
		  '((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.)+[a-z]{2,}|'+ // domain name
		  '((\\d{1,3}\\.){3}\\d{1,3}))'+ // OR ip (v4) address
		  '(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*'+ // port and path
		  '(\\?[;&a-z\\d%_.~+=-]*)?'+ // query string
		  '(\\#[-a-z\\d_]*)?$','i'); // fragment locator
		  if(!pattern.test(str)) {
		    return false;
		  } else {
		    return true;
		  }
		}
		
		function dropSince(days){
			
			$.ajax({
				type: 'get',
			    url: '/quirkycrackers/cmp.cfc?method=setSince&days='+days,
			   <!---  cache: false, --->
			    beforeSend : function(a){
			    			 },
			    complete : function(results){
			    				location.reload();
			    			}
			});
			
		}
		
		function fluctuate(){
			$.ajax({
				type: 'get',
			    url: '/quirkycrackers/cmp.cfc?method=setfluctuate',
			   <!---  cache: false, --->
			    beforeSend : function(a){
			    			 },
			    complete : function(results){
			    				location.reload();
			    			}
			});
		}
		
		function reset(){
			$.ajax({
				type: 'get',
			    url: '/quirkycrackers/cmp.cfc?method=setReset',
			   <!---  cache: false, --->
			    beforeSend : function(a){
			    			 },
			    complete : function(results){
			    				location.reload();
			    			}
			});
		}
		
		function isUrl(s) {
			var regexp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/
			return regexp.test(s);
			}
		
		function go(){
			submitform((function(){return document.getElementById('search').value})(),'search');
			<!--- if(isUrl(document.getElementById('search').value)){
				submitform((function(){return document.getElementById('search').value})(),'link');
			}
			else{
				submitform((function(){return document.getElementById('search').value})(),'search');
			} --->
			
		}
		
		function saveme(rs){
			
			$.ajax({
				type: 'get',
			    url: '/quirkycrackers/cmp.cfc?method=setSaveme&rs='+rs,
			   <!---  cache: false, --->
			    beforeSend : function(a){
			    			 },
			    complete : function(results){
			    				location.reload();
			    			}
			});
		}
		
		function sortby(what,order){
			
			$.ajax({
				type: 'get',
			    url: '/quirkycrackers/cmp.cfc?method=setSortby&what='+what+'&order='+order,
			   <!---  cache: false, --->
			    beforeSend : function(a){
			    			 },
			    complete : function(results){
			    				location.reload();
			    			}
			});
		}
		
		function closeFooter(){
			$.ajax({
				type: 'get',
			    url: '/quirkycrackers/cmp.cfc?method=setSessionVar&what=showsub&value=0',
			   <!---  cache: false, --->
			    beforeSend : function(a){
			    			 },
			    complete : function(results){
			    				//location.reload();
			    			}
			});
			$(".footerpopup").slideUp( "slow");
			$(".block").css( "display","none");
		}
		
		function gosubscribe(){
		var email = $("#email").val();
		if(isValidEmailAddress(email)){
			$.ajax({
				type: 'GET',
			    url: '/quirkycrackers/cmp.cfc?method=subscribe&email='+email,
			   <!---  cache: false, --->
			    beforeSend : function(a){
			    				$(".alertmsg").empty();
			    			 },
			    complete : function(results){
			    				$(".alertmsg").append("Thanks!");
			    				$(".footerpopup").slideUp( 3000);
			    			}
			});
		}
		else{
			$(".alertmsg").empty();
			$(".alertmsg").append("Email doesn't look ok!");
		}
		
	}
	
	<!--- function login(){
		  	FB.login(function(response) {
		  		//console.log(response);
			   if (response.authResponse) {
			     FB.api('/me', function(response) {
			     	//console.log("Inner response");
			     	//console.log(response);
			     	register(response);
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
	}
	
	<!--- $.ajax({
		    type: 'POST',
		    url: '/quirkycrackers/cmp.cfc?method=registerfb',
		    data: { 
		        'email': '', 
		        'password': 'fbpass',
		        'fb_id':fb_id,
		        'fb_resObj':fb_resObj,
		        'source':'FTB'
		    },
		    success: function(res){
		    	res = $.parseJSON(res);
		    	if(res.LOGUSER == true){
		    		window.location="/quirkycrackers/";
		    	}
		    }
		}); --->
	 } --->
	 
	 function doLogin(){
			<cfoutput>
				window.location.href = 'http://#cgi.SERVER_NAME#:#cgi.SERVER_PORT#/quirkycrackers/login/?email='+email;
			</cfoutput>
		}

		function trackit(pid){
				email = $("#quickemail_"+pid).val();
				dropto = $("#pricedrop_"+pid).val();
				if(isValidEmailAddress(email)){
				 $.ajax({
					type: 'GET',
					    url: '/quirkycrackers/cmp.cfc?method=adduser&email='+email+'&dropto='+dropto+'&pid='+pid,
				    beforeSend : function(a){
				    				$("#emailalert_"+pid).empty();
				    				$("#trackitbutton_"+pid).empty()
				    				$("#trackitbutton_"+pid).append("Tracking...");
				    			 },
				    complete : function(results){
								},
					success : function(results){
								var ret = results;	
								if(ret.ERROR == 1){
									$("#emailalert_"+pid).empty();
									$("#emailalert_"+pid).append("We apologies! Please try again! :(");
									$("#trackitbutton_"+pid).empty()
				    				$("#trackitbutton_"+pid).append("Quick track!");
									return;
								}
								
								$("#user_sk").val(ret.USER_SK);
								$("input[name='email']").val(email);
								if(ret.ISACCOUNTSETUP == 0){
									$("#quicktrackbox_"+pid).hide();
									$("#passwordbox_"+pid).show();
								}
								else{
									$("#quicktrackbox_"+pid).empty();
									$("#quicktrackbox_"+pid).css({
										"border":"0px sold rgba(255,255,255,0)",
										"text-align":"center",
										"font-size":"medium"
									});
									
									$.ajax({
										type: 'POST',
									    url: '/quirkycrackers/cmp.cfc?method=setClientvar&what=email&value='+email,
									   <!---  cache: false, --->
									    beforeSend : function(a){
									    				//$("#update"+id).text("Updating...");
									    			 },
									    complete : function(results){
									    				//$("#update"+id).text("Update");
									    			}
									});
			
									<cfif isdefined("client.user_sk")>
										$("#quicktrackbox_"+pid).append("Tracking successful!");
									<cfelse>
										$("#quicktrackbox_"+pid).append("Tracking successful! <br>You are already with us. Why not <span style='cursor: pointer; cursor: hand;' onclick='doLogin();'>Login</span> and checkout your dashboard.");
									</cfif>
									
								}
							  },
					error : function(){
						$("#emailalert_"+pid).empty();
						$("#emailalert_"+pid).append("We apologies! Please try again! :(");
					}
				});
			}
			else{
				$("#emailalert_"+pid).empty();
				$("#emailalert_"+pid).append("Email doesn't look good!");
			}
		}
		
	</script>
	
	<!--- <style>
		.thatsall {
			display:none;
		}
		.ui-dialog .ui-dialog-buttonpane .ui-dialog-buttonset {
		   float: none;
		}
		
		.ui-dialog .ui-dialog-buttonpane {
		     text-align: center; /* left/center/right */
		}
	</style> --->
</head>
<body style="position:relative;">
	<!--- <cfset trending = obj.trending()> --->
	<script>
	  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	
	  <cfoutput>ga('create', '#application.goog#', 'auto');</cfoutput>
	  ga('require', 'displayfeatures');
	  ga('send', 'pageview');
	
	</script>
	<cfinclude template="header.cfm">
	<input name="user_sk" id="user_sk" type="hidden">
	<!--- <div class="inputFields">
		<div class="inputSet" style="overflow: auto;white-space: nowrap;">
			<span><input type="text" name="search" id="search" placeholder=" Search Product or Paste any Amazon/Flipkart Link..." size="80" onkeydown="if (event.keyCode == 13) { go(); }"></span>
		    <span><button type="submit" onclick="go();">Go!</i></button></span>
		    <!--- submitform((function(){return document.getElementById('search').value})(),'search') --->
			<!--- <input type="button" onclick="submitform((function(){return document.getElementById('search').value})(),'search')" value="Find Products"> --->
		</div>
		<!--- <div style="height:20px"></div>
		<div class="inputSet" style="overflow: auto;white-space: nowrap;">
			<input type="text" name="search" id="searchlink" placeholder=" OR Paste any Amazon or Flipkart Link..." size="80" onkeydown="if (event.keyCode == 13) { submitform((function(){return document.getElementById('searchlink').value})(),'link'); }">
			<button type="submit" onclick="submitform((function(){return document.getElementById('searchlink').value})(),'link')">Go!</i></button>
			<!--- <input type="button" onclick="submitform((function(){return document.getElementById('searchlink').value})(),'link')" value="Find by Link"> --->
		</div> --->
	</div> --->
	<cfif isquery(featuredproduct) and featuredproduct.recordcount>
	<div style="display:none;width:100%;position:fixed;top:50px;z-index:110;background-color:green;" id="featurepid">
	<cfoutput>
		<div id="featuretable" style="position:relative;color:white;">
			<div style="height:10px"></div>
			<div class="title sanss" style="max-width:300px;width:300px;text-align:center;">#featuredproduct.title#</div>
			<div style="height:5px"></div>
			<div style="float: rightt;">
				<a href="#featuredproduct.link#" target="_blank"><img src="/quirkycrackers/#featuredproduct.img_source#" class="resize"></a>
			</div>
			<div style="max-width:300px;width:300px;float: rightt;">
				#featuredproduct.short_desc#
				<br>Rs. #featuredproduct.last_price#
				<div style="height:5px"></div>
				<table style="width:100%"><tr>
					<td style="text-align:left;"><a href="#featuredproduct.link#" target="_blank" style="color:white;">Buy/Details</a></td>
					<td style="text-align:right;"><span style="cursor: pointer; cursor: hand;" onclick="$('##featurepid').slideUp();">Close This</span></td>
				</tr></table>
			</div>
			<div style="height:10px"></div>
		</div>
	</cfoutput>
	</div>
	</cfif>
	<div style="height:10px"></div>
	<cfif url.type eq 'search' and isdefined("url.param")>
		<cfoutput><div style="color:green;font-size:large;text-align:center;font-family:'Verdana', Verdana, sans-serif;">
			Search Result: #url.param#
			<span style="cursor: pointer; cursor: hand;" onclick="window.location = 'http://#cgi.SERVER_NAME#:#cgi.SERVER_PORT#/#application.cgi_SCRIPT_NAME#';"> X </span></div>
			</cfoutput>
	</cfif>
	<cfset bcategories = obj.getCategories()>
	
	<cfif (url.type eq 'link')>
			<cfif invalidlink>
				<div class="title sanss" style="color:red;text-align:center">You seemed to entered invalid link. As of now, we support links from Amazon & Flipkart<br>
				If you think, you entered valid Flipkart/Amazon Product Link, we apologise. We'll check the issue and correct it ASAP.
				</div>
			<cfelse>
					<cftry>
						<cfoutput>
							<div id="#pdetails.pid#" class="fkProduct wrapper" style="height:325px;text-align:center;border-bottom:1px solid gray;border-top:15px solid white">
								<div class="title sanss" style="color:red">The link you searched returned this product</div>
								<div class="title sanss" title="#pdetails.title#">#left(pdetails.title,28)#..</div>
								<div><a href="#pdetails.link#" target="_blank"><img src="#pdetails.image#" class="resize"></a></div>
								<div style="height: 30px;vertical-align: middle;display: inline-block;" >
									<cfif moversthis.recordcount>
										<cfset idx = 1>
										<cfif moversthis.type[idx] eq 0>
											<cfset wrapClass = "fkProduct">
											<cfset logo = "/quirkycrackers/images/fklogo.jpg">
										<cfelse>
											<cfset wrapClass = "azProduct">
											<cfset logo = "/quirkycrackers/images/azlogo.jpg">
										</cfif>
										<cfset color = 'Black'>
										<cfif movers.variance[idx] lt 0>
											<cfset color = 'Red'>
										<cfelseif movers.variance[idx] eq 0>
											<cfset color = 'Black'>
										<cfelseif movers.variance[idx] gt 0>
											<cfset color = 'Green'>
										</cfif>
										<span class="sanss" style="display: inline-block;vertical-align: middle;color:#color#">
											#moversthis.variance[idx]#%
										</span>
										<span class="sanss" style="display: inline-block;vertical-align: middle;">
											<cfif moversthis.variance lt 0>
												<img src="/quirkycrackers/images/down.png">
											<cfelseif moversthis.variance[idx] eq 0>
											<cfelseif moversthis.variance[idx] gt 0>
												<img src="/quirkycrackers/images/up.png">
											</cfif>
										</span>
										<span class="sanss" style="display: inline-block;vertical-align: middle;">Rs. #numberformat(moversthis.last_price[idx])#</span>
										<span style="display: inline-block;vertical-align: middle;"><img src="#logo#" width="25px" height="25px"></span>
								<cfelse>
									<span class="sanss" style="display: inline-block;vertical-align: middle;">Rs. #numberformat(pdetails.price)#</span>
								</cfif>
								</div>
								<div>
									<span class="sanss" style="border-left:5px solid white;border-right:5px solid white;cursor: pointer; cursor: hand;" onclick="getchart('#pdetails.pid#','#pdetails.title#','#pdetails.image#')">Track It</span>
									<span class="sanss" style="border-left:5px solid white;border-right:5px solid white;"><a href="#pdetails.link#" target="_blank" style="text-decoration:none;color:black;">Check Out</a></span>
								</div>
							</div>
						</cfoutput>
					<cfcatch>
						<!--- <cfdump var="#data.productInfoList[idx].productBaseInfo.productAttributes.imageUrls#"> --->
					</cfcatch>
					</cftry>
			</cfif>
			<!--- <cfset url.type = 'browse'> --->
			<cfset url.type = 'trends'>
		</cfif>
	
	<!--- <cfinclude template="#request.files#_meter.cfm"> --->	
	<cfset wrapArray = arraynew(1)>

	<!--- <cfif isdefined("url.type")>
		<cfif (url.type eq 'search')>
			<div class="grid" id="mainGrid">
			<cfloop from="1" to="#movers.recordcount#" index="idx">
				<cfif movers.type[idx] eq 0>
					<cfset wrapClass = "fkProduct">
					<cfset logo = "/quirkycrackers/images/fklogo.jpg">
				<cfelse>
					<cfset wrapClass = "azProduct">
					<cfset logo = "/quirkycrackers/images/azlogo.jpg">
				</cfif>
				
				<cfoutput>
					<div id="#movers.pid[idx]#" class="grid-item #wrapClass#" data-category="#wrapClass#" style="height:285;text-align:center;border-bottom:1px solid gray;border-top:15px solid white">
						<div class="title sanss" title="#movers.title[idx]#">#left(movers.title[idx],28)#..</div>
						<div style="font-size:x-small;color:gray;">Product ID: #movers.pid[idx]#</div>
						<div><a href="#movers.link[idx]#" target="_blank"><img src="#movers.image[idx]#" class="resize"></a></div>
						<div style="height:2px"></div>
						<div style="height: 30px;vertical-align: middle;display: inline-block;" >
							<cfset color = 'Black'>
							<cfif movers.variance[idx] lt 0>
								<cfset color = 'Red'>
							<cfelseif movers.variance[idx] eq 0>
								<cfset color = 'Black'>
							<cfelseif movers.variance[idx] gt 0>
								<cfset color = 'Green'>
							</cfif>
							<cfif len(movers.variance[idx])>
								<span class="sanss" style="display: inline-block;vertical-align: middle;color:#color#">
									#movers.variance[idx]#%
								</span>
								<span class="sanss" style="display: inline-block;vertical-align: middle;">
									<cfif movers.variance[idx] lt 0>
										<img src="/quirkycrackers/images/down.png">
									<cfelseif movers.variance[idx] eq 0>
									<cfelseif movers.variance[idx] gt 0>
										<img src="/quirkycrackers/images/up.png">
									</cfif>
								</span>
							</cfif>
							<span class="sanss" style="display: inline-block;vertical-align: middle;">Rs. <!--- <span class="price sanss" style="display:none;vertical-align: middle;">#movers.last_price[idx]#</span> --->#numberformat(movers.last_price[idx])#</span>
							<span style="display: inline-block;vertical-align: middle;"><img src="#logo#" width="25" height="25"></span>
						</div>
						
						<div>
							<span class="sanss" style="border-left:5px solid white;border-right:5px solid white;cursor: pointer; cursor: hand;" onclick="getchart('#movers.pid[idx]#')">Track It</span>
							<span class="sanss" style="border-left:5px solid white;border-right:5px solid white;"><a target="_blank" href="#movers.link[idx]#" style="text-decoration:none;color:black;">Check Out</a></span>
						</div>
					</div>
				</cfoutput>
			</cfloop>
			</div>
			<cfif movers.recordcount lt 12>
				<div style="color:gray;font-weight:bold;text-align:center;border-top:20px solid white">
				<script type="text/javascript">
					$.ajax({
							type: 'GET',
						    <cfoutput>
							    url: '/quirkycrackers/livedata.cfm?keyword=#url.param#',
							</cfoutput>
						   <!---  cache: false, --->
						    beforeSend : function(a){
						    			 },
						    complete : function(results){
						    		$(".thatsall").show();
						    	},
						    success : function(results){
						    		$("#mainGridLive").empty();
						    		$("#mainGridLive").append(results);
						    	}
							});
							
				</script>
				</div>
				
				<div class="gridlive" id="mainGridLive" style="color:gray;font-weight:bold;text-align:center;">
					<div>Trying to find more products directly from Amazon/Flipkart</div>
					<img alt="" width="160" height="120" src="/quirkycrackers/images/loader_gif.gif"/>
				</div>
			<cfelse>
				<script type="text/javascript">
					 $(document).ready(function(){
					 	$(".thatsall").show();
					 });
				</script>
			</cfif>
		
		</cfif>
		
	</cfif> --->
		
		
<div id="dialog" class="dialogcss" title="Price History"></div>
<div id="loginPopup" class="dialogcss" title="Login"></div>

<cfif url.type eq 'browse' or url.type eq 'trends' or url.type eq 'search'>
	
	<div class="grid" id="mainGrid" style="border:1px solud black">
	<cfsavecontent variable="mover_divs">
	<cfloop from="1" to="#movers.recordcount#" index="idx">
		<cfoutput>
			<cfif idx eq 14>
				<div class="grid-item  wrapper">
								<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
				<!-- FTB_PROD -->
				<ins class="adsbygoogle"
				     style="display:inline-block;width:336px;height:280px"
				     data-ad-client="ca-pub-9042848322034372"
				     data-ad-slot="8399209643"></ins>
				<script>
				(adsbygoogle = window.adsbygoogle || []).push({});
				</script>
				</div>
			</cfif>
			<div id="product_#movers.idproduct_main[idx]#" <cfif not client.mobile>onmouseenter="$('###movers.idproduct_main[idx]#_options').slideDown(75);" onmouseleave="$('###movers.idproduct_main[idx]#_options').slideUp(75);"</cfif> class="grid-item  wrapper"  style="height:285px;text-align:center;border:1px dotted gray;<!---border-bottom:1px solid gray; border-top:15px solid white --->">
				<cfset movers.title[idx] = REReplace(movers.title[idx], "[^0-9a-zA-Z _]", "", "ALL")>
				<!--- <cfif len(session.saveme) and session.saveme neq 0 and not client.mobile>
					<div id="#movers.pid[idx]#_options" class="savestamp" style="position:absolute;top:0;left:0;z-index:2;display:none;">
						<a href="#movers.link[idx]#" target="_blank">
							<img src="/quirkycrackers/images/save.png">
							<div style="position:absolute;top:65;z-index:2;font-weight:bold;width:100%;"><div style="text-align:center;width:100%;font-size:large;" ><cfoutput>&##8377; #abs(movers.difference[idx])#</cfoutput></div></div>
						</a>
					</div>
				</cfif> --->
				<cfset op_top = 30>
				<cfif client.mobile>
					<cfset op_top = 60>
				</cfif>
				<!--- <div id="#movers.pid[idx]#_options" class="options" style="position:absolute;top:0;left:0;z-index:2;display:none;background-color:rgba(0,0,0,0.7);">
						<div style="position:absolute;left:2;top:28;display: inline-block;vertical-align: middle;"><img src="#logo#" width="25" height="25"></div>
						<cfif client.mobile>
							<div onclick="$('###movers.pid[idx]#_options').slideToggle(75);" style="position:absolute;right:5;top:28;display: inline-block;vertical-align: middle;color:white;font-size:large">X</div>
						</cfif>
						<div style="height:#op_top#px;"></div>
						<div style="border:0px solid black;color:white" class="quicktrackbox" id="quicktrackbox_#movers.pid[idx]#">
							<cfif not isdefined("client.email")>
								<span class="textsize" style="border:0px solid black;" <!--- onblur="$('.emailalert').hide();" --->> <input name="email" id="quickemail_#movers.pid[idx]#" size="30" placeholder="Send me@mymail.com Alert" class="hist_input" <!--- style="font-size:small;width:250" --->></span>
							<cfelse>
								<span class="textsize" style="border:0px solid black;" <!--- onblur="$('.emailalert').hide();" --->> <input name="email" id="quickemail_#movers.pid[idx]#" size="30" placeholder="Send me@mymail.com Alert" value="#client.email#" class="hist_input" <!--- style="font-size:small;width:250" --->></span>
							</cfif>
							
							<span>
							<select name="pricedrop" id="pricedrop_#movers.pid[idx]#" class="hist_input" <!--- style="font-size:small;width:250" --->>
								<option value="1" style="font-size:small">When price drops to Less then 5%</option>
								<option value="2" style="font-size:small">When price drops to 5% to 10%</option>
								<option value="3" style="font-size:small">When price drops to 10% to 20%</option>
								<option value="4" style="font-size:small">When price drops to 20% to 50%</option>
								<option value="5" style="font-size:small">When price drops to 50+%</option>
							</select>
							</span>
							<span>
								<!--- <br>
							<button value="Track it!" onclick="trackit('#movers.pid[idx]#')" type="submit" id="trackitbutton">Quick Track!</button></span> --->
							<div style="height:5px;"></div>
							<div id="trackitbutton_#movers.pid[idx]#" onclick="trackit('#movers.pid[idx]#')" class="hist_button hist_button_small" <!--- style="position:absolute;width:250;height:20px;line-height: 20px;background-color:rgb(131, 220, 14);border-radius: 5px;color:white;" --->>
								Quick Track
							</div>
							<div style="border:0px solid black;background-color:black;">
								<span class="textsize" style="width:100px;color:red;" id="emailalert_#movers.pid[idx]#" class="emailalert"></span> 
							</div>
						</div>
						
						<div id="passwordbox_#movers.pid[idx]#" class="passwordbox" style="display:none;font-size:small;color:white;">
							<div style="border:50x solid rgba(0,0,0,0);color:white;">
								Your alert is setup! Setup a password & manage alerts. See a dashboard with all products that you are tracking.
							</div>
							<div style="border:5px solid rgba(0,0,0,0);text-align:center;">
							<input name="password" id="password_#movers.pid[idx]#" type="password" size="30" placeholder="Please enter password" style="font-size:small"> 
							<button value="Track it!" onclick="QuicksetupAccount('#movers.pid[idx]#');" type="submit">Setup Account</button>
							<span class="textsize" style="width:100px;color:red;" id="passwordalert"></span> 
							</div>
						</div>
						<div class="hist_gap" <!--- style="height:55px;" --->></div>
						<div class="hist_gap "<!--- style="height:70px;" --->></div>
						<div class="hist_button hist_button_big" onclick="getchart('#movers.pid[idx]#')" <!--- style="position:absolute;width:250;height:50px;line-height: 50px;background-color:rgb(131, 220, 14);border-radius: 10px;color:white;font-size:large;" --->>
						Price History
						</div>
						<div class="hist_gap "<!--- style="height:70px;" --->></div>
						<div class="hist_gap "<!--- style="height:70px;" --->></div>
						<a target="_blank" href="#movers.link[idx]#" style="text-decoration:none;color:white;">
						<div class="hist_button hist_button_big" <!--- style="position:absolute;width:250;height:50px;line-height: 50px;background-color:rgb(131, 220, 14);border-radius: 10px;color:white;font-size:large;" --->>
						Buy / Details
						</div>
						</a>
						<!--- <div style="position:absolute;top:65;z-index:2;font-weight:bold;width:100%;">
							<div style="text-align:center;width:100%;font-size:large;" >
							</div>
						</div> --->
				</div> --->
				<div>
					<div class="title sanss" style="z-index:20;position:relative;background-color:white;" title="#movers.title[idx]#">#left(movers.title[idx],28)#..</div>
					<!--- <div style="font-size:x-small;color:gray;z-index:20;position:relative;background-color:white;">Product ID: #movers.idproduct_main[idx]#</div> --->
				</div>
				<div style="height:2px"></div>
				<div><a href="#movers.link[idx]#" target="_blank"><img src="/quirkycrackers/#movers.img_source[idx]#" class="resize"></a></div>
				<div style="height:2px"></div>
				<div style="height: 30px;vertical-align: middle;display: inline-block;" >
					<cfset color = 'Black'>
					<span class="sanss" style="display: inline-block;vertical-align: middle;">Rs. <!--- <span class="price sanss" style="display:none;vertical-align: middle;">#movers.last_price[idx]#</span> --->#numberformat(movers.last_price[idx])#</span>
					<!--- <span style="display: inline-block;vertical-align: middle;"><img src="#logo#" width="25" height="25"></span> --->
				</div>
				
				<!--- <div>
					<span class="sanss" style="border-left:5px solid white;border-right:5px solid white;cursor: pointer; cursor: hand;" onclick="getchart('#movers.pid[idx]#')">Track It</span>
					<span class="sanss" style="border-left:5px solid white;border-right:5px solid white;"><a target="_blank" href="#movers.link[idx]#" style="text-decoration:none;color:black;">Check Out</a></span>
				</div> --->
				
			</div>
		</cfoutput>
	</cfloop>
	</cfsavecontent>
	<cfif isdefined("url.mode") and url.mode eq 'ajax'>
		<cfcontent reset="true" variable="#toBinary(tobase64(mover_divs))#">
		<cfabort>
	<cfelse>
		<cfoutput>#mover_divs#</cfoutput>
	</cfif>
	</div>
	<!--- <cfif movers.recordcount lt 12 and url.type eq 'search'>
		<div style="color:gray;font-weight:bold;text-align:center;border-top:20px solid white">
		<script type="text/javascript">
			$.ajax({
					type: 'GET',
				    <cfoutput>
					    url: '/quirkycrackers/livedata.cfm?keyword=#url.param#',
					</cfoutput>
				   <!---  cache: false, --->
				    beforeSend : function(a){
				    			 },
				    complete : function(results){
				    		$(".thatsall").show();
				    	},
				    success : function(results){
				    		$("#mainGridLive").empty();
				    		$("#mainGridLive").append(results);
				    	}
					});
					
		</script>
		</div>
		
		<div class="gridlive" id="mainGridLive" style="color:gray;font-weight:bold;text-align:center;">
			<div>Trying to find more products directly from Amazon/Flipkart</div>
			<img alt="" width="160" height="120" src="/quirkycrackers/images/loader_gif.gif"/>
		</div>
	<cfelse>
		<script type="text/javascript">
			 $(document).ready(function(){
			 	$(".thatsall").show();
			 });
		</script>
	</cfif> --->
</cfif>
	
<cfset prev=0>
<cfset next=0>
<cfif isdefined("url.page") and isnumeric(url.page) and url.page gt 0>
	<cfset prev = url.page-1>
	<cfset next = url.page+1>
<cfelse>
	<cfset url.page = 1>
	<cfset prev = url.page-1>
	<cfset next = url.page+1>
</cfif>



<cfif movers.recordcount lt 12>
	<div class="thatsall" style="font-size:large;color:gray;text-align:center;border-top:10px solid white;display:block">
	That's All Folks
	</div>
<cfelse>
	<!--- <cfoutput>
	<table width="100%" align="center">
	<tr>
		<td width="45%" align="right">
			<cfif prev gt 0>
				<cfif prev eq 1>
					<a href="/quirkycrackers/?type=#url.type#&param=#url.param#">
				<cfelse>
					<a href="/quirkycrackers/?type=#url.type#&param=#url.param#&page=#prev##catparam#">
				</cfif>
				PREVIOUS</a>
			<cfelse>
				PREVIOUS
			</cfif>
		</td>
		<td width="10%"></td>
		<td width="45%" align="left"><a href="/quirkycrackers/?type=#url.type#&param=#url.param#&page=#next##catparam#">NEXT</a></td></tr>
	</table>
	</cfoutput> --->
	<cfoutput>
	<table width="100%" align="center">
	<tr>
		<!--- <td width="45%" align="right">
			<cfif prev gt 0>
				<cfif prev eq 1>
					<a href="/fkaz/?type=#url.type#&param=#url.param#">
				<cfelse>
					<a href="/fkaz/?type=#url.type#&param=#url.param#&page=#prev##catparam#">
				</cfif>
				PREVIOUS</a>
			<cfelse>
				PREVIOUS
			</cfif>
		</td>
		<td width="10%"></td> --->
		<td width="100%" align="center"><!--- <a href="/fkaz/?type=#url.type#&param=#url.param#&page=#next##catparam#">NEXT</a> --->
		<span id="loadingtext" style="display:none;"><img src="images/loader_gif.gif"/></span>
		</td></tr>
	</table>
	</cfoutput>
</cfif>

<div style="height:20px"></div>
<cfif session.showsub>
	<div class="block"></div>
	<div class="footerpopup" style="color:white;background-color:black;">
		<div class="xclose" onclick="closeFooter()">X</div>
		<div class="poptitle">Login with Facebook. Stay Updated.</div>
		<div>
		<a href="" onclick="return false;" style="text-decoration:none;">
			<div style="text-align:center;">
				<div class="hover_black" style="background-color:blue;color:white;" onClick="login();">Login With Facebook</div>
			</div>
		</a>
		</div>
		<!--- 
<div class="popemail"><input style="width:70%;text-align:center;" type="text" name="email" id="email" placeholder="myemail@something.com" size="80" onkeydown="if (event.keyCode == 13) { gosubscribe(); }"><button type="submit" onclick="gosubscribe();">Go!</i></button></div>
		<div class=" popsmall alertmsg" style="color:red;text-decoration:underline;"></div>
		<div class="popsmall"><span style="color:red">NO SPAM Guarantee</span> | Once in a week Quirky Products updates | Please check your SPAM folder after entering email</div>
 --->
	</div>
</cfif>
<div class="footer">
	Copyrights 2015. A <a href="http://www.QuirkyCrackers.com" target="_blank">QuirkyCrackers.com</a> Productions
	<br> Email : hello@quirkycrackers.com
</div>

<cfif not client.mobile>
</div> <!--- content class end --->
	<div class="sidead">
		<div class="sideadgoog">
			<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
			<!-- FTB_SIDE_large -->
			<ins class="adsbygoogle"
			     style="display:inline-block;width:300px;height:600px"
			     data-ad-client="ca-pub-9042848322034372"
			     data-ad-slot="2568695244"></ins>
			<script>
			(adsbygoogle = window.adsbygoogle || []).push({});
			</script>
		</div>
	</div>
</cfif>

<script>
	function getNext(){
		
		if($(window).scrollTop() == ($(document).height() - $(window).height())){
			
		}
		else{
			return;
		}
		
		if(_paging.ajaxing) return;
		else _paging.ajaxing = true;
		
		_paging.page = _paging.page+1;
		var url = '/quirkycrackers/?type='+_paging.type+'&param='+_paging.param+'&page='+_paging.page+_paging.catparam+'&mode=ajax';
		<cfoutput>ga('create', '#application.goog#', 'auto');</cfoutput>
		  ga('require', 'displayfeatures');
		  ga('send', 'pageview');
		 $.ajax({
							type: 'get',
						    url: url,
						   <!---  cache: false, --->
						    beforeSend : function(a){
						    		console.log("ajaxing");
						    		console.log(_paging);
						    		$("#loadingtext").show();
						    			 },
						    complete : function(results){
						    		console.log(results);
						    		_paging.ajaxing = false;
						    		$("#loadingtext").hide();
						    		$items = $(results.responseText);
						    		$("#mainGrid").append($items).isotope( 'appended', $items );
						    		$('.resize').resizecrop({
								      width:200,
								      height:200,
								      vertical:"top"
								    });  
								    $('.resizecrop').show();
								    $(".options").css({
										"height":$(".wrapper").height()
									});
									$(".options").css({
										"width":$(".wrapper").width()
									});
									$(".hist_button").css("left",($(".wrapper").width()-250)/2);
									$(".hist_button").css("cursor","pointer");
									$(".hist_button").css("cursor","hand");
									<cfif client.mobile>
										$('#mainGrid').css("min-width","300px");
										$('.grid-item').css("min-width","300px");
									<cfelse>
										$('.grid-item').css("width",$('#mainGrid').width()/3-20);
									</cfif>
						    		
						    		$('.grid').isotope('layout');
						    		
						    		//$(".grid").append(results.responseText);
						    			}
						});
	}	
</script>
</body>
</html>