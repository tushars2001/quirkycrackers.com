<cfset ran = randRange(0,200)>
<cfquery name="getall" datasource="product">
	SELECT CONCAT( a.name,  '.', b.name ) as email
	FROM (
	
	SELECT name
	FROM email_names
	WHERE TYPE =  'first_name'
	LIMIT #ran# , 70
	)a, (
	
	SELECT name
	FROM email_names
	WHERE TYPE =  'last_name'
	LIMIT #ran# , 70
	)b
</cfquery>

<cfset domains = arraynew(1)>
<!--- <cfset arrayappend(domains,"@techmahindra.com")>
<cfset arrayappend(domains,"@hcl.in")>
<cfset arrayappend(domains,"@infosys.com")>
<cfset arrayappend(domains,"@capgemini.com")>
<cfset arrayappend(domains,"@wipro.com")> --->
<cfset arrayappend(domains,"@yahoo.com")>
<cfset arrayappend(domains,"@gmail.com")>
<cfset arrayappend(domains,"@outlook.com")>
<cfset arrayappend(domains,"@rediffmail.com")>
<cfset arrayappend(domains,"@indiatimes.com")>

<cfmail to="tushars2001@gmail.com" from="hello@quirkycrackers.com" subject="Indian History in Pictures" type="html" failto="tushars2001@gmail.com">
	<html>
		<head></head>
		<body>
			<p>Hey,</p>
	
			<p>I found these 200+ RAREST of rare indian historical pictures and thought it's worth share with you. 
			<br><span style="background-color:yellow;font-weight:bold">Hope you'd like it and if so, why not fwd this to ur frnz n family!
			</span>
			</p>
			<cfoutput>
			<a href="http://quirkycrackers.com/quirkycrackers/indian-history-in-pictures/?utm_source=email&utm_medium=email_r&utm_campaign=indiahistory&email_id=tushars2001@gmail.com" style="text-decoration:none;font-weight:bold;color:black;text-decoration: underline;">
			</cfoutput>
			<p>Rabindranath Tagore with Albert Einstein.</p>
			 <p>
				<img src="https://scontent-hkg3-1.xx.fbcdn.net/hphotos-xaf1/v/t1.0-9/12038099_10207688894240132_1226652716262229041_n.jpg?oh=1cece73f37e885878844daff69fd2c20&oe=571E7FC5">
			</p>
			<p>Indias missile man, APJ Abdul Kalam from his college days.</p>
			 <p>
				<img src="https://scontent-hkg3-1.xx.fbcdn.net/hphotos-xtf1/v/t1.0-9/11108835_10207688895000151_6024160485447340425_n.jpg?oh=17df8540e42840dbb416692ced95329f&oe=56D4FA62">
			</p>
			<p>Amitabh Bachchan and family, 1970.</p>
			 <p>
				<img src="https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xtf1/v/t1.0-9/12009622_10207688894640142_6342644401008942685_n.jpg?oh=7445e0f621d77d368cda9f09685c5c19&oe=56DB300F&__gda__=1457656875_033ec6901b78cc3643fddcfe50bee05d">
			</p>
			<p>A young A. R. Rahman with Yesudas.</p>
			 <p>
				<img src="https://scontent-hkg3-1.xx.fbcdn.net/hphotos-xpt1/v/t1.0-9/12038404_10207688895360160_4466796252214153947_n.jpg?oh=5fb9c4ce496e7ebb5a7b83de7f55b319&oe=57135859">
			</p>
			
			<p>Hope you like these and 200+ more.</p>
			</a>
			
			<p>Thanks</p>
			
			<p><br></p>
			<cfoutput><p style="font-size:small;"><a href="http://quirkycrackers.com/quirkycrackers/indian-history-in-pictures/?utm_source=email&utm_medium=email_r&utm_campaign=indiahistory&email_id=tushars2001@gmail.com&active=0">Unsubscribe</p></cfoutput>
	
		</body>
	</html>
	
	</cfmail>

