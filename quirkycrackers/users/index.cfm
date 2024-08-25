<cfset users = createObject("component","users")>
<cfif isdefined("url.subscribe") and len(url.subscribe)>
	
	<cfset users.subscribe(url.subscribe)>

</cfif>
<cfif isdefined("form.register") and len(form.register)>
	
	<cfset  v.password = form.password>
	<cfset  v.fb_id = form.fb_id>
	<cfset  v.fb_resObj = form.fb_resObj>
	<cfset  v.passhash = hash(v.password)>
	<cfset  v.resp = structNew()>
	<cfset  v.couponCode = form.couponCode>
	<cfset v.resp.exists = false>
	<cfset v.resp.msg = ''>
	<cfset v.resp.register = false>
	<cfset v.email = ''>
	<cfset request.res.exists = false>
	<cfset request.res.passhash = ''>
	<cfset request.res.user_sk = ''>
	<cfset request.res.first_name = ''>
	<cfif len(v.fb_id)>
		<cfset fbReg = users.registerFB(v)>
	<cfelse>
		<cftry>
			<cfset v.resp.exists = users.checkUser(v.email)>
			
			<cfif len(v.resp.exists)>
				<cfset v.resp.logUser = users.logUser(v.email,v.password,v.passhash)>
				<cfif v.resp.logUser>
					<cfset v.resp.msg = "#v.resp.msg#You are logged in!">
				<cfelse>
					<cfset v.resp.msg = "Email/password combination is not correct.">
				</cfif>
			<cfelse>
				<cfset v.resp.msg = "Thank you!">
				<cfset v.resp.register =  users.register(v.email,v.password,v.passhash)>
				<cfset v.resp.logUser = users.logUser(user_sk=v.resp.register)>
				<cfif v.resp.logUser>
					<cfset v.resp.msg = "#v.resp.msg#You are logged in!">
				<cfelse>
					<cfset v.resp.msg = "#v.resp.msg#There was trouble logging you in. We regret this issue and trying to resolve ASAP!">
					<!--- <cfset logError(activity = "login",data = serializeJSON(v),sendmail="yes",sendmailUser="yes")> --->
				</cfif>
			</cfif>
			<cfcatch type="any">
				<cfdump var="#cfcatch#"><cfabort>
			</cfcatch>
		</cftry>
	</cfif>

	<cfcontent reset="true" variable="#toBinary(tobase64(serializeJSON(request.res)))#">

</cfif>