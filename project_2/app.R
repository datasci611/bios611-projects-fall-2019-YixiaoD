library(shinydashboard)
library(shiny)
source("/Users/Yixiao/Desktop/611project/project_2/helper.R")

ui <- dashboardPage(
  #dashboard name
  dashboardHeader(title = "UMD Data"),
  
  #dashboard side bar
  dashboardSidebar(
    sidebarMenu(
      id = "tabs",
      #charts menu with visits and clients submenu
      menuItem(
        "Charts", icon = icon("bar-chart-o"),
        #Chars menu has two submenus
        menuSubItem("Records", tabName = "subitem1")
      ),
      #raw data menu
      menuItem("Raw data", tabName = "data", icon=icon("th")),
      helpText("")
    )
  ),
  
  #dashboard body
  dashboardBody(
    tabItems(
      tabItem("subitem1",
        fluidRow(
          column(width = 4,
            #introduction text
            box(
              width = NULL, solidHeader = TRUE, background = "black",
              strong("In this chart, you can see how many records of different type of aid are there in each year or month.")
            ),   
            #select aid type
            box(
              width=NULL, status = "warning",
              selectInput("type","Select a kind of help",
                          choices = list("All" = "all",
                                         "Bus Tickets"="Bus Tickets (Number of)",
                                         "Food Pounds" = "Food Pounds",
                                         "Clothing Items" = "Clothing Items",
                                         "Diapers" ="Diapers",
                                         "School Kits" = "School Kits",
                                         "Hygiene Kits" = "Hygiene Kits",
                                         "Financial Support" = "Financial Support"),
                                         selected = "All"
              )
            ),
            #select x-axis: month or year
            box(
              width = NULL, status = "warning",
              radioButtons("plot_type","Select X-axis",choices = list("year"="year","month"="month"),selected ="year"),
              "If you select year, the plot will be the number of records in each year. If you select month, the plot will be the number of records in each month of the selected year."
            ),
            #input selected year
            box(
              width = NULL, status = "warning", 
              numericInput("year", "Select a year", min=2001, max=2019, value=2001))
            ),
          
          #plot histogram     
          column(width = 8, 
            box(
              width = NULL ,title = "Histogram", solidHeader = TRUE, status = "primary", 
              plotOutput("number_visits")
            )
          )
        )
      ),
      #raw data outout
      tabItem("data", fluidPage(dataTableOutput("df_table")))
    )
  )
)


server <- function(input, output){
  output$number_visits <- renderPlot({plot(df,input$plot_type,input$type,input$year)})
  output$df_table <- renderDataTable({df}) #raw data
}


shinyApp(ui,server)

