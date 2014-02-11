<!doctype html>

<html>
  
  <head>
    <title>Science-Commons.org - ${data['title']}</title>
    <meta name="view	port" content="width=device-width">
    <link rel="stylesheet" href="http://www.science-commons.org/bootstrap.min.css">
    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.0/css/font-awesome.css">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
	<style>
		#myoutercontainer { position:relative }
		#myinnercontainer { position:absolute; top:50%; height:10em; margin-top:5em }
	</style>
  </head>
  
  <body>
    <div class="container">
      <div class="navbar navbar-default">
        <div class="container">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
              <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
            </button>
            <a href="http://${index_url}" class="navbar-brand"><strong><font size="5px">Science-Commons.org</font></strong></a>
          </div>
          <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
              <li>
                <a href="about.html">About</a>
              </li>
            </ul>
            <nav>
              <form class="navbar-form navbar-left">
                <div class="form-group">
                  <input type="text" class="form-control" placeholder="Search">
                </div>
              </form>
              <ul class="nav navbar-nav pull-right">
                <li>
                  <a href="#">Username</a>
                </li>
                <li><a rel="tooltip" title="Settings" href="#"><i class="icon-cog icon-white"></i></a></li>
		<li><a rel="tooltip" title="Log out" href="#"><i class="icon-off icon-white"></i></a></li>
              </ul>
            </nav>
          </div>
        </div>
      </div>
      <span><i>${data['journalID'][0]}</i> (${data['year']}), doi: ${data['doi']}</span><br>
      <font size="6px">${data['title']}</font><br>
      <span>${data['authorIDs']}</span><br>
      <span>${data['affiliation']}</span><br>
      <span><b>Action Editor: </b>${data['editor']} &nbsp;&nbsp;${data['reviewers']}</span><br><br>
		<div class="row">
		  <div class="col-md-12" class="panel-group" id="accordion">
			<div class="panel panel-default">
				<div class="panel-heading">
					<strong>Abstract</strong>
					<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse3"> <i class="fa fa-chevron-down fa-2x pull-right"></i></a>
				</div>
				<div class="accordion-body collapse" id="collapse3">
					<div class="accordion-inner">
						<div class="panel-body">
							<p>${data['abstract']}</p>
							<p><b>Keywords:</b> ${data['keywords']}</p>
						</div>
					</div>
				</div>
			</div>
		  </div>
		  
		</div>
      <div class="row">
        <div class="col-md-4">
            <div class="panel panel-default">
				<div class="panel-heading">
					<font size="5px">Key Statistics</font>
					
				</div>
				<div class="panel-body">
                <strong><font size="3px">Basic Statistics</font></strong><br>
                ${data['stats']}
                <strong><font size="3px">Evidentiary Value</font></strong><br>
              		<img src="http://science-commons.org/logos/pcurve.png">&nbsp; <a rel="tooltip" title="Studies lack evidential value.">&#934; = 1.70, CI95% = [1.05, 2.35]</a><br>
                	<img src="http://science-commons.org/logos/icindex.png">&nbsp; <a rel="tooltip" title="Only 8% chance these data originated from random sampling.">IC-index = .92, CI95% = [.85, .99]</a><br>
			<img src="http://science-commons.org/logos/ptes.png">&nbsp; <a rel="tooltip" title="There is an excess of significance across this set of studies."><i>p</i><sub>TES </sub>< .07</a>
              </div>
              <div></div>
            </div>
        </div>
        <div class="col-md-8">
          <div class="panel panel-default">
            <div class="panel-heading">
              <font size="5px">Replicability (${data['replications'].count('<br/>')}) &nbsp;&nbsp;</font> 
            </div>
            <div class="panel-body">
				<strong>Independent Replications</strong>
		${data['replications']}
            </div>
          </div>
        </div>
      </div>
	  
	  <div class="row">
		<div class="col-md-6">
			<div class="panel panel-default">
				<div class="panel-heading">
				  <font size="5px">Data/Syntax (${data['data'].count("</li>")})</font>&nbsp;&nbsp;
					
				  ${data['dataAvailBadge']}&nbsp; &nbsp;
				  ${data['reprodAnalBadge']}
				</div>
				<div class="panel-body">
				    ${data['dataSourceLogo']}
					${data['data']}				 				  
				</div>
          </div>
		</div>
		<div class="col-md-6">
          <div class="panel panel-default">
            <div class="panel-heading">
              <font size="5px">Materials (${data['materials'].count("</li>")}) &nbsp;&nbsp;</font> ${data['matAvailBadge']}&nbsp; &nbsp; &nbsp;
            </div>
            <div class="panel-body">
              ${data['materialSourceLogo']}
			  ${data['materials']}
            </div>
          </div>
        </div>
	  </div>
	  <div class="row">
		  <div class="col-md-6" class="panel-group" id="accordion">
			  <div class="panel panel-default">
				<div class="panel-heading">
				  <font size="5px">Pre-registration (${data['prereg'].count("</li>")}) &nbsp;&nbsp;</font> 
						${data['preRegBadge']}
					<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse1"> <i class="fa fa-chevron-down fa-2x pull-right"></i></a>
				</div>
				<div class="accordion-body collapse" id="collapse1">
					<div class="accordion-inner">
						<div class="panel-body">
							${data['preRegSourceLogo']}
							${data['prereg']}
						</div>
					</div>
				</div>
			  </div>
			</div>
			<div class="col-md-6" class="panel-group" id="accordion">
			  <div class="panel panel-default">
				<div class="panel-heading">
				  <font size="5px">Disclosure&nbsp;&nbsp;</font> 
				  ${data['disclBadge']}
					<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse2"> <i class="fa fa-chevron-down fa-2x pull-right"></i></a>
				</div>
				<div class="accordion-body collapse" id="collapse2">
					<div class="accordion-inner">
						<div class="panel-body">
						${data['disclSourceLogo']}
						${data['disclosure']}
						</div>
					</div>
				</div>
			  </div>
			</div>
			<div class="col-md-12">  
			  <div class="panel panel-default">
				<div class="panel-heading">
				  <font size="5px">Comments/Blog Posts (${data['comments'].count("</tr>")})</font>
				</div>
				<div class="panel-body">
				  ${data['comments']}
				</div>
			  </div>
			</div>
      </div>
    </div>
  </body>

</html>
