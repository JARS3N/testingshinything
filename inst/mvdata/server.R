library(shiny)
library(ggplot2)
library(ggthemes)
library(RMySQL)
#my_db <- adminKraken::con_dplyr()

nms <- function() {
  nms_con <- adminKraken::con_mysql()
  nms <- RMySQL::dbSendQuery(nms_con, 'Select Distinct(Lot) from kraken.mvdata;')
  x <- RMySQL::dbFetch(nms)
  RMySQL::dbClearResult(nms)
  RMySQL::dbDisconnect(nms_con)
  x
}

# var_names<-function(){
#  col_con <- adminKraken::con_mysql()
#  col_df<-dbColumnInfo(data_con,'mvdata')
#  RMySQL::dbDisconnect(col_con)
#  as.character(col_df$name[!grepl(c("Lot|sn|Well|Port|plat"),col_df$name)])
# }

query_data<-function(a_lot,a_var){
data_con <- adminKraken::con_mysql()
str<-'Select xvar,sn from mvdata where Lot = "xlot";'  
gsub1<-gsub("xvar",a_var,str)
data_query_string<-gsub("xlot",a_lot,gsub1)
data_query<-dbSendQuery(data_con,data_query_string)
fetched_data<<-dbFetch(data_query,n=-1)
clean<-dbClearResult(data_query)
drop_con<-dbDisconnect(data_con)
fetched_data
}
lot_choices<-nms()
shinyServer(function(input, output,session) {
  updateSelectInput(session,'Lot',choices=lot_choices)

  observeEvent(c(input$Lot,input$Variable),{

    output$plot1 <- renderPlot({
      Data<-query_data(input$Lot,input$Variable)
      Data$sn<-as.numeric(Data$sn)
      Data<-Data[order(Data$sn),]
      names(Data)<-c("var","sn")
      #print(head(Data)) ## debugging

                 ggplot(Data,aes(x=sn,y=var))+
                 geom_point(alpha=.3,shape=21,fill='darkgreen')+
                 theme_bw()+
                 theme(text = element_text(size=14),
                       axis.text.x = element_text(angle=90, vjust=1)) +
                 ylab(input$Variable)+
                 ggtitle(paste0("Machine Vision:",input$Variable, "\n Lot:",input$Lot))
    })

})
  
})
