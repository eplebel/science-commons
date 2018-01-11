#require(gsheet) #not currently required, but perhaps for multiple sheets
gSheet.url <- 'https://docs.google.com/spreadsheets/d/e/2PACX-1vRdCTs0OOhcOI9LvmHkD4bXXm_kgxv7yq79VWtxwIgmwgi_LnK-2uWc-um_pfZBgbx2cWrNliMh9v7B/pub?output=csv'
CS.rep.table <- read.csv(url(gSheet.url), quote = "\"", stringsAsFactors=FALSE,encoding="UTF-8",na.strings="")
head(CS.rep.table)