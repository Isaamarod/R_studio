#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(gapminder)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("HOLI"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("year",
                     "YEAR",
                     min = 1952,
                     max = 2007,
                     value = 1952,
                     step=5)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("continentPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$continentPlot<- renderPlot({
      # generate bins based on input$bins from ui.R
     gapminder2007 <- gapminder %>% filter(year==input$year)
     
     ggplot(gapminder2007, aes(x = gdpPercap,y = lifeExp,color=continent,size=pop)) +
       geom_point(aes(alpha=0.5))+ scale_x_log10()+expand_limits(y=c(0,90),x=c(min(gapminder$gdpPercap),max(gapminder$gdpPercap)))
     
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

