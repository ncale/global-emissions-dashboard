#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#

# load packages
library(shiny)
library(tidyverse)
library(ggplot2)
library(RCurl)

# load data
data_url <- 'https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv'
DATA <- read.csv(text = getURL(data_url), stringsAsFactors=TRUE)

# define server logic
shinyServer(function(input, output) {

    output$overallEmissions <- renderPlot({

        # prep data based on input$... from ui.R
        DATA.VIS <- subset(DATA, subset=!is.na(DATA$co2))
        if (input$perCap=="total") {
          DATA.VIS <- aggregate(co2~year, DATA.VIS, FUN=sum)
        } else {
          DATA.VIS <- aggregate(co2_per_capita~year, DATA.VIS, FUN=sum)
        }
        
        
        # generate the plot
        ggplot(DATA.VIS, aes(x=year, y=.data[[names(DATA.VIS)[2]]])) +
          geom_line() +
          xlim(input$yearRange[1], input$yearRange[2])

    }) # end output

}) # end server
