library(shiny)

header <- dashboardHeader(title = "Bank Term Deposit Analysis")

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Overview", tabName = "dashboard")
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "dashboard",
            fluidRow(
              column(3,uiOutput("total_clients")),
              column(3,uiOutput("success_rate")),
              column(3,uiOutput("avg_balance")),
              column(3,uiOutput("p_success_rate"))
            ),
            hr(),
            fluidRow(
              column(6,plotlyOutput("client_job_distribution")),
              column(6,plotlyOutput("sub_per_age"))
            ),
            hr(),
            fluidRow(
              column(12,plotlyOutput("education_level_impact"))
            )
    )
  )
)

# Put them together into a dashboardPage
dashboardPage(
  header,
  sidebar,
  body
)