                                <cfcomponent output="true">

	<cffunction name="getMainProducts"  output="false" returntype="query">
		<cfargument name="from" default="0" required="false">
		<cfargument name="howmany" default="17" required="false">
		
		<cfset var data = querynew('')>
		
		<cfquery name="data" datasource="#application.dsn#">
			select * from (
				select 
				pm.`idproduct_main`,
				pm.`title`,
				pm.`short_desc`,
				pm.`img_source`,
				CONCAT(pm.link,coalesce(si.affiliateParam, '')) as link, 			
				pm.`is_afflate`,
				pm.`source`,
				pm.`last_price`,
				pm.`category`,
				pm.`show`,
				pm.`date_created`,
				pm.`source_id`,
					pm.`quirkiness`,
	        (select GROUP_CONCAT(name)  from category where id in (select categoryid from product_category where idproduct_main = pm.`idproduct_main` and active=1 ))
	        as cats
			,REPLACE( pm.`title`,  ' ',  '-' ) as id_seo
				from product_main pm left join prod_sources si
				on pm.source_id = si.idprod_sources 
				 where 
				`show`=1
				order by 
					quirkiness desc,
				date_approved
				<!--- <cfif not arguments.all>
					LIMIT #arguments.from#,#arguments.howmany#
				</cfif> --->
			) tbl
			LIMIT #arguments.from#,#arguments.howmany# 
		</cfquery>

		<cfreturn data/>
		
	</cffunction>
	
	<cffunction name="getFeaturedProduct"  output="false" returntype="query">
		<cfargument name="pid" default="" required="true">
		
		<cfset var data = querynew('')>
		
		<cfquery name="data" datasource="#application.dsn#">
			select * from (
				select 
				pm.`idproduct_main`,
				pm.`title`,
				pm.`short_desc`,
				pm.`img_source`,
				CONCAT(pm.link,coalesce(si.affiliateParam, '')) as link, 			
				pm.`is_afflate`,
				pm.`source`,
				pm.`last_price`,
				pm.`category`,
				pm.`show`,
				pm.`date_created`,
				pm.`source_id`,
					pm.`quirkiness`,
	        (select GROUP_CONCAT(name)  from category where id in (select categoryid from product_category where idproduct_main = pm.`idproduct_main` and active=1 ))
	        as cats
			,REPLACE( pm.`title`,  ' ',  '-' ) as id_seo
				from product_main pm left join prod_sources si
				on pm.source_id = si.idprod_sources 
				 where 
				`show`=1
				and pm.`idproduct_main` = #arguments.pid#
				order by 
					quirkiness desc,
				date_approved
				<!--- <cfif not arguments.all>
					LIMIT #arguments.from#,#arguments.howmany#
				</cfif> --->
			) tbl
			
		</cfquery>

		<cfreturn data/>
		
	</cffunction>
	
	<cffunction name="getProductsAR"  output="false" returntype="query">
		<cfargument name="AR" required="false" default="0">
		<cfset var data = querynew('')>

		<cfquery name="data" datasource="#application.dsn#">
			select 
			pm.`idproduct_main`,
			pm.`title`,
			pm.`short_desc`,
			pm.`img_source`,
			pm.link as link, 			
			pm.`is_afflate`,
			pm.`source`,
			pm.`last_price`,
			pm.`category`,
			pm.`show`,
			pm.`date_created`,
			pm.`source_id`,
				pm.`quirkiness`
			from product_main pm left join prod_sources si
			on pm.source_id = si.idprod_sources 
			 where 
			`show`=#arguments.AR#
			order by 
			idproduct_main
				desc
		</cfquery>

		<cfreturn data/>
		
	</cffunction>
	
	<cffunction name="getProductsAssign"  output="false" returntype="query">
		<cfargument name="AR" required="false" default="0">
		<cfset var data = querynew('')>

		<cfquery name="data" datasource="#application.dsn#">
			select 
   		pm.`idproduct_main`,
			pm.`title`,
			pm.`short_desc`,
			pm.`img_source`,
			CONCAT(pm.link,coalesce(si.affiliateParam, '')) as link, 			
			pm.`is_afflate`,
			pm.`source`,
			pm.`last_price`,
			pm.`category`,
			pm.`show`,
			pm.`date_created`,
			pm.`source_id`,
				pm.`quirkiness`
			from product_main pm left join prod_sources si
			on pm.source_id = si.idprod_sources
              left join (select distinct idproduct_main from product_category) pc
            on pc.idproduct_main = pm.idproduct_main
			 where 
			(`show`=1 or `show`=2) and pc.idproduct_main is null
			order by 
			idproduct_main
				desc
		</cfquery>

		<cfreturn data/>
		
	</cffunction>
		
	<cffunction name="getProductsEdits"  output="false" returntype="query">
		<cfargument name="AR" required="false" default="0">
		<cfset var data = querynew('')>

		<cfquery name="data" datasource="#application.dsn#">
			select 
			pm.`idproduct_main`,
			pm.`title`,
			pm.`short_desc`,
			pm.`img_source`,
			CONCAT(pm.link,coalesce(si.affiliateParam, '')) as link, 			
			pm.`is_afflate`,
			pm.`source`,
			pm.`last_price`,
			pm.`category`,
			pm.`show`,
			pm.`date_created`,
			pm.`source_id`,
			10 as	quirkiness,
			pm.`long_desc`
			from product_main_edit pm left join prod_sources si
			on pm.source_id = si.idprod_sources 
			 where 
			`show`=#arguments.AR# 
			<cfif arguments.AR eq 0> or `show`=1 </cfif>
			order by 
			idproduct_main
				desc
			limit 3
		</cfquery>

		<cfreturn data/>
		
	</cffunction>
	
	<cffunction name="process"  output="false" returntype="struct">
		
		<cfset var data = querynew('')>
		<cfset var p = structNew()>
		<cfset p.processed = arraynew(1)>
		<cfset p.failed = arraynew(1)>
		
		<cfquery name="data" datasource="#application.dsn#">
			SELECT img_source,idproduct_main FROM `product_main` where idproduct_main not in 
			(
				SELECT idproduct_main FROM `img_dload`
			)
		</cfquery>

		<cfloop query="data">
			<cftry>
				<cfset img = Reverse(data.img_source)>
				<cfset img = LEFT(img,find("/",img)-1)>
				<cfset img = Reverse(img)>
				<cfhttp url="#data.img_source#" 
						method="get"  
						useragent="Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.12) Gecko/20080201 Firefox/2.0.0.12" 
						getasbinary="yes" result="local.objGet">
				<cfset local.objImage = ImageNew(local.objGet.FileContent)>
			    <cfimage source="#local.objImage#" action="write"  destination="C:\inetpub\wwwroot\local\resources\images\products\#img#">
			    <cfimage source="#local.objImage#" action="write"  destination="C:\inetpub\wwwroot\local\resources\images\productsBACKUP\#img#">
			    <cfset arrayAppend(p.processed,"/resources/images/products/#img#,#data.img_source#,#data.idproduct_main#")>
		   
		    <cfcatch type="any">
			    <cftry>
				<cfhttp url="#data.img_source#" 
						method="get"  
						useragent="Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.12) Gecko/20080201 Firefox/2.0.0.12" 
						getasbinary="yes" result="local.objGet">
				<cfset local.objImage = ImageNew(local.objGet.FileContent)>
				<cfset ran = rand()>
				 <cfimage source="#local.objImage#" action="write"  destination="C:\inetpub\wwwroot\local\resources\images\products\#ran#_#img#">
			    <cfset arrayAppend(p.processed,"/resources/images/products/#ran#_#img#,#data.img_source#,#data.idproduct_main#")>
			     <cfcatch type="any"><cfdump var="#cfcatch#"></cfcatch></cftry>
			    <cfset arrayAppend(p.failed,"/resources/images/products/#img#,#data.img_source#,#data.idproduct_main#")>
			</cfcatch></cftry>
		    
		</cfloop>
		<cfdump var="#now()#">
		<cftry>
		<cfloop from="1" to="#arraylen(p.processed)#" index="idx">
			<cfquery name="data" datasource="#application.dsn#">
				update `product_main`
				set img_source = '#listtoarray(p.processed[idx])[1]#'
				where img_source = '#listtoarray(p.processed[idx])[2]#'
			</cfquery>
		</cfloop>
		
		<cfloop from="1" to="#arraylen(p.processed)#" index="idx">
			<cfquery name="data" datasource="#application.dsn#">
				insert into `img_dload`(idproduct_main,isDone)
				values('#listtoarray(p.processed[idx])[3]#',1)
			</cfquery>
		</cfloop>
		<cfcatch type="any">
			<cfdump var="SOME ERRPR<BR>">
		</cfcatch></cftry>
		
		<cfdump var="#p#"><cfabort>

		<cfreturn data/>
		
	</cffunction>

	<cffunction name="getProduct"  output="false" returntype="query">
		<cfargument name="pid" required="true">
		<cfargument name="showOnly" required="false" default="true">
		
		<cfset var data = querynew('')>
		
		<cfquery name="data" datasource="#application.dsn#">
			SELECT 
			pm.`idproduct_main`,
			pm.`title`,
			pm.`short_desc`,
			pm.`img_source`,
			CONCAT(pm.link,coalesce(si.affiliateParam, '')) as link, 			
			pm.`is_afflate`,
			pm.`source`,
			pm.`last_price`,
			pm.`category`,
			pm.`show`,
			pm.`date_created`,
			pm.`source_id`,
				pm.`quirkiness`
				,REPLACE( pm.`title`,  ' ',  '-' ) as id_seo
			 FROM `product_main` pm left join prod_sources si
			 on pm.source_id = si.idprod_sources 
			where (pm.idproduct_main = '#arguments.pid#' or REPLACE( pm.`title`,  ' ',  '-' ) = '#arguments.pid#')
			<cfif arguments.showOnly>
				and `show`=1
			</cfif>
		</cfquery>
		<!--- <cfdump var="#data#"><cfabort> --->

		<cfreturn data/>
		
	</cffunction>
	
	<cffunction name="getProductsByCat"  output="false" returntype="query">
		<cfargument name="catId" required="true">
		<cfargument name="fromPrice" required="false" default="0">
		<cfargument name="toPrice" required="false" default="0">
		<cfargument name="from" default="0" required="false">
		<cfargument name="howmany" default="17" required="false">
		
		<cfset var data = querynew('')>
		
		<cfquery name="data" datasource="#application.dsn#">
			select * from (
			select 
			pm.`idproduct_main`,
			pm.`title`,
			pm.`short_desc`,
			pm.`img_source`,
			CONCAT(pm.link,coalesce(si.affiliateParam, '')) as link, 			
			pm.`is_afflate`,
			pm.`source`,
			pm.`last_price`,
			pm.`category`,
			pm.`show`,
			pm.`date_created`,
			pm.`source_id`,
			pm.`quirkiness`,
            CategoryId
			,REPLACE( pm.`title`,  ' ',  '-' ) as id_seo
			from product_main pm left join prod_sources si 
			on pm.source_id = si.idprod_sources ,
            product_category pc  
			 where 
             pc.idproduct_main=pm.idproduct_main and
			`show`=1 and  CategoryId = #arguments.catId# and active=1
			<cfif not isdefined("request.vars.fromPID")>
				and 1=1
			<cfelse>
			</cfif>
			and pm.`last_price` > #arguments.fromPrice#
			<cfif len(arguments.toPrice) and arguments.toPrice neq 25000>
				and pm.`last_price` <= #arguments.toPrice#
			</cfif>
			
			) tbl
			order by idproduct_main desc
			LIMIT #arguments.from#,#arguments.howmany# 
			
		</cfquery>

		<cfreturn data/>
		
	</cffunction>
	
	<cffunction name="getProductsBySearch"  output="true" returntype="query">
		<cfargument name="search_string" required="true">
		<cfargument name="fromPrice" required="false" default="0">
		<cfargument name="toPrice" required="false" default="0">
		<cfargument name="from" default="0" required="false">
		<cfargument name="howmany" default="17" required="false">
		
		<cfset var data = querynew('')>
		
		<cfquery name="data" datasource="#application.dsn#">
			select * from (
			select 
			pm.`idproduct_main`,
			pm.`title`,
			pm.`short_desc`,
			pm.`img_source`,
			CONCAT(pm.link,coalesce(si.affiliateParam, '')) as link, 			
			pm.`is_afflate`,
			pm.`source`,
			pm.`last_price`,
			pm.`category`,
			pm.`show`,
			pm.`date_created`,
			pm.`source_id`,
			pm.`quirkiness`,
            '' as CategoryId
			,REPLACE( pm.`title`,  ' ',  '-' ) as id_seo
			from product_main pm left join prod_sources si 
			on pm.source_id = si.idprod_sources 
			 where 
			`show`=1 
			and pm.`last_price` > #arguments.fromPrice#
			<cfif arguments.toPrice and arguments.toPrice neq 8000>
				and pm.`last_price` <= #arguments.toPrice#
			</cfif>
			and (
				<cfloop list="#arguments.search_string#" index="e">
				   upper(pm.`title`) like upper('%#e#%') or
				   upper(pm.`short_desc`) like upper('%#e#%') or
				</cfloop>
				1=0
				
			)
			) tbl
			LIMIT #arguments.from#,#arguments.howmany# 
			
		</cfquery>

		<cfreturn data/>
		
	</cffunction>
	
	<cffunction name="getWhatsNew"  output="false" returntype="query">
		<cfargument name="fromPrice" required="false" default="0">
		<cfargument name="toPrice" required="false" default="0">
		<cfargument name="from" default="0" required="false">
		<cfargument name="howmany" default="9" required="false">
		
		<cfset var data = querynew('')>
		
		<cfquery name="data" datasource="#application.dsn#">
			select * from (
			select distinct
     
			pm.`idproduct_main`,
			pm.`title`,
			pm.`short_desc`,
			pm.`img_source`,
			CONCAT(pm.link,coalesce(si.affiliateParam, '')) as link, 			
			pm.`is_afflate`,
			pm.`source`,
			pm.`last_price`,
			pm.`category`,
			pm.`show`,
			pm.`date_created`,
			pm.`source_id`,
			10 as quirkiness
			,' ' as CategoryId
			,REPLACE( pm.`title`,  ' ',  '-' ) as id_seo
			from product_main pm left join prod_sources si 
			on pm.source_id = si.idprod_sources 
			 where 
            
			`show`=1  and (pm.date_created >  ADDDATE(CURDATE(),-28) or pm.date_approved >  ADDDATE(CURDATE(),-28))
			and pm.`last_price` > #arguments.fromPrice#
			<cfif arguments.toPrice and arguments.toPrice neq 8000>
				and pm.`last_price` <= #arguments.toPrice#
			</cfif>
			order by pm.date_approved desc
			) tbl
			<!--- LIMIT #arguments.from#,#arguments.howmany#  --->
		</cfquery>

		<cfreturn data/>
		
	</cffunction>

	<cffunction name="getWhatsHot"  output="false" returntype="query">
		
		<cfset var data = querynew('')>
		
		<cfquery name="data" datasource="#application.dsn#">
			select distinct
     
			pm.`idproduct_main`,
			pm.`title`,
			pm.`short_desc`,
			pm.`img_source`,
			CONCAT(pm.link,coalesce(si.affiliateParam, '')) as link, 			
			pm.`is_afflate`,
			pm.`source`,
			pm.`last_price`,
			pm.`category`,
			pm.`show`,
			pm.`date_created`,
			pm.`source_id`,
			10 as quirkiness
			,' ' as CategoryId
			,REPLACE( pm.`title`,  ' ',  '-' ) as id_seo
			from product_main pm left join prod_sources si 
			on pm.source_id = si.idprod_sources 
			inner join (
			
			select idproduct_main, hitcount, isslider, quirkiness, round(orderby/isslider) as order_by from (
			select tbl.idproduct_main, tbl.hitcount, case when sld.prod_id is null then 1 else 2 end as isslider, pm.quirkiness,
			case 
				when pm.quirkiness < 7 then (pm.quirkiness+100)*tbl.hitcount
				when pm.quirkiness >= 7 and pm.quirkiness <15 then (pm.quirkiness+85)*tbl.hitcount
				when pm.quirkiness >= 15 and pm.quirkiness <40 then (pm.quirkiness+60)*tbl.hitcount
				when pm.quirkiness >= 40 and pm.quirkiness <80 then (pm.quirkiness+25)*tbl.hitcount
			    when pm.quirkiness >= 80 and pm.quirkiness <100 then (pm.quirkiness+5)*tbl.hitcount
				else (pm.quirkiness-40)*tbl.hitcount end as orderby
			from (
			SELECT idproduct_main, count(idproduct_main) as hitcount FROM `quirkycr_dev`.`Product_clicks` group by idproduct_main having count(idproduct_main) > 1 
			    ) tbl left join `quirkycr_dev`.`slider` sld 
			on sld.prod_id = tbl.idproduct_main
			left join `quirkycr_dev`.`product_main` pm
			on pm.idproduct_main = tbl.idproduct_main
			) main

			
			) lj on lj.idproduct_main = pm.idproduct_main
			 where 
            
			`show`=1 
			
			order by lj.order_by asc
			
		</cfquery>

		<cfreturn data/>
		
	</cffunction>
	
	<cffunction name="getProductsByUser"  output="false" returntype="query">
		<cfargument name="user_sk" required="true">
		<cfargument name="fromPrice" required="false" default="0">
		<cfargument name="toPrice" required="false" default="0">
		
		<cfset var data = querynew('')>
		
		
		<cfquery name="qfav_fav" datasource="#application.dsn#">
			select fav_fav from users_main where user_sk = '#arguments.user_sk#'  and fav_fav is not null
		</cfquery>
		<cfif qfav_fav.recordcount>
			<cfquery name="data" datasource="#application.dsn#">
				
				SELECT distinct 
				pm.`idproduct_main`,
				pm.`title`,
				pm.`short_desc`,
				pm.`img_source`,
				CONCAT(pm.link,coalesce(si.affiliateParam, '')) as link, 			
				pm.`is_afflate`,
				pm.`source`,
				pm.`last_price`,
				pm.`category`,
				pm.`show`,
				pm.`date_created`,
				pm.`source_id`,
				pm.`quirkiness`
				,' ' as CategoryId
				,REPLACE( pm.`title`,  ' ',  '-' ) as id_seo
				FROM product_main pm left join prod_sources si 
			on pm.source_id = si.idprod_sources, product_category pc 
				where pm.idproduct_main = pc.idproduct_main 
				and pc.active=1 
				and  pm.idproduct_main in (#qfav_fav.fav_fav#)
				and pm.`last_price` > #arguments.fromPrice#
				<cfif arguments.toPrice and arguments.toPrice neq 8000>
					and pm.`last_price` <= #arguments.toPrice#
				</cfif>
				order by pm.idproduct_main
				LIMIT 200
			</cfquery>
		</cfif>
		<!--- <cfdump var="#data#"><cfabort> --->

		<cfreturn data/>
		
	</cffunction>
	
	<cffunction name="getRandomProduct"  output="false" returntype="query">
		<cfargument name="fromPrice" required="false" default="0">
		<cfargument name="toPrice" required="false" default="0">
		<cfargument name="from" default="0" required="false">
		<cfargument name="howmany" default="9" required="false">
		
		<cfset var data = querynew('')>
		
			<cfquery name="data" datasource="#application.dsn#">
				select * from (
				SELECT distinct 
				pm.`idproduct_main`,
			pm.`title`,
			pm.`short_desc`,
			pm.`img_source`,
			CONCAT(pm.link,coalesce(si.affiliateParam, '')) as link, 			
			pm.`is_afflate`,
			pm.`source`,
			pm.`last_price`,
			pm.`category`,
			pm.`show`,
			pm.`date_created`,
			pm.`source_id`,
			FLOOR(RAND() * (9 - 1 + 1)) + 1 as quirkiness
			,REPLACE( pm.`title`,  ' ',  '-' ) as id_seo
				 FROM product_main pm left join prod_sources si 
			on pm.source_id = si.idprod_sources , product_category pc 
				where pm.idproduct_main = pc.idproduct_main 
				and pc.active=1 
				and pm.`show` = 1
				and pm.`last_price` > #arguments.fromPrice#
				<cfif arguments.toPrice and arguments.toPrice neq 8000>
					and pm.`last_price` <= #arguments.toPrice#
				</cfif>
				order by quirkiness
			) tbl
			LIMIT #arguments.from#,#arguments.howmany# 
			</cfquery>
		<!--- <cfdump var="#data#"><cfabort> --->

		<cfreturn data/>
		
	</cffunction>
	
	<cffunction name="getSourceProduct"  output="false" returntype="query">
		<cfargument name="fromPrice" required="false" default="0">
		<cfargument name="toPrice" required="false" default="100000">
		<cfargument name="source_id" required="false" default="1">
		<cfargument name="from" default="0" required="false">
		<cfargument name="howmany" default="9" required="false">
		
		<cfset var data = querynew('')>
		
			<cfquery name="data" datasource="#application.dsn#">
				select * from (
				SELECT distinct 
				pm.`idproduct_main`,
			pm.`title`,
			pm.`short_desc`,
			pm.`img_source`,
			CONCAT(pm.link,coalesce(si.affiliateParam, '')) as link, 			
			pm.`is_afflate`,
			pm.`source`,
			pm.`last_price`,
			pm.`category`,
			pm.`show`,
			pm.`date_created`,
			pm.`source_id`,
			pm.`quirkiness`
			,REPLACE( pm.`title`,  ' ',  '-' ) as id_seo
				 FROM product_main pm left join prod_sources si 
			on pm.source_id = si.idprod_sources , product_category pc 
				where pm.idproduct_main = pc.idproduct_main 
				and pc.active=1 
				and pm.`show` = 1
				and pm.`last_price` > #arguments.fromPrice#
				and pm.`source_id` = #arguments.source_id#
				<cfif arguments.toPrice and arguments.toPrice neq 8000>
					and pm.`last_price` <= #arguments.toPrice#
				</cfif>
				
			) tbl
			order by idproduct_main desc
			LIMIT #arguments.from#,#arguments.howmany# 
			</cfquery>
		<!--- <cfdump var="#data#"><cfabort> --->

		<cfreturn data/>
		
	</cffunction>
	
	<cffunction name="getCats"  output="false" returntype="query">
		
		<cfset var data = querynew('')>
		
		<cfquery name="data" datasource="#application.dsn#">
			SELECT * FROM `category` where is_active=1
		</cfquery>
		<!--- <cfdump var="#data#"><cfabort> --->

		<cfreturn data/>
		
	</cffunction>
	
	<cffunction name="getProdCat"  output="false" returntype="query">
		
		<cfset var data = querynew('')>
		
		<cfquery name="data" datasource="#application.dsn#">
			SELECT * FROM `product_category`
		</cfquery>
		<!--- <cfdump var="#data#"><cfabort> --->

		<cfreturn data/>
		
	</cffunction>
	
	<cffunction name="setCats"  output="true" returntype="query">
		<cfargument name="stmts" type="array" required="true">
		<cfargument name="qindex" type="string" required="false" default="0">
		
		<cfquery name="data" datasource="#application.dsn#">
			delete from product_category where idproduct_main = #listGetAt(arguments.stmts[1],1)#
		</cfquery>
		<cfloop from="1" to="#arraylen(arguments.stmts)#" index="idx">
			<cfquery name="inserts" datasource="#application.dsn#">
				insert into product_category(idproduct_main,CategoryId,active)
				values (
				#listtoarray(arguments.stmts[idx])[1]#,
				#listtoarray(arguments.stmts[idx])[2]#,
				<cfif listtoarray(arguments.stmts[idx])[3]>1<cfelse>0</cfif>) 
			</cfquery>
		</cfloop>
		
		<cftry>
		<cfquery name="setQindex" datasource="#application.dsn#">
						update product_main set quirkiness = #arguments.qindex#
						where idproduct_main = #listtoarray(arguments.stmts[1])[1]#
					</cfquery>
		<cfcatch type="any">
			<cfdump var="#cfcatch#"><cfabort>

		</cfcatch>
		</cftry>
		<!--- <cfdump var="#data#"><cfabort> --->

		<cfreturn data/>
		
	</cffunction>
	
	<cffunction name="approve"  output="false" returntype="string">
		<cfargument name="id" type="string" required="true">
		<cfargument name="title" type="string" required="true">
		<cfargument name="short_desc" type="string" required="true">
		<cfargument name="status" type="string" required="true">
		
		<cftry>
		<cfquery name="data" datasource="#application.dsn#" result="res">
					update product_main set `show`=#arguments.status#, title='#arguments.title#',short_desc='#arguments.short_desc#'
					, date_approved = now() 
					where idproduct_main = #arguments.id# 
				</cfquery>
		<cfcatch>
			<cfdump var="#cfcatch#"><cfabort>
		</cfcatch>
		</cftry>

		<cfreturn true/>
		
	</cffunction>
	
	<cffunction name="edit"  output="false" returntype="string">
		<cfargument name="id" type="string" required="true">
		<cfargument name="title" type="string" required="true">
		<cfargument name="short_desc" type="string" required="true">
		<cfargument name="long_desc" type="string" required="true">
		<cfargument name="status" type="string" required="true">

		<cftry>
		<cfquery name="data" datasource="#application.dsn#" result="res">
					update product_main_edit set `show`=#arguments.status#, title='#arguments.title#',short_desc='#arguments.short_desc#',
					long_desc='#arguments.long_desc#' 
					where idproduct_main = #arguments.id# 
				</cfquery>
		<cfcatch>
			<cfdump var="#cfcatch#"><cfabort>
		</cfcatch>
		</cftry>

		<cfreturn true/>
		
	</cffunction>
	
	<cffunction name="reject"  output="false" returntype="string">
		<cfargument name="id" type="string" required="true">

		<cfquery name="data" datasource="#application.dsn#">
			update product_main set `show`=0
			where idproduct_main = #arguments.id#
		</cfquery>
		

		<cfreturn true/>
		
	</cffunction>
	
	<cffunction name="getCategory"  output="false" returntype="query">
		<cfset var data = querynew('')>
		<cfquery name="data" datasource="#application.dsn#" >
			SELECT id,name FROM `category` where is_active=1 order by `order`
		</cfquery>
		

		<cfreturn data/>
		
	</cffunction>
	
	<cffunction name="setNewLetter"  output="false" returntype="string">
		<cfargument name="email" required="true" type="string">
		<cfset var ret = 0>
		<cfquery name="checkEmail" datasource="#application.dsn#">
			select email from news_letter where email = '#arguments.email#'
		</cfquery>
		
		<cfif checkEmail.recordCount>
			<cfset ret = "1">
		<cfelse>	
			<cfset uuid = createuUID()>
			<cfquery name="setEmail" datasource="#application.dsn#">
				INSERT INTO news_letter
				(
				`email`,
				`is_active`,
				otp)
				VALUES
				(
					'#arguments.email#',
					0,
					'#uuid#'
				)

			</cfquery>
			
			<cfmail type="html" to="#arguments.email#" failto="tnhpindia@gmail.com" from="tnhpindia@gmail.com" subject="Welcome to 'TumseNaHoPayega'">
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
				
			</cfmail>
		</cfif>
		
		<cfreturn ret/>
		
	</cffunction>
	
	<cffunction name="register"  output="false" returntype="string">
		<cfargument name="email" required="true" type="string">
		<cfargument name="password" required="true" type="string">
		<cfargument name="passhash" required="true" type="string">
		<cfargument name="news_letter" required="false" type="string" default="1">
		
		<cfset var ret = 1>
		
		<cfset uuid = createuUID()>
		<cfquery name="setEmail" datasource="#application.dsn#">
			INSERT INTO users_main
			(
			user_sk,
			email,
			password,
			passhash,
			news_letter
			)
			VALUES
			(
				'#uuid#',
				'#arguments.email#',
				'#arguments.password#',
				'#arguments.passhash#',
				#news_letter#
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
		
		<cfreturn ret/>
		
	</cffunction>

	<cffunction name="checkUser" returntype="boolean">
		<cfargument name="email" required="true">
		<cfset var ret = false>
		
		<cfquery name="q_checkUser" datasource="#application.dsn#">
			select email from users_main where email = '#arguments.email#'
		</cfquery>
		
		<cfif q_checkUser.recordcount>
			<cfset ret = true>
		</cfif>
		
		<cfreturn ret/>
		
	</cffunction>
	
	<cffunction name="countUp" returntype="boolean">
		<cfargument name="id" required="true">
		<cfset var ret = false>
		
		<cfquery name="q_countUp" datasource="#application.dsn#">
			update product_main
			set quirkiness = quirkiness + 1
			where idproduct_main = #arguments.id#
		</cfquery>
		
		<cfset ret = true>
		
		<cfreturn ret/>
		
	</cffunction>
	
	<cffunction name="getTopFour" returntype="struct">
		<cfargument name="user_sk" required="true">
		<cfset var ret = structNew()>
		<cfset var q_getTopFour = queryNew('')>
		
		<cfset ret.userProd = 1>
		<cfset q_getTopFour = getProductsByUser(arguments.user_sk)>
		
		<cfif q_getTopFour.recordcount lt 4>
			<cfset q_getTopFour = getTopProducts(4)>
			<cfset ret.userProd = 0>
		</cfif>
		
		<cfquery dbtype="query" name="q_top4">
			select idproduct_main, title, img_source from q_getTopFour
		</cfquery>
		
		<cfset ret.top4 = q_top4>
		
		<cfreturn ret/>
		
	</cffunction>
	
	<cffunction name="getTopProducts" returntype="query">
		<cfargument name="howMany" type="numeric" required="true">
		<cfset var q_getTopProducts = queryNew('')>
		
		<cfquery name="q_getTopProducts" datasource="#application.dsn#">
			
			select 
			pm.`idproduct_main`,
			pm.`title`,
			pm.`short_desc`,
			pm.`img_source`,
			CONCAT(pm.link,coalesce(si.affiliateParam, '')) as link, 			
			pm.`is_afflate`,
			pm.`source`,
			pm.`last_price`,
			pm.`category`,
			pm.`show`,
			pm.`date_created`,
			pm.`source_id`,
				pm.`quirkiness`,
        (select GROUP_CONCAT(name)  from category where id in (select categoryid from product_category where idproduct_main = pm.`idproduct_main` and active=1 ))
        as cats
			from product_main pm left join prod_sources si
			on pm.source_id = si.idprod_sources 
			 where 
			`show`=1
			order by 
				quirkiness desc,
			idproduct_main
				LIMIT #arguments.howMany#
		</cfquery>
		
		<cfreturn q_getTopProducts/>
		
	</cffunction>
	
</cfcomponent>
                            