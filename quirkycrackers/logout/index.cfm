<cfset structclear(session)>
<cfset email = ''>
<cfif isdefined("client.email")>
	<cfset email = client.email>
</cfif>
<cfset structclear(client)>
<cfif len(email)>
	<cfset client.email = email>
</cfif>

<cflocation addtoken="false" url="/quirkycrackers/">