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
  #to access the value of these variables you need to add '()' after the name
  #else it will call the reactive itself
  
  # render calculated result
  # tincture size
  output$tinctureSize <- renderText({ 
    if(!is.na(input$weightSolvent)){
      paste("ca. ",input$weightSolvent,"ml",img(src='flask.png', class="flask")) 
    }else {
      paste("Amount of tincture in ml",img(src='flask.png', class="flask"))
    }
  }) #not 100% correct?
  
  # strength in %
  output$tinctureConcentration <- renderText({ 
    if(!is.na(input$weightSolvent) && !is.na(input$weightFlower) && !is.na(input$concentrationFlower)){
      paste(concentrationOfTincture(),"%",img(src='strength.png', class="strength"))
    }else {
      paste("Strength of the tincture in %",img(src='strength.png', class="strength"))
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
})