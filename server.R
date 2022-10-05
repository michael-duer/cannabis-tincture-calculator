######################
#      Server        #  
######################

library(markdown)

shinyServer(function(input, output) {
  
  # calculations based on input
  cannabidiolAmount <- reactive({ 
    # input weight * (strength in % / 100)
    input$weightFlower*(input$concentrationFlower/100)
  })
  concentrationOfTincture <- reactive({
    # input content in mg / solvent weight * 100
    cannabidiolAmount()/input$weightSolvent*100 #wiso * 100??
  })
  cannabidiolAmountPerDrop <- reactive({ 
    # content in mg / solvent weight
    cannabidiolAmount()/input$weightSolvent
  })
  #to access the value of these variables you need to add '()' after the name
  #else it will call the reactive itself
  
  # render calculated result
  # tincture size
  output$tinctureSize <- renderText({ 
    if(!is.na(input$weightSolvent)){
      paste("ca. ",input$weightSolvent,"ml") 
    }else {
      paste("Amount of tincture in ml")
    }
  }) #not 100% correct?
  
  # strength in %
  output$tinctureConcentration <- renderText({ 
    if(!is.na(input$weightSolvent) && !is.na(input$weightFlower) && !is.na(input$concentrationFlower)){
      paste(round(concentrationOfTincture(),3),"%")
    }else {
      paste("Strength of the tincture in %")
    }
  })
  
  # strength in mg
  output$tinctureContent <- renderText({ 
    if(!is.na(input$weightFlower) && !is.na(input$concentrationFlower)){
      paste(cannabidiolAmount(),"mg of ",input$selectedCannabinol," in total") 
    }else {
      paste("Total amount of ",input$selectedCannabinol," in mg")
    }
  })
  # molecule icon
  output$moleculeIcon <- renderUI({
    switch (input$selectedCannabinol,
      "CBD" = img(src='cbd-molecule.svg', class="icon activeCanabinol"),
      "THC" = img(src='thc-molecule.svg', class="icon activeCanabinol")
    )
  })
  # mg per drop (1ml)
  output$tinctureContentPerMl <- renderText({ 
    if(!is.na(input$weightFlower) && !is.na(input$concentrationFlower) && !is.na(input$weightSolvent)){
      paste(round(cannabidiolAmountPerDrop(),4)," mg/ml of ",input$selectedCannabinol) 
    }else {
      paste(" mg per per ml")
    }
  })
})