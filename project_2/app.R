library(shinydashboard)
 
ui <- dashboardPage(
  dashboardHeader(title = ""),
  dashboardSidebar(),
  dashboardBody()
)

server <- function(input, output) {}

shinyApp(ui, server)