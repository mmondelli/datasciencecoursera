library(shiny)

shinyServer(function(input, output) {
  
  srv.channels <- unique(blf.df[blf.df$TEMA == topic[1],]$ALTERNATIVAS)
  srv.channels <- data.frame(ALTERNATIVAS = as.character(srv.channels[-1]),
                             Type = c('Phone', 'Internet', 'Company Store', 'Other'))
  
  grade <- unique(blf.df[blf.df$TEMA == topic[2],]$ALTERNATIVAS)
  grade <- data.frame(ALTERNATIVAS = as.character(grade[c(-1, -2, -14)]),
                      Type = seq(0, 10, 1))
  
  dt1 <- reactive({
    aux <- unique(blf.df[blf.df$TEMA == topic[1],])
    aux <- aux[!grepl("Amostra", aux$CALCULO),]
    aux <- aux[!grepl("Total", aux$ESTADO),]
    aux <- merge(aux, srv.channels, by = 'ALTERNATIVAS')
    aux <- aux[c(3,4,7,8,9)]
    aux <- aux[grepl(input$company, aux$OPERADORA),]
   
  })
  
  dt2 <- reactive({
    aux <- unique(blf.df[blf.df$TEMA == topic[2],])
    aux <- aux[!grepl("Amostra", aux$CALCULO),]
    aux <- aux[!grepl("Total", aux$ESTADO),]
    aux <- aux[!grepl("Ponderada", aux$CALCULO),]
    aux <- aux[!grepl("NS", aux$ALTERNATIVAS),]
    aux <- merge(aux, grade, by = 'ALTERNATIVAS')
    aux <- aux[grepl(input$company, aux$OPERADORA),]
    aux <- aux[grepl(input$state, aux$ESTADO),]
    
    a <- aux[c(3,4,7,9)] 
    a['YEAR'] <- as.factor('2015')
    b <- aux[c(3,4,8,9)]
    b['YEAR'] <- as.factor('2016')
    colnames(a) <- colnames(b) <- c('OPERADORA', 'ESTADO', 'PERCENT', 'Type', 'Year')
    aux <- rbind(a, b)
  })
  
  dt3 <- reactive({
    aux <- unique(blf.df[blf.df$TEMA == topic[1],])
    calc <- aux[,c(2,3)]; calc <- calc[!grepl("Total", calc$ESTADO),]
    calc <- unique(calc)
    calc <- aggregate(ESTADO ~ OPERADORA, data = calc, FUN = function(x){NROW(x)})
    print(calc)
    calc <- calc[grepl(input$company, calc$OPERADORA),]
    colnames(calc) <- c('Company', 'States')
    as.character(calc[2])
  })
  
  output$plotChannel2015 <- renderPlot({
    ggplot() +
      geom_bar(data = dt1(), aes(y = X2015, x = ESTADO, fill = Type),
               stat = "identity") +
      theme_minimal() +
      labs(
        subtitle=" ",
        y="2015", 
        x="States") +
      theme(panel.background = element_rect(colour = "grey", size=0.3),
            legend.title=element_blank()) +
      scale_fill_manual(values=clrs)
  
  })
  
  output$plotChannel2016 <- renderPlot({
    ggplot() +
      geom_bar(data = dt1(), aes(y = X2016, x = ESTADO, fill = Type),
               stat = "identity") +
      theme_minimal() +
      labs(
        subtitle=" ",
        y="2016", 
        x="States") +
      theme(panel.background = element_rect(colour = "grey", size=0.3),
            legend.title=element_blank()) +
      scale_fill_manual(values=clrs)
    
  })
  
  output$plotScore <- renderPlot({
    
    ggplot() +
      geom_bar(data = dt2(), aes(y = PERCENT, x = Type, fill = Year),
               stat = "identity",  position=position_dodge()) +
      theme_minimal() +
      labs(
        subtitle=" ",
        y="Percent", 
        x="Score (1 to 10)") +
      theme(panel.background = element_rect(colour = "grey", size=0.3)) +
      scale_fill_manual(values=clrs[c(1,3)])
    
  })
  
  output$dataset <- renderDataTable(blf.df)
  output$coverage <- renderText(dt3())
  
  
})
