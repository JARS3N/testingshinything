query_data<-function(a_lot,a_var){
require(RMySQL)
data_con <- adminKraken::con_mysql()
str<-'Select xvar,sn from mvdata where Lot = "xlot";'  
gsub1<-gsub("xvar",a_var,str)
data_query_string<-gsub("xlot",a_lot,gsub1)
data_query<-dbSendQuery(data_con,data_query_string)
fetched_data<-dbFetch(data_query,n=-1)
clean<-dbClearResult(data_query)
drop_con<-dbDisconnect(data_con)
fetched_data
}
