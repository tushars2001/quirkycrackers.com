<html>

	<head>
		<script language="javascript" src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
		
		<script>
			var cnt = 0;
			$(document).ready(function(){
			
				email_ajax();
			
			});
			
			function email_ajax(){
				$.ajax({
					type: 'get',
				    url: 'http://quirkycrackers.com/quirkycrackers/indian-history-in-pictures/email.cfm',
				    beforeSend : function(a){
				    	console.log("sending...");
				    },
				    complete : function(results){
				    				cnt++;
				    				console.log(cnt);
				    				if(cnt <130){
				    					email_ajax();
				    				}
				    				
				    				
				    }
				});	
			}
		</script>
	</head>
	<body>
		
	</body>
</html>