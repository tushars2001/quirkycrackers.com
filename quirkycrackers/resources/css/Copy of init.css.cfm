<style>
			@font-face { font-family: tnhp; src: url('/resources/ocraextended.ttf'); } 
			body {
			    margin: 0px;
			    padding: 0px;
					
			  }
			  table td {
				font-size:100%;
				font-family: sans-serif;
			}
			
			div {
				font-size:100%;
				font-family:  sans-serif;
			}
			
			div #toprest {
				color:white;
			}
			  
			  table {
					 border-collapse: collapse;
					 border-spacing:0;
				}
			  td, tr, img  { padding: 0px; margin: 0px; border: none; }
			#container {
			 position:relative;
			 width:100%;
			}
			
			#containerMain {
			 position:relative;
			 // z-index: 50;
			}
			
			#midMain {
				position:absolute;
			}
			#leftMain {
				position:absolute;
				background-color:blue;
			}
			#rightMain {
				position:absolute;
				right:0;
				background-color:blue;
			}
			
			#containerDown {
			 background-color:black;
			 position:relative;
			 height:200px;
			 display:none;
			}
			#containerTop{
				 position:absolute;
				 top:0px;
				 <!--- background-color:#3b5998; --->
				 background-color:black;
				 width:100%;
				 min-width:900px;
				 overflow:visible;
				 z-index: 1000;
			}
			
			.slider {
				 position:absolute;
				 top:70px;
				 width:500;
				 height:300;
				 min-width:500px;
				 overflow:visible;
				 z-index: 49;
			}
			
			.mainBanner {
				 position:absolute;
				 top:75px;
				 width:500;
				 height:300;
				 min-width:500px;
				 overflow:visible;
				 z-index: 49;
			}
			
			.paneWin {
		position:relative;
	}
	
	.paneContent {
		text-align:center;
		position:absolute;
	}
	
	.paneWin h1 {
		font-size:medium;
		text-align:center;
		color:black;
	}
	
	/* unvisited link */
	.paneX a:link {
	    color: black;
	}
	
	/* visited link */
	.paneX a:visited {
	    color: black;
	}
	
	/* mouse over link */
	.paneX a:hover {
	    color: black;
	}
	
	/* selected link */
	.paneX a:active {
	    color: black;
	}
	
	a:link {
	    text-decoration: none;
	}
	
	.paneWin p {
		font-size:small;
		text-align:center;
	}
	
	.paneWin {
		position:relative;
	}
	
	.paneContent {
		position:absolute;
	}
	
	.paneWin .paneX {
		text-align:right;
		text-valign:top;
	}
	
	#aboutUs {
		position:relative;
		top:30;
	}
	
	#contactUs {
		position:relative;
		top:70;
	}
	
	#resetPassword {
		position:relative;
		top:70;
	}
	
	#menu_main {
		//font-family: tnhp;
		position:fixed;
		//width:200px;
		border:1px solid white;
		text-align:left;
	}
	.menu_item {
		//font-family: tnhp;
		height:30px;
		//background-color:#3b5998;
		//color:white;
	}
	.suggestions {
		position:relative;
		width:200px;
		border:1px solid white;
	}
	
	#cover{ position:fixed; top:0; left:0; background:rgba(0,0,0,0.6); z-index:2999; width:100%; height:100%; display:none; }
	
	.mail_id {
		background: #fff  222px -171px no-repeat;
		//opacity: 0.7;
		filter: alpha(opacity=70);
		height:30px;
		width:300px;
		border-radius: 5px;
		}
	@font-face { font-family: tnhp; src: url('/resources/ocraextended.ttf'); }
	@import url(http://fonts.googleapis.com/css?family=Anton);
	#menu_main {
		//font-family: tnhp;
		position:fixed;
		//width:200px;
	}
	.menu_item {
		//font-family: tnhp;
		height:30px;
		//background-color:#3b5998;
		//color:white;
	}
	
	.slick-prev:before, .slick-next:before { 
		    color:black !important;
		}
			
		</style>