<!doctype html>

<html>
  
  <head>
    <title>Science-Commons.org</title>
    <meta name="viewport" content="width=device-width">
    <link rel="stylesheet" href="http://science-commons.org/bootstrap.min.css">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="https://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
    <style type="text/css">
      /* Space out content a bit */
     
     
      /* Everything but the jumbotron gets side spacing for mobile first views */
      .header, .marketing, .footer {
        padding-left: 5px;
        padding-right: 5px;
      }
     
      
      /* Customize container */
      @media(min-width: 768px) {
        .container {
          max-width: 730px;
        }
      }
      .container-narrow > hr {
        margin: 30px 0;
      }
      /* Main marketing message and sign up button */
      .jumbotron {
        text-align: center;
        padding: 10px;
        border-bottom: 1px solid #e5e5e5;
      }
      .jumbotron .btn {
        font-size: 21px;
        padding: 4px 10px;
      }
     
	 /* Wrapper for page content to push down footer */
      #wrap {
        min-height: 100%;
        height: auto !important;
        height: 100%;
        /* Negative indent footer by it's height */
        margin: 0 auto -60px;
      }
      
      
      #footer {
        background-color: #f5f5f5;
      }
      
      
      .input-mysize { width: 50% }
     
    </style>
  </head>
  
  <body>
    <div class="container">
      <div class="row">
        <div class="col-md-12"><p></p><br></div>
      </div>
      
      <div class="jumbotron">
        <h1>Science-Commons</h1>

        <h2>Know the Scientific Record.</h2><br>
        <p>Science-Commons' mission is to accelerate the growth of cumulative knowledge and innovation by organizing and curating key information about scientific articles.
		</p>
        <p><a class="btn btn-info btn-xs" href="http://science-commons.org/about.html">Learn More</a></p>
      </div>
      
		  <div class="row">
			<div class="col-md-12">
			  <form role="search">
				<div class="form-group">
				  <center><input type="text" class="form-control input-mysize" placeholder="Search by article title, author name, or DOI"></center>
				</div>
			  </form>
			</div>
		  </div>
		  <div class="row">
			<div class="col-md-6">
			  <center>
				<h3>Most <a rel="tooltip" title="Curation is the process of extracting, filtering, and selecting information to improve its quality" href="http://en.wikipedia.org/wiki/Digital_curation">Curated</a> Articles</h3> 
			  </center>
				${completes}  
			</div>
			<div class="col-md-6">
			  <center>
				<h3>Recently Updated Articles</h3>
			  </center>
			  ${recents}        
			</div>
		  </div>
		  
		  <div class="row">
			<div class="col-md-12">
			  <center>
				<h3>All Articles</h3>
			  </center>
				${all_articles}    
				
			  </div>
		  </div>
     
	 </div>
      
      
      
      <div id="footer">
        <div class="container">
		  <ul class="nav navbar-nav">
            <li>
              <a href="about.html">About</a>
            </li>
            <li>
              
            </li>
          </ul>
        </div>
        <!-- /container -->
      </div>
  </body>

</html>
