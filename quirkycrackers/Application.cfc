<cfcomponent
	displayname="Application"
	output="true"
	hint="Handle the application.">


	<!--- Set up the application. --->
	<cfset THIS.Name = "FTB" />
	<cfset THIS.ApplicationTimeout = CreateTimeSpan(  0, 5, 1, 0 ) />
	<cfset THIS.SessionManagement = true />
	<cfset THIS.SetClientCookies = true />
	<cfset THIS.clientManagement = true />
	<cfset THIS.clientStorage = "product" />


	<!--- Define the page request properties. --->
	<!--- <cfsetting
		requesttimeout="20"
		showdebugoutput="false"
		enablecfoutputonly="false"
		/> --->


	<cffunction
		name="OnApplicationStart"
		access="public"
		returntype="boolean"
		output="false"
		hint="Fires when the application is first created.">
		<cfset application.dsn = 'product'>
		<cfset application.goog = 'UA-54318348-1'>
		<!--- Return out. --->
		<cfreturn true />
	</cffunction>

	<cffunction
		name="OnRequestStart"
		access="public"
		returntype="boolean"
		output="false"
		hint="Fires at first part of page processing.">

		<!--- Define arguments. --->
		<cfargument
			name="TargetPage"
			type="string"
			required="true"
			/>
		<cfset application.goog = 'UA-54318348-1'>
		<cfset application.cgi_SCRIPT_NAME = replace(cgi.SCRIPT_NAME,"index.cfm","")>
		<cfparam name="session.fluctuate" default="0">
		<cfparam name="session.prangeFrom" default="">
		<cfparam name="session.prangeTo" default="">
		<cfparam name="session.rangeTo" default="25000">
		<cfparam name="session.rangeFrom" default="0">
		<cfparam name="session.dropsince" default="1">
		<cfparam name="session.saveme" default="">
		<cfparam name="session.usermsg" default="">
		<cfparam name="client.mobile" default="0">
		<cfparam name="session.force" default="0">
		<cfparam name="request.files" default="main">
		<cfparam name="session.showsub" default="1">
		<cfset application.siteroot = 'quirkycrackers/'>
		<cfset request.path = listtoArray(replace(replace(cgi.SCRIPT_NAME,'index.cfm',''),'#application.siteroot#',''),'/')>

		<cfif client.mobile>
			<cfset request.files = "m">
		</cfif>
		<cfif isdefined("client.user_sk") and len(client.user_sk)>
			<cfset session.showsub = "0">
		</cfif>
		<cfset obj = createObject("component","cmp")>
		<cfset products = createObject("component","products")>
		
		<!--- Return out. --->
		<cfreturn true />
	</cffunction>
	
	<cffunction
		name="OnApplicationEnd"
		access="public"
		returntype="void"
		output="false"
		hint="Fires when the application is terminated.">

		<!--- Define arguments. --->
		<cfargument
			name="ApplicationScope"
			type="struct"
			required="false"
			default="#StructNew()#"
			/>
			
			<cfquery name="runjob" datasource="#application.dsn#">
				update `ftb_jobtracker` set status='APP_CRASH'
				where status = 'RUNNING'
			</cfquery>

		<!--- Return out. --->
		<cfreturn />
	</cffunction>
	
	<cffunction
		name="OnRequest"
		access="public"
		returntype="void"
		output="true"
		hint="Fires after pre page processing is complete.">

		<!--- Define arguments. --->
		<cfargument
			name="TargetPage"
			type="string"
			required="true"
			/>
			
			<!--- <cfhtmlhead  action="read" variable="v">
			<cfdump var="#v#"><cfabort>

			<cfoutput>
			<cfset scripts = '<link rel="stylesheet" href="/quirkycrackers/js/#request.files#.css">'>
			<cfset scripts = scripts & '<script language="javascript" src="/quirkycrackers/js/cssua.min.js"></script>'>
			<cfset scripts = scripts & '<link rel="shortcut icon" href="/quirkycrackers/images/favicon.ico">'>
			<cfset scripts = scripts & '<script type="text/javascript" src="/quirkycrackers/js/jquery-1.11.1.min.js"></script>'>
			<cfset scripts = scripts & '<script language="javascript" src="/quirkycrackers/js/isotope.pkgd.min.js"></script>'>
			<cfset scripts = scripts & '<script language="javascript" src="/quirkycrackers/js/#request.files#.js"></script>'>
			<cfset scripts = scripts & '<script language="javascript" src="/quirkycrackers/js/jquery.resizecrop-1.0.3.min.js"></script>'>
			<cfset scripts = scripts & '<script language="javascript" src="/quirkycrackers/js/utils.js"></script>'>
			<cfset scripts = scripts & '<script language="javascript" src="/quirkycrackers/js/common.js"></script>'>
			<cfset scripts = scripts & '<script type="text/javascript" src="/quirkycrackers/js/canvasjs-1.7.0/jquery.canvasjs.min.js"></script>'>
			<cfset scripts = scripts & '<link rel="stylesheet"  href="/quirkycrackers/js/ion.rangeSlider-1.9.3/css/normalize.min.css"></link>'>
			<cfset scripts = scripts & '<link rel="stylesheet"  href="/quirkycrackers/js/ion.rangeSlider-1.9.3/css/ion.rangeSlider.css"></link>'>
			<cfset scripts = scripts & '<link rel="stylesheet"  href="/quirkycrackers/js/ion.rangeSlider-1.9.3/css/ion.rangeSlider.skinFlat.css"></link>'>
			<cfset scripts = scripts & '<script src="/quirkycrackers/js/ion.rangeSlider-1.9.3/js/ion-rangeSlider/ion.rangeSlider.min.js"></script>'>
			
			
			<cfset scripts = scripts & '#chr(13)##chr(10)#'>
		</cfoutput>
		<cfhtmlhead  
   			 text='#scripts#'> --->
	
		<cfset var pidpage = ''>
		<cfif findNoCase('index.cfm',ARGUMENTS.TargetPage)>
			<cftry>
				<cfset pidpage = listlast(listlast(replace(ARGUMENTS.TargetPage,'index.cfm',''),'/'),'-')>
			<cfcatch>
			</cfcatch>
			</cftry>
		</cfif>
		<cfset lenpidpage = len(pidpage)>
		<cfif lenpidpage eq 10 or lenpidpage eq 13 or lenpidpage eq 16>
			<cfset url.pid = pidpage>
			<cfinclude template="/quirkycrackers/product_page.cfm">
		<cfelse>
			<cfinclude template="#ARGUMENTS.TargetPage#">
		</cfif>
		<!--- Return out. --->
		<cfreturn />
	</cffunction>
	
	<!--- <cffunction
		name="OnSessionStart"
		access="public"
		returntype="void"
		output="false"
		hint="Fires when the session is first created.">

		<!--- Return out. --->
		<cfreturn />
	</cffunction>


	<cffunction
		name="OnRequest"
		access="public"
		returntype="void"
		output="true"
		hint="Fires after pre page processing is complete.">

		<!--- Define arguments. --->
		<cfargument
			name="TargetPage"
			type="string"
			required="true"
			/>

		<!--- Include the requested page. --->
		<cfinclude template="#ARGUMENTS.TargetPage#" />

		<!--- Return out. --->
		<cfreturn />
	</cffunction>


	<cffunction
		name="OnRequestEnd"
		access="public"
		returntype="void"
		output="true"
		hint="Fires after the page processing is complete.">

		<!--- Return out. --->
		<cfreturn />
	</cffunction>


	<cffunction
		name="OnSessionEnd"
		access="public"
		returntype="void"
		output="false"
		hint="Fires when the session is terminated.">

		<!--- Define arguments. --->
		<cfargument
			name="SessionScope"
			type="struct"
			required="true"
			/>

		<cfargument
			name="ApplicationScope"
			type="struct"
			required="false"
			default="#StructNew()#"
			/>

		<!--- Return out. --->
		<cfreturn />
	</cffunction>


	<cffunction
		name="OnApplicationEnd"
		access="public"
		returntype="void"
		output="false"
		hint="Fires when the application is terminated.">

		<!--- Define arguments. --->
		<cfargument
			name="ApplicationScope"
			type="struct"
			required="false"
			default="#StructNew()#"
			/>

		<!--- Return out. --->
		<cfreturn />
	</cffunction>
	--->

	<!--- 
