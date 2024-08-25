<cfparam name="form.updatepassword" default="0">
<cfquery name="getUser" datasource="#application.dsn#">
	select user_sk,passhash,email,first_name,last_name from users_main
	where upper(email) = upper('#form.email#')
</cfquery>
<cfparam name="url.redirect" default="/quirkycrackers/">
<cfif not len(url.redirect)>
	<cfset url.redirect = "/quirkycrackers/login/">
</cfif>
<cfset user_sk = createuUID()>
<cfset newuser = 0>
<cfset active = 0>
<cfset msg = ''>

<cfif getUser.recordcount>
	<cfif getUser.passhash neq hash(form.password)>
		<cfif form.updatepassword>
			<cfquery name="q_updatepassword" datasource="#application.dsn#">
				update `users_main` set password = '#form.password#', passhash = '#hash(form.password)#'
				where user_sk = '#getUser.user_sk#'
			</cfquery>
			<cfset newuser = 0>
			<cfset client.user_sk = getUser.user_sk>
			<cfset client.email = form.email>
			<cfset client.first_name = getUser.first_name>
			<cfmail from="hello@quirkycrackers.com" to="#form.email#" type="html" failto="tushars2001@gmail.com" subject="Welcome to QuirkyCrackers.com!">
				<cfoutput>
					<html>
						<head>
						</head>
						<body>
						
						</body>
					</html>
				<div>Dear <cfif len(getUser.first_name)>#getUser.first_name#<cfelse>User</cfif>,</div>
				<br><br>
				<div>Thanks for Registering at QuirkyCrackers.com.</div>
				<br><br>
				<div>We'll make sure you are always updated with Quirky Products around web/online apps and try to provide you more personalized experience.</div>
				<br><br>
				<div>Best Regards,</div>
				<div>QuirkyCrackers</div>
				</cfoutput>
			</cfmail>
			<cfset url.redirect = "/quirkycrackers/">
		<cfelse>
			<cfset msg = 'Your email/password combination is not correct.'>
			<cfset url.redirect = "/quirkycrackers/login/">
		</cfif>
		
	<cfelse>
		<cfset client.user_sk = getUser.user_sk>
		<cfset client.email = getUser.email>
		<cfset client.first_name = getUser.first_name>
	</cfif>
<cfelse>
	<cfset createObject("component","quirkycrackers.users.users").register(form.email,form.password,hash(form.password))>
	<cfset newuser = 1>
	<cfset client.user_sk = user_sk>
	<cfset client.email = form.email>
	<!--- <cfmail from="hello@quirkycrackers.com" to="#form.email#" type="html" failto="tushars2001@gmail.com" subject="Welcome to FindTrackBuy.com!">
		<cfoutput>
			<html>
				<head>
				</head>
				<body>
				
				</body>
			</html>
		<div>Dear User,</div>
		<br><br>
		<div>Thanks for Registering at FindTrackBuy.com.</div>
		<div>Please activate your account to see your dashboard.</div>
		<br><br>
		<div><a href="http://#cgi.SERVER_NAME#:#cgi.SERVER_PORT#/quirkycrackers/acticate/?user_sk=#user_sk#">Activate</a></div>
		<div>or copy paste below link:</div>
		<div>http://#cgi.SERVER_NAME#:#cgi.SERVER_PORT#/quirkycrackers/acticate/?user_sk=#user_sk#</div>
		<br><br>
		<div>You can track and control Alerts and Price Drops from Dashboard.</div>
		<br><br>
		<div>Best Regards,</div>
		<div>FindTrackBuy Team</div>
		</cfoutput>
	</cfmail> --->
	<cfmail from="hello@quirkycrackers.com" to="#form.email#" type="html" failto="tushars2001@gmail.com" subject="Welcome to FindTrackBuy.com!">
		<cfoutput>
			<html>
				<head>
				</head>
				<body>
				
				</body>
			</html>
		<div>Dear User,</div>
		<br><br>
		<div>Thanks for Registering at FindTrackBuy.com.</div>
		<br><br>
		<div>You can track and control Alerts and Price Drops from Dashboard.</div>
		<br><br>
		<div>Best Regards,</div>
		<div>FindTrackBuy Team</div>
		</cfoutput>
	</cfmail>
	<cfset msg = 'Your ID is not in our system.<br>We created your account and sent email at #form.email#.'>
</cfif>
<cflocation addtoken="false" url="#url.redirect#?msg=#msg#">

