library(shinydashboard)
library(shiny)
source("help_function.R")

ui <- dashboardPage(
  dashboardHeader(title = "UMD Data"),
  
  dashboardSidebar(
    sidebarMenu(
      id = "tabs",
      menuItem(
        "Charts", icon = icon("bar-chart-o"),
        menuSubItem("Sub-item 1", tabName = "subitem1"),
        menuSubItem("Sub-item 2", tabName = "subitem2")
      ),
      menuItem("Raw data", tabName = "data", icon=icon("th"))
    )
  ),
  
  
  dashboardBody(
    tabItems(
      tabItem("subitem1",
        fluidRow(
          box(numericInput("year",h3("year input"),value = 1999)),
          box(plotOutput("num")
        )
      )
    ),
    
    tabItem("subitem2",
      fluidRow(
        box(
          selectInput("type",h3("select type"),
                      choices = list("Bus Tickets (Number of)"="Bus Tickets (Number of)",
                                     "Food Provided for"="Food Provided for",
                                     "Food Pounds" = "Food Pounds",
                                     "Clothing Items" = "Clothing Items",
                                     "Diapers" ="Diapers",
                                     "School Kits" = "School Kits",
                                     "Hygiene Kits" = "Hygiene Kits",
                                     "Financial Support" = "Financial Support",
                                     selected = "Food Pounds"))
        ),
        box(plotOutput("plot2"))
      )
    )
    
  )
  )
)


server <- function(input, output){
  output$num <- renderPlot({plot(df,input$year)})
  output$plot2 <- renderPlot({plot2(type_df,input$type)})
}

shinyApp(ui,server)

