#code for eventual CS add/update replications automation;
#generate-HTML-table.R will automatically insert HTML table in proper place within index.html page


require(shiny)
#template.html would be my home page index.html with {{"master.rep.table"}} in between curly brackets
htmlTemplate("template.html",
             button = actionButton("action", "Action"),
             slider = sliderInput("x", "X", 1, 100, 50),
             
             HTML.to.be.inserted = HTML(cumulative.row.string) #will need to modify generate-HTML-table.R function so it uses a cumulative string
             
)