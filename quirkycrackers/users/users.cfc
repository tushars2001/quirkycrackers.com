<cfcomponent output="true">

	<cffunction name="register"  output="false" returntype="string">
		<cfargument name="email" required="true" type="string">
		<cfargument name="password" required="true" type="string">
		<cfargument name="passhash" required="true" type="string">
		<cfargument name="news_letter" required="false" type="string" default="1">
		<cfargument name="fb_id" required="false" type="string" default="">
		<cfargument name="fb_resObj" required="false" type="string" default="">
		
		<cfset var ret = 1>
		<cfset var uuid = createuUID()>
		<cfset var first_name = ''>
		<cfset var last_name = ''>
		<cfif len(arguments.fb_resObj)>
			<cftry>
				<cfset jObj = deserializeJSON(arguments.fb_resObj)>
				<cfif structkeyExists(jObj,"email")>
					<cfset arguments.email = jObj.email>
				</cfif>
				<cfset first_name = jObj.first_name>
				<cfset last_name = jObj.last_name>
			<cfcatch>
				<cfdump var="#cfcatch#"><cfdump var="#arguments#"><cfabort>
			</cfcatch>
			</cftry>
		</cfif>

		<cfquery name="setEmail" datasource="#application.dsn#">
			INSERT INTO users_main
			(
			user_sk,
			email,
			password,
			passhash,
			news_letter,
			fb_id,
			fb_me,
			first_name,
			last_name
			)
			VALUES
			(
				'#uuid#',
				'#arguments.email#',
				'#arguments.password#',
				'#arguments.passhash#',
				#news_letter#,
				'#arguments.fb_id#',
				'#arguments.fb_resObj#',
				'#first_name#',
				'#last_name#'
			)

		</cfquery>
		
		<!--- <cfmail type="html" to="#arguments.email#" failto="tnhpindia@gmail.com" from="tnhpindia@gmail.com" subject="Welcome to 'TumseNaHoPayega'">
			<h2>TNHPIndia Welcome You!</h2>
			Dear User, <br><br>
			Please verify your Email: <a href="http://www.quirkycrackers.com/misc/email/key/#uuid#">Click Here</a><br><br>
			Or copy-paste in your browser:<br>
			http://www.quirkycrackers.com/misc/email/key/#uuid#<br><br>
			
			You will be getting Weekly Mail for New Products and updates.<br><br><br>
			Your initial password is : welcome<br><br>
			You can change password by Logging in to <a href="http://www.quirkycrackers.com/">www.quirkycrackers.com</a> <br><br><br>
			
			Regards,<br><br>
			Team TNHPIndia
			
		</cfmail> --->
		
		<cfreturn uuid/>
		
	</cffunction>

	<cffunction name="checkUser" returntype="string">
		<cfargument name="email" required="true">
		<cfset var ret = ''>
		
		<cfquery name="q_checkUser" datasource="#application.dsn#">
			select email,user_sk,fb_id from users_main where UPPER(email) = UPPER('#arguments.email#')
		</cfquery>
		
		<cfif q_checkUser.recordcount>
			<cfset ret = q_checkUser.user_sk>
		</cfif>
		
		<cfreturn ret/>
		
	</cffunction>
	
	<cffunction name="getUserName" returntype="struct">
		<cfargument name="key" required="true">
		<cfset var ret = structnew()>
		
		<cfquery name="q_getUserName" datasource="#application.dsn#">
			select first_name, last_name from users_main 
			where UPPER(email) = UPPER('#arguments.key#')
			or user_sk = '#arguments.key#'
		</cfquery>
		
		<cfset ret.first_name = q_getUserName.first_name>
		<cfset ret.last_name = q_getUserName.last_name>
		
		<cfreturn ret/>
		
	</cffunction>
	
	<cffunction name="getEmail" returntype="string">
		<cfargument name="key" required="true">
		<cfset var ret = structnew()>
		
		<cfquery name="q_getEmail" datasource="#application.dsn#">
			select email from users_main 
			where UPPER(email) = UPPER('#arguments.key#')
			or user_sk = '#arguments.key#'
		</cfquery>
		
		<cfreturn q_getEmail.email/>
		
	</cffunction>
	
	<cffunction name="checkUserbyFBId" returntype="string">
		<cfargument name="fb_id" required="true">
		<cfset var ret = ''>
		
		<cfquery name="q_checkUser" datasource="#application.dsn#">
			select email,user_sk,fb_id from users_main where UPPER(fb_id) = UPPER('#arguments.fb_id#')
		</cfquery>
		
		<cfif q_checkUser.recordcount>
			<cfset ret = q_checkUser.user_sk>
		</cfif>
		
		<cfreturn ret/>
		
	</cffunction>
	
	<cffunction name="logUser" returntype="boolean">
		<cfargument name="email" required="false" type="string" default="">
		<cfargument name="password" required="false" type="string" default="">
		<cfargument name="passhash" required="false" type="string" default="">
		<cfargument name="user_sk" required="false" type="string" default="">
		
		<cfset var ret = false>
		
		<cfquery name="q_checkUser" datasource="#application.dsn#">
			select user_sk from users_main 
			where 
			<cfif len(arguments.user_sk)>
				user_sk = '#arguments.user_sk#'
			<cfelse>
				email = '#arguments.email#'
				and passhash = '#arguments.passhash#'
			</cfif>			
			
		</cfquery>
		
		<cfif q_checkUser.recordcount>
			<cfset client.login = 1>
			<cfset client.user_sk = q_checkUser.user_sk>
			<cfset userdetails = getUserDetails(client.user_sk)>
			<cfset client.user_detail = userdetails>
			<cfset client.first_name = userdetails.first_name>
			<cfset request.res.exists = true>
			<cfset request.res.passhash = userdetails.passhash>
			<cfset request.res.user_sk = client.user_sk>
			<cfset request.res.first_name = userdetails.first_name>
			<cfset ret = true>
		<cfelse>
			<cfset  ret = false>
		</cfif>
		
		<cfreturn ret/>
		
	</cffunction>
	
	<cffunction name="getUserDetails" returntype="query">
		<cfargument name="user_sk" required="true" type="string">
		<cfset var userData = querynew('')>
		
		<cfquery name="userData" datasource="#application.dsn#">
			SELECT
				um.first_name,
				um.last_name,
				um.sex,
				um.email,
				um.news_letter,
				um.dob,
				um.user_sk,
				um.passhash
			from users_main um
			where user_sk = '#arguments.user_sk#'
		</cfquery>
		
		<cfreturn userData/>
	
	</cffunction>
	
	<cffunction name="fav" returntype="boolean">
		<cfargument name="id" required="true" type="string">
		<cfargument name="user_sk" required="true" type="string">
		<cfset var ret = true>
		
		<cfset var fav = getFav(arguments.user_sk)>
		<cfif not listfind(fav,id)>
			<cfset fav = listAppend(fav,id)>
		</cfif>
		
		<cfquery name="setfav" datasource="#application.dsn#">
			update users_main set fav_fav = '#fav#'
			where user_sk = '#arguments.user_sk#'
		</cfquery>
		
		<cfreturn ret/>
	
	</cffunction>
	
	<cffunction name="getFav" returntype="string">
		<cfargument name="user_sk" required="true" type="string">
		<cfset var q_getFav = queryNew('')>
		<cfset var fav = ''>
		
		<cfquery name="q_getFav" datasource="#application.dsn#">
			select fav_fav from users_main 
			where user_sk = '#arguments.user_sk#'
		</cfquery>
		
		<cfif q_getFav.recordcount>
			<cfset fav = q_getFav.fav_fav>
		</cfif>
		
		<cfreturn fav/>
	
	</cffunction>
	
	<cffunction name="userUpdate" returntype="boolean">
		<cfargument name="fields" required="true" type="struct">
		<cfset var ret = true>
		
		<cfset var user_sk = arguments.fields.user_sk>
		
		
		<cfquery name="q_userUpdate" datasource="#application.dsn#">
			update users_main set 
			first_name = '#arguments.fields.first_name#',
			last_name = '#arguments.fields.last_name#',
			news_letter = #arguments.fields.news_letter#
			where user_sk = '#user_sk#'
		</cfquery>
		
		<cfset logUser('','','',user_sk)>
		
		<cfreturn ret/>
	
	</cffunction>

	<cffunction name="sendPasswordMail" returntype="boolean">
		<cfargument name="email" required="true">
		<cfset var ret = true>

		<cfquery name="q_checkUser" datasource="#application.dsn#">
			select email,password,user_sk from users_main where UPPER(email) = UPPER('#arguments.email#')
		</cfquery>

		<cfif q_checkUser.recordcount>
			<cftry>
			
						<cfset sendMail(q_checkUser.email,"TNHPIndia - Password Reset","<a href='http://localhost/user/reset/password/#q_checkUser.user_sk#/'>Click here to reset you password</a>")>
						
			<cfcatch>
				<cfdump var="#cfcatch#"><cfabort>

			</cfcatch>
			</cftry>
			<cfset ret = true>
		</cfif>
		
		<cfreturn ret/>
		
	</cffunction>
	
	<cffunction name="sendMail">
		<cfargument name="to" required="true">
		<cfargument name="subject" required="true">
		<cfargument name="message" required="true">
		
		<cf_mailTemplate user="User" msg="#arguments.message#"/>
						
		<cfmail to="#arguments.to#" type="html" from="#application.mailer#" failto="#application.failto#" subject="#arguments.subject#">
			#request.mailTemplate#
		</cfmail>
						
	</cffunction>

	<cffunction name="logActivity" returntype="boolean">
	<cfargument name="user_sk" required="true" type="string">
	<cfargument name="share_f_t_q" required="true" type="string">
	<cfset var ret = true>
	
	
	<cfquery name="q_userUpdate" datasource="#application.dsn#">
		INSERT INTO `user_activity`
		(
		`user_sk`,
		`share_f_t_q`
		)
		VALUES
		(
		'#arguments.user_sk#',
		#arguments.share_f_t_q#
		);
	</cfquery>
	
	
	<cfreturn ret/>

