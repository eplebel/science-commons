library("rio")
# export to JSON (minimified non-beautified format; cf. http://www.convertcsv.com/csv-to-json.htm)
export(CS.rep.table, "CS.rep.table.json")

#to export to .RData file type; works but not sure this is useful for enough ppl 
#(also it loads table as object "x", and not sure how to change this) 
#export(CS.rep.table, "CS.rep.table.RData")

# export to CSV 
#(but don't need this given already have access to this via published gSheet CSV URL)
#export(CS.rep.table, "CS.rep.table.csv")