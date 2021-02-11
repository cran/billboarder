## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(billboarder)
data("economics", package = "ggplot2")

## -----------------------------------------------------------------------------
draw_line <- function(var, title, percent = TRUE) {
  billboarder(height = "250px") %>%
    bb_linechart(data = economics[, c("date", var)]) %>% 
    bb_x_axis(tick = list(format = "%Y-%m", fit = FALSE)) %>%
    bb_y_axis(
      min = min(pretty(economics[[var]])), 
      max = max(pretty(economics[[var]])),
      padding = list(bottom = 0),
      tick = list(values = pretty(economics[[var]]), format = if (percent) suffix("%"))
    ) %>% 
    bb_legend(show = FALSE) %>% 
    bb_y_grid(show = TRUE) %>% 
    bb_labs(title = title) %>% 
    bb_tooltip(linked = list(name = "my-tooltip")) # <--- Id for linking tooltip
}

## ---- eval=FALSE--------------------------------------------------------------
#  draw_line("psavert", "Personal savings rate", TRUE)
#  draw_line("uempmed", "Number of unemployed", TRUE)
#  draw_line("pce", "Personal consumption expenditures", FALSE)
#  draw_line("pop", "Total population", FALSE)

## ---- echo=FALSE--------------------------------------------------------------
draw_line("psavert", "Personal savings rate", TRUE)

## ---- echo=FALSE--------------------------------------------------------------
draw_line("uempmed", "Number of unemployed", TRUE)

## ---- echo=FALSE--------------------------------------------------------------
draw_line("pce", "Personal consumption expenditures", FALSE)

## ---- echo=FALSE--------------------------------------------------------------
draw_line("pop", "Total population", FALSE)

## ---- eval = FALSE------------------------------------------------------------
#  library(shiny)
#  
#  ui <- fluidPage(
#    fluidRow(
#      column(
#        width = 10, offset = 1,
#        tags$h2("Linked tooltip in {billboarder}"),
#        fluidRow(
#          column(width = 6, billboarderOutput("g1")),
#          column(width = 6, billboarderOutput("g2")),
#          column(width = 6, billboarderOutput("g3")),
#          column(width = 6, billboarderOutput("g4"))
#        )
#      )
#    )
#  )
#  
#  server <- function(input, output, session) {
#    output$g1 <- renderBillboarder(
#      draw_line("psavert", "Personal savings rate", TRUE)
#    )
#    output$g2 <- renderBillboarder(
#      draw_line("uempmed", "Number of unemployed", TRUE)
#    )
#    output$g3 <- renderBillboarder(
#      draw_line("pce", "Personal consumption expenditures", FALSE)
#    )
#    output$g4 <- renderBillboarder(
#      draw_line("pop", "Total population", FALSE)
#    )
#  }
#  
#  shinyApp(ui, server)

