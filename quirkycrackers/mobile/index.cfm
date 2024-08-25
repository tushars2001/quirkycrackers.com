<cfparam name="url.m" default="1">
<cfparam name="url.force" default="0">
<cfset session.force = url.force>
<cfset client.mobile = url.m>

<cfif len(cgi.http_referer)>
	<cflocation url="/quirkycrackers/?#cgi.QUERY_STRING#" addtoken="false">
<cfelse>
	<cflocation url="/" addtoken="false">
</cfif>