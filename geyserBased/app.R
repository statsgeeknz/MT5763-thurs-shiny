# app.R

library(shiny)

# UI code 
ui <- fluidPage(
    sidebarLayout(
        
        sidebarPanel(
            
            actionButton(inputId = "gauss",
                         label = "Gaussian",
                         icon = icon("dog")),
            
            actionButton(inputId = "unif",
                         label = "Uniform",
                         icon = icon("cat"))
                ), 
        
        mainPanel(
            plotOutput(outputId = "hist")
            ),
        
        position = "right"
        )

)

# Server code
server <- function(input, output) {
    
    # No. of samples
    N <- 500
    
    # Create data and figure title as reactive values
    rv <- reactiveValues(data = rnorm(N),
                         title = "Samples from a Gaussian distribution")
    
    # What to do when we click on "Gaussian"
    observeEvent(input$gauss, {
        rv$data <- rnorm(N)
        rv$title <- "Samples from a Gaussian distribution"})
    
    # What to do when we click on "Uniform"
    observeEvent(input$unif, {
        rv$data <- runif(N)
        rv$title <- "Samples from a uniform distribution"})
    
    observeEvent(rv$data, { print("rv$data changed") })
    
    # Histogram
    output$hist <- renderPlot({
        hist(rv$data,
             main = rv$title,
             breaks = 30)
    })
}

# Create a Shiny app object
shinyApp(ui = ui, server = server)