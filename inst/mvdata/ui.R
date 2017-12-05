library(shiny)
shinyUI(fluidPage(
  headerPanel("Machine Vision Lot QC Data"),
  mainPanel(plotOutput('plot1')),
  sidebarPanel(
    # selectInput("PLAT", "Platform",c("XFe24"="xfe24wetqc","XFe96"="xfe96wetqc","XFp"="xfpwetqc","XF24"="xf24legacy"),selected=FALSE, multiple = FALSE),
    selectInput(
      "Lot",
      "Select Lot",
      c('Lots'),
      selected = FALSE,
      multiple = FALSE
    ),
    selectInput(
      "Variable",
      "Select Variable",
      c(
        "mean_diameter",
        "inner_diameter",
        "outer_diameter",
        "total_area" ,
        "circularity" ,
        "mean_intensity",
        "min_intensity",
        "max_intensity",
        "intensity_stdev",
        "optical_center_x",
        "optical_center_y",
        "optical_radius",
        "spot_center_x" ,
        "spot_center_y",
        "num_spots"  ,
        "num_blobs"
      ) ,
      multiple = FALSE
    )
    
  )
))

           