</cffunction>

	<cffunction name="updatePassword">
		<cfargument name="password" required="true">
		<cfargument name="user_sk" required="true">
		
		<cfquery name="setpwd" datasource="#application.dsn#">
			update users_main set password='#arguments.password#', passhash='#hash(arguments.password)#' 
			where user_sk = '#arguments.user_sk#'
		</cfquery>
						
	</cffunction>

	<cffunction name="subscribe" returntype="void">
		<cfargument name="email" required="true">
		
		<cfif not len(checkUser(arguments.email))>
			<cfset register(arguments.email,'subscribe','',1)>		
		</cfif>
		
	</cffunction>
	
	<cffunction name="checkFbId">
		<cfargument name="userid" required="true">
		
		<cfset var ret = ''>
		
		<cfquery name="q_checkUser" datasource="#application.dsn#">
			select user_sk from users_main where  fb_me LIKE  '%#arguments.userid#%'
		</cfquery>
		
		<cfif q_checkUser.recordcount>
			<cfset ret = q_checkUser.user_sk>
		</cfif>
		
		<cfreturn ret/>
		
	</cffunction>
	
	<cffunction name="registerFB"  output="true">
		<cfargument name="attrs" required="true" type="struct">
		<cfset var fbresp_cf = deserializeJSON(attrs.fb_resObj)>
		<cfif isdefined("fbresp_cf.email") and len(fbresp_cf.email)>
			<cfset attrs.email = fbresp_cf.email>
		</cfif>
		<cfif len(attrs.email)>
		
			<cfset attrs.resp.exists = checkUser(attrs.email)>
			<cfif len(attrs.resp.exists)> <!-----with us ----->
					<cfset logu = logUser(user_sk=attrs.resp.exists)>
					<cfset attrs.resp.msg = "#attrs.resp.msg#You are logged in!">
			<cfelse> <!-----not with us ----->
				<cfif not len(attrs.email)>
					<cfset attrs.email = "#attrs.fb_id#@fblogin.com">
				</cfif>
				<cfset attrs.resp.register =  register(attrs.email,attrs.password,attrs.passhash,1,attrs.fb_id,attrs.fb_resObj)>
				<cfset attrs.resp.logUser = logUser(user_sk=attrs.resp.register)>
				<cfif attrs.resp.logUser>
					<cfset attrs.resp.msg = "#attrs.resp.msg#You are logged in!">
				<cfelse>
					<cfset attrs.resp.msg = "#attrs.resp.msg#There was trouble logging you in. We regret this issue and trying to resolve ASAP!">
				</cfif>
			</cfif>
			
		<cfelseif len(attrs.fb_id)> <!-----email nhi aaya but id aayi----->
		
			<cfset attrs.resp.exists = checkUserbyFBId(attrs.fb_id)>
			<cfif len(attrs.resp.exists)> <!-----with us ----->
					<cfset logu = logUser(user_sk=attrs.resp.exists)>
			<cfelse> <!-----not with us ----->
				<cfset attrs.email = "#attrs.fb_id#@fblogin.com">
				<cfset attrs.resp.register =  register(attrs.email,attrs.password,attrs.passhash,1,attrs.fb_id,attrs.fb_resObj)>
				<cfset attrs.resp.logUser = logUser(user_sk=attrs.resp.register)>
				<cfif attrs.resp.logUser>
					<cfset attrs.resp.msg = "#attrs.resp.msg#You are logged in!">
				<cfelse>
					<cfset attrs.resp.msg = "#attrs.resp.msg#There was trouble logging you in. We regret this issue and trying to resolve ASAP!">
				</cfif>
			</cfif>
			
		<cfelse> <!-----email nhi aaya----->
		
			<cfset attrs.resp.register =  register(attrs.email,attrs.password,attrs.passhash,1,attrs.fb_id,attrs.fb_resObj)>
			<cfset attrs.resp.logUser = logUser(user_sk=attrs.resp.register)>
			<cfif attrs.resp.logUser>
				<cfset attrs.resp.msg = "#attrs.resp.msg#You are logged in!">
			<cfelse>
				<cfset attrs.resp.msg = "#attrs.resp.msg#There was trouble logging you in. We regret this issue and trying to resolve ASAP!">
				<!--- <cfset logError(activity = "login",data = serializeJSON(v),sendmail="yes",sendmailUser="yes")> --->
			</cfif>
		
		</cfif>
		<cfreturn attrs.resp>
		<!--- <cfif attrs.couponCode>
			<cfset couponsObj = createObject("component","model.services.coupons")>
			<cfset couponsObj.claimCoupon(attrs.resp.register,attrs.couponCode)>
			<cfset email = createObject("component","model.services.users").getEmail(attrs.resp.register)>
			<cfset couponsObj.sendMail(email,attrs.couponCode)>
		</cfif> --->
		<!--- <cfcontent reset="true" variable="#toBinary(tobase64(serializeJSON(attrs.resp)))#"> --->
				
	</cffunction>
</cfcomponent>