library(shiny)
library(bslib)
library(dplyr)
library(plotly)
library(ggplot2)

df <- read.csv("../data/raw/amazon_sales_dataset.csv")

df$total_revenue <- as.numeric(df$total_revenue)
df$total_revenue[is.na(df$total_revenue)] <- 0

df$order_date <- as.Date(df$order_date)
df$year <- format(df$order_date, "%Y")
df$year_month <- format(df$order_date, "%Y-%m")

year_choices <- sort(unique(df$year))

ui <- page_fillable(
  title = "Amazon Sales Dashboard",
  
  layout_sidebar(
    sidebar = sidebar(
      checkboxGroupInput(
        inputId = "input_year",
        label = "Years",
        choices = year_choices,
        selected = year_choices,
        inline = TRUE
      )
    ),
    
    card(
      value_box(
        title = "Total Revenue",
        value = textOutput("valuebox_revenue")
      ),
      
      card(
        card_header("Revenue Trend by Month"),
        plotlyOutput("plot_trend", height = "500px")
      )
    )
  )
)

server <- function(input, output, session) {
    filtered_data <- reactive({
        if (length(input$input_year) == 0) {
            return(data.frame())}
    
    df %>%
      filter(year %in% input$input_year)})
  
    output$valuebox_revenue <- renderText({
        if (nrow(filtered_data()) == 0) {
            return("No data")}

        total_revenue <- sum(filtered_data()$total_revenue, na.rm = TRUE)
        paste0("$", formatC(total_revenue, format = "f", big.mark = ",", digits = 2))
    })
  
    output$plot_trend <- renderPlotly({
        if (nrow(filtered_data()) == 0) {
            p <- ggplot() +
            annotate("text", x = 1, y = 1, label = "No data", size = 6) +
            theme_void()

            return(ggplotly(p))
            }
            
        trend_data <- filtered_data() %>%
        group_by(year_month) %>%
        summarise(total_revenue = sum(total_revenue, na.rm = TRUE), .groups = "drop")
    
    p <- ggplot(trend_data, aes(x = year_month, y = total_revenue, group = 1)) +
        geom_line() +
        geom_point() +
        scale_y_continuous(labels = scales::dollar) +
        labs(x = "Month", y = "Total Revenue") +
        theme_minimal() +
        theme(
        axis.text.x = element_text(angle = 45, hjust = 1))
    
    ggplotly(p)
  })
}

shinyApp(ui = ui, server = server)