<cfquery name="getall" datasource="product">
	select email_id, campagin from email_campaign
	where sent = 0 and length(email_id) > 0
	and campagin='indiahistory'
</cfquery>

<cffunction name="snooz" access="public" output="false" returntype="void" hint="Leverages Java's sleep() function">
   <cfargument name="timeToSleep" type="numeric" required="true" />

   <cfscript>
      createObject("java", "java.lang.Thread").sleep(arguments.timeToSleep);    //sleep time in milliseconds
      return;
   </cfscript>
</cffunction>

<cfloop from="1" to="#getall.recordcount#" index="idx">
	<cftry>
	
	<cfmail to="#getall.email_id[idx]#" from="hello@quirkycrackers.com" subject="Indian History in Pictures" type="html">
	<html>
		<head></head>
		<body>
			<p>Hey,</p>
	
			<p>I found these 200+ RAREST of rare indian historical pictures and thought it's worth share with you. 
			<br><span style="background-color:yellow;font-weight:bold">Hope you'd like it and if so, why not fwd this to ur frnz n family!
			</span>
			</p>
			<cfoutput>
			<a href="http://quirkycrackers.com/quirkycrackers/indian-history-in-pictures/?utm_source=email&utm_medium=email&utm_campaign=indiahistory&email_id=#getall.email_id[idx]#" style="text-decoration:none;font-weight:bold;color:black;text-decoration: underline;">
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
	
		</body>
	</html>
	</cfmail>
	<cfcatch>
		EMAIL ISSUE..
		<cfdump var="#cfcatch#">
		<cfabort>

	</cfcatch>
	</cftry>
	<cftry>
		<cfquery name="getall" datasource="product">
			update email_campaign set sent=sent+1, sent_date = now()
			where 
			email_id =  '#getall.email_id[idx]#'
			and campagin='indiahistory'
		</cfquery>
	<cfcatch>
		update ISSUE<cfdump var="#cfcatch#">
	</cfcatch>
	</cftry>
	<cfoutput>#getall.email_id[idx]#<br></cfoutput>
	<cfflush>
	<cfset snooz(10000)>
</cfloop>