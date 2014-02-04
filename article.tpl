
<!doctype html>

<html>
  
  <head>
    <title>Science-Commons.org - ${data['title']}</title>
    <meta name="viewport" content="width=device-width">
    <link rel="stylesheet" href="bootstrap.min.css">
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
            <a href="http://www.science-commons.org" class="navbar-brand"><strong><font size="5px">Science-Commons.org</font></strong></a>
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
                <button type="submit" class="btn btn-default">Submit</button>
              </form>
              <ul class="nav navbar-nav pull-right">
                <li>
                  <a href="#">Username</a>
                </li>
                <li>
                  <a href="#">My ScienceCommons</a>
                </li>
                <li>
                  <a href="#">Sign Out</a>
                </li>
              </ul>
            </nav>
          </div>
        </div>
      </div>
      <span><i>${data['journal']}, (${data['year']}) doi: ${data['doi']}</span><br>
      <font size="6px">${data['title']}</font><br>
      <span>${data['author']}</span><br>
      <span>${data['affiliation']}</span><br>
      <span><b>Action Editor: </b>${data['editor']}<b>Reviewer 1:</b>  <i>Unknown at this time.</i>, <b>Reviewer 2:</b> <i>Unknown at this time.</i></span><br><br>
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
							<p><b>Keywords:</b> <a>Embodied cognition</a>, <a>secrecy</a>, <a>Concealment of secrets</a>, <a>Independent direct replication</a></p>
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
                <img src="logos/pcurve.png">&nbsp; <i>Not yet estimated</i><br>
                <img src="logos/icindex.png">&nbsp; &nbsp;<i>Not yet estimated</i>
              </div>
              <div></div>
            </div>
        </div>
        <div class="col-md-8">
          <div class="panel panel-default">
            <div class="panel-heading">
              <font size="5px">Replicability (0/0) &nbsp;&nbsp;</font> 
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
				  <font size="5px">Data/Syntax (3)</font>&nbsp;&nbsp;
				  <img src="logos/badgeAvailData.png" width="50">&nbsp; &nbsp;
				  <img src="logos/badgeReprodAnal.png" width="50">
				</div>
				<div class="panel-body">
					${data['materials']}				 				  
				</div>
          </div>
		</div>
		<div class="col-md-6">
          <div class="panel panel-default">
            <div class="panel-heading">
              <font size="5px">Materials (0) &nbsp;&nbsp;</font> <img src="logos/badgeAvailMat.png" width="50">&nbsp; &nbsp; &nbsp;
            </div>
            <div class="panel-body">
              <img src="logos/osf.png" class="pull-left">
							<p class="tab">For Study 1:</p>
							<ul>
							<ul>
							<li><a href="https://osf.io/api/v1/project/w6kv5/osffiles/ReplicationProtocol_for_Slepian_et_al._2012_Replication_1_-_LeBel.doc/version/1/">
							ReplicationProtocol_Replication_1_-_LeBel.doc</a></li>
							</ul>
							</ul>
							<p class="tab">For Study 2:</p>
							<ul>
							<ul>
							<li><a href="https://osf.io/api/v1/project/euzwh/osffiles/ReplicationProtocol_for_Slepian_et_al._2012_Replication_2_-_LeBel.doc/version/1/">
							ReplicationProtocol_Replication_2_-_LeBel.doc</a></li>
							</ul>
							</ul>
            </div>
          </div>
        </div>
	  </div>
	  <div class="row">
		  <div class="col-md-6" class="panel-group" id="accordion">
			  <div class="panel panel-default">
				<div class="panel-heading">
				  <font size="5px">Pre-registration (1) &nbsp;&nbsp;</font> 
						<img src="logos/badgePreRegAnal.png" width="50">
					<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse1"> <i class="fa fa-chevron-down fa-2x pull-right"></i></a>
				</div>
				<div class="accordion-body collapse" id="collapse1">
					<div class="accordion-inner">
						<div class="panel-body">
							<img src="logos/osf.png" class="pull-left">
							<p class="tab">For Study 1:</p>
							<ul>
							<ul>
							<li><a href="https://osf.io/tvszz/">PreregistrationProtocol</a></li>
							</ul>
							</ul>
							<p class="tab">For Study 2:</p>
							<ul>
							<ul>
							<li><a href="https://osf.io/54v2d/">PreregistrationProtocol</a></li>
							</ul>
							</ul>
						</div>
					</div>
				</div>
			  </div>
			</div>
			<div class="col-md-6" class="panel-group" id="accordion">
			  <div class="panel panel-default">
				<div class="panel-heading">
				  <font size="5px">Disclosure (4) &nbsp;&nbsp;</font> 
				  <img src="logos/badgeDisclMethods.png" width="50">
					<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse2"> <i class="fa fa-chevron-down fa-2x pull-right"></i></a>
				</div>
				<div class="accordion-body collapse" id="collapse2">
					<div class="accordion-inner">
						<div class="panel-body">
						<img src="logos/psiDiscl.png" class="pull-left">
						<ol>
							<ol>
							<ol>
								<li>Exclusions: Full Disclosure</li>
								<li>Measures: Full Disclosure</li>
								<li>Conditions: Full Disclosure</li>
								<li>Sample size: Full Disclosure</li>
							</ol>
							</ol>
						</ol>
						</div>
					</div>
				</div>
			  </div>
			</div>
			<div class="col-md-12">  
			  <div class="panel panel-default">
				<div class="panel-heading">
				  <font size="5px">Comments/Blog Posts (1)</font>
				</div>
				<div class="panel-body">
				  <table class="table table-striped">
					<tbody>
					  <tr>
						<td style="vertical-align:middle">
						  <img src="logos/wordpress.jpg" width="100">
						</td>
						<td>
						  <strong>Ase Kvist Innes-Ker &nbsp; &nbsp;</strong> November 26, 2013<br>
						  Calooo Calay, what a happy day! Ase Fixes Science blogs about big secrets and steep hills. See blog post <a href="http://asefixesscience.wordpress.com/2013/11/26/calooo-calay-what-a-happy-day/">here</a></td>
					  </tr>
					  
					</tbody>
				  </table>
				</div>
			  </div>
			</div>
      </div>
    </div>
  </body>

</html>