<cffunction name="snooz" access="public" output="false" returntype="void" hint="Leverages Java's sleep() function">
   <cfargument name="timeToSleep" type="numeric" required="true" />

   <cfscript>
      createObject("java", "java.lang.Thread").sleep(arguments.timeToSleep);    //sleep time in milliseconds
      return;
   </cfscript>
</cffunction>

<cfloop from="1" to="#getall.recordcount#" index="idx">
	<cfset ran = randRange(1,arraylen(domains))>
	<cfset email_id = "#getall.email[idx]##domains[ran]#">
	<cftry>
	<cfquery name="insert" datasource="product">
		insert into email_random (email_id,campagin) values ('#email_id#','indiahistory')
	</cfquery>
	<cfmail to="#getall.email_id[idx]#" from="hello@quirkycrackers.com" subject="Indian History in Pictures" type="html">-
	<html>
		<head></head>
		<body>
			<p>Hey,</p>
	
			<p>I found these 200+ RAREST of rare indian historical pictures and thought it's worth share with you. 
			<br><span style="background-color:yellow;font-weight:bold">Hope you'd like it and if so, why not fwd this to ur frnz n family!
			</span>
			</p>
			<cfoutput>
			<a href="http://quirkycrackers.com/quirkycrackers/indian-history-in-pictures/?utm_source=email&utm_medium=email_r&utm_campaign=indiahistory&email_id=#email_id#" style="text-decoration:none;font-weight:bold;color:black;text-decoration: underline;">
			</cfoutput>
			<p>Rabindranath Tagore with Albert Einstein.</p>
			 <p>
				<img src="https://scontent-hkg3-1.xx.fbcdn.net/hphotos-xaf1/v/t1.0-9/12038099_10207688894240132_1226652716262229041_n.jpg?oh=1cece73f37e885878844daff69fd2c20&oe=571E7FC5">
			</p>
			<p>Indias missile man, APJ Abdul Kalam from his college days.</p>
			 <p>
				<img src="https://scontent-hkg3-1.xx.fbcdn.net/hphotos-xtf1/v/t1.0-9/11108835_10207688895000151_6024160485447340425_n.jpg?oh=17df8540e42840dbb416692ced95329f&oe=56D4FA62">
			</p>
			<p>Amitabh Bachchan and family, 1970.</p>
			 <p>
				<img src="https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-xtf1/v/t1.0-9/12009622_10207688894640142_6342644401008942685_n.jpg?oh=7445e0f621d77d368cda9f09685c5c19&oe=56DB300F&__gda__=1457656875_033ec6901b78cc3643fddcfe50bee05d">
			</p>
			<p>A young A. R. Rahman with Yesudas.</p>
			 <p>
				<img src="https://scontent-hkg3-1.xx.fbcdn.net/hphotos-xpt1/v/t1.0-9/12038404_10207688895360160_4466796252214153947_n.jpg?oh=5fb9c4ce496e7ebb5a7b83de7f55b319&oe=57135859">
			</p>
			
			<p>Hope you like these and 200+ more.</p>
			</a>
			
			<p>Thanks</p>
			
			<p><br></p>
			<cfoutput><p style="font-size:small;"><a href="http://quirkycrackers.com/quirkycrackers/indian-history-in-pictures/?utm_source=email&utm_medium=email_r&utm_campaign=indiahistory&email_id=#email_id#&active=0">Unsubscribe</p></cfoutput>
	
		</body>
	</html>
	
	</cfmail>
	<cfcatch>
		

	</cfcatch>
	</cftry>
	<cftry>
		<cfquery name="getall" datasource="product">
			update email_random set sent=sent+1, sent_date = now()
			where 
			email_id =  '#email_id#'
			and campagin='indiahistory'
		</cfquery>
	<cfcatch>
	</cfcatch>
	</cftry>
	<cfoutput>#email_id#,</cfoutput>
	<cfflush> 
	<cfset snooz(2000)>
</cfloop>