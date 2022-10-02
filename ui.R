######################
#   UserInterface    #  
######################

library(shiny)
library(shinythemes)

fluidPage(theme = shinytheme("flatly"),
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
                    h1("Cannabis Tincture",icon("cannabis")),
                    
                    HTML('<div class="main-container">'),
                      img(src='cannabis-oil.png', class="tincture-image"),
                    
                      HTML('<div class="result-container">'),
                    
                        HTML('<div class="result-data">'),
                          img(src='flask.png', class="flask"),
                          htmlOutput("tinctureSize"),
                        HTML('</div>'),
                    
                        HTML('<div class="result-data">'),
                          img(src='strength.png', class="strength"),
                          htmlOutput("tinctureConcentration"),
                        HTML('</div>'), 
                    
                        HTML('<div class="result-data">'),
                          img(src='cbd.png', class="activeCanabinol"),
                          htmlOutput("tinctureContent"),
                        HTML('</div>'),
                    
                        HTML('<div class="result-data">'),
                          img(src='drop.png', class="drop", style="height:5rem;"),
                          htmlOutput("tinctureContentPerMl"),
                        HTML('</div>'),
                    
                      HTML('</div>'),
                    
                    HTML('</div>')
                    
                ) # mainPanel
                
        ), # Navbar 1, tabPanel
        tabPanel("Information", withMathJax(), includeMarkdown("./www/information.md")),
        tabPanel("More coming later", "This panel is not ready yet")
        
    ) # navbarPage
) # fluidPage