<cffunction
		name="OnError"
		access="public"
		returntype="void"
		output="true"
		hint="Fires when an exception occures that is not caught by a try/catch.">

		<!--- Define arguments. --->
		<cfargument
			name="Exception"
			type="any"
			required="true"
			/>

		<cfargument
			name="EventName"
			type="string"
			required="false"
			default=""
			/>
			<cfoutput>
			<html>
				<head>
					<link rel="stylesheet" href="/quirkycrackers/js/main.css">
					<script language="javascript" src="/quirkycrackers/js/jquery-1.11.1.min.js"></script>
					<script language="javascript" src="/quirkycrackers/js/jquery-ui.min.js"></script>
					<script language="javascript" src="/quirkycrackers/js/main.js"></script>
				</head>
				<body>
					<cfinclude template="header.cfm">
					<div style="text-align:center;width:100%">
						<img src="/quirkycrackers/images/error.jpg">
					</div>
					<div style="text-align:center;width:100%">
						<a href="/quirkycrackers/">Please visit Home</a>
					</div>
				</body>
			</html>
			<cftry>
				<cfmail from="hello@quirkycrackers.com" to="tushars2001@gmail.com" type="html" failto="tushars2001@gmail.com" subject="Error Page">
					<cfdump var="#arguments#">
				</cfmail>
			<cfcatch>
				<div style="text-align:center;width:100%">
					Mail wasn't sent
				</div>
			</cfcatch>
			</cftry>
			</cfoutput>
		<!--- Return out. --->
		<cfreturn />
	</cffunction> 
 --->

</cfcomponent>
