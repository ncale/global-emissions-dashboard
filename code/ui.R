#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#

# load packages
library(shiny)
library(RCurl)

# load data
data_url <- 'https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv'
DATA <- read.csv(text = getURL(data_url), stringsAsFactors=TRUE)

# prep data


# define application UI
shinyUI(fluidPage(

    # title
    titlePanel("Global Emissions Dashboard"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("yearRange","Input Year Range:",
                        min=min(DATA$year), max=max(DATA$year), 
                        value=c(min(DATA$year),max(DATA$year))),
            radioButtons("perCap", "Select total or per capita emissions",
                         choices=c("total", "per capita"),
                         selected="total")
        ),
        mainPanel(
            plotOutput("overallEmissions")
        )
        
    ) # end sidebar layout function
    
)) # end application UI
