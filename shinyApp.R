
#/‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\#
#|  Cannabis Tincture Calculator  |#
#\________________________________/#


# Load R packages
library(shiny)
library(shinythemes)
library(markdown)



######################
#   UserInterface    #  
######################

ui <- fluidPage(theme = shinytheme("flatly"),
        # link stylesheet
        tags$head(
          tags$link(rel = "stylesheet", type = "text/css", href = "stylesheet.css")
        ),
        # import fontawesome icons
        tags$style("@import url(https://use.fontawesome.com/releases/v5.7.2/css/all.css);"),
        
        navbarPage(
          "Cannabis Tincture Calculator",
          tabPanel("Simple Ratio Calculator",
                   sidebarPanel(
                     tags$h3("Cannabis Flower:"),
                     numericInput("weightFlower", "Amount in Gramm:", ""),
                     selectInput("selectedCannabinol", label = p("Select desired Cannabinol"), 
                                 choices = list("CBD" = "CBD", "THC" = "THC"), 
                                 selected = 1),
                     sliderInput("concentrationFlower", label = p("Cannabis Strength in %"), min = 0, 
                                 max = 100, value = 15),
                     #numericInput("concentrationFlower", "Strength of desired Cannabidiol in %:", ""),
                     
                     br(), # same as <br> in html
                     tags$h3("Solvent:"),
                     tags$p("Recommendation: Alcohol or Oil"),
                     numericInput("weightSolvent", "Amount in ml:", ""),
                     
                   ), # sidebarPanel
                   mainPanel(#style="display:flex;justify-content:center;",
                     HTML('<div class="result-container">'),
                     h1("Cannabis Tincture",icon("cannabis")),
                     
                     img(src='cannabis-oil.png', class="tincture-image"),
                     htmlOutput("tinctureSize"),
                     htmlOutput("tinctureConcentration"),
                     htmlOutput("tinctureContent"),
                     HTML('</div>')
                     
                   ) # mainPanel
                   
          ), # Navbar 1, tabPanel
          tabPanel("Information", withMathJax(), includeMarkdown("./www/information.md")),
          tabPanel("More coming later", "This panel is not ready yet")
          
        ) # navbarPage
) # fluidPage



######################
#      Server        #  
######################

server <- function(input, output) {
  
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
}



######################
#  Create Shiny App  #  
######################

shinyApp(ui = ui, server = server)


######################
# Icons/Images used  #  
######################

#tincture src: https://www.flaticon.com/free-icon/cannabis-oil_3486758?term=cannabis&page=1&position=8&page=1&position=8&related_id=3486758&origin=search

#thc src: https://www.flaticon.com/free-icon/thc_3486469?term=thc&page=1&position=4&page=1&position=4&related_id=3486469&origin=search
#cbd src: https://www.flaticon.com/free-icon/cbd_3486363?term=cbd&related_id=3486363
#flask src: https://www.flaticon.com/free-icon/flask_1184072?term=flask&page=1&position=1&page=1&position=1&related_id=1184072&origin=search
#strenght src: https://www.flaticon.com/free-icon/strength_4429835?term=strength&page=1&position=34&page=1&position=34&related_id=4429835&origin=search

