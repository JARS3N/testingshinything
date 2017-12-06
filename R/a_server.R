a_server<-function(){
  shinyServer(function(input, output,session) {
  lot_choices<-nms()
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
}
