## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  screenshot.force = FALSE
)
library(billboarder)

## -----------------------------------------------------------------------------
set_theme("modern")
set_color_palette(scales::brewer_pal(palette = "Set1")(9))

## ----barchart-----------------------------------------------------------------
library(billboarder)

# data
data("prod_par_filiere")

billboarder(data = prod_par_filiere) %>%
  bb_barchart(
    mapping = aes(x = annee, y = prod_hydraulique),
    color = "#102246"
  ) %>%
  bb_y_grid(show = TRUE) %>%
  bb_y_axis(
    tick = list(format = suffix("TWh")),
    label = list(text = "production (in terawatt-hours)", position = "outer-top")
  ) %>% 
  bb_legend(show = FALSE) %>% 
  bb_labs(
    title = "French hydraulic production",
    caption = "Data source: RTE (https://opendata.reseaux-energies.fr/)"
  )

## ----barchart-dodge-----------------------------------------------------------
library(billboarder)

# data
data("prod_par_filiere")

billboarder() %>%
  bb_barchart(
    data = prod_par_filiere[, c("annee", "prod_hydraulique", "prod_eolien", "prod_solaire")]
  ) %>%
  bb_data(
    names = list(prod_hydraulique = "Hydraulic", prod_eolien = "Wind", prod_solaire = "Solar")
  ) %>% 
  bb_y_grid(show = TRUE) %>%
    bb_y_axis(
    tick = list(format = suffix("TWh")),
    label = list(text = "production (in terawatt-hours)", position = "outer-top")
  ) %>% 
  bb_legend(position = "inset", inset = list(anchor = "top-right")) %>% 
  bb_labs(
    title = "Renewable energy production",
    caption = "Data source: RTE (https://opendata.reseaux-energies.fr/)"
  )

## ----barchart-stacked---------------------------------------------------------
library(billboarder)

# data
data("prod_par_filiere")

# stacked bar chart !
billboarder() %>%
  bb_barchart(
    data = prod_par_filiere[, c("annee", "prod_hydraulique", "prod_eolien", "prod_solaire")], 
    stacked = TRUE
  ) %>%
  bb_data(
    names = list(prod_hydraulique = "Hydraulic", prod_eolien = "Wind", prod_solaire = "Solar"), 
    labels = TRUE
  ) %>% 
  bb_colors_manual(
    "prod_eolien" = "#41AB5D", "prod_hydraulique" = "#4292C6", "prod_solaire" = "#FEB24C"
  ) %>%
  bb_y_grid(show = TRUE) %>%
    bb_y_axis(
    tick = list(format = suffix("TWh")),
    label = list(text = "production (in terawatt-hours)", position = "outer-top")
  ) %>% 
  bb_legend(position = "inset", inset = list(anchor = "top-right")) %>% 
  bb_labs(
    title = "Renewable energy production",
    caption = "Data source: RTE (https://opendata.reseaux-energies.fr/)"
  )

## ----scatter------------------------------------------------------------------
billboarder() %>% 
 bb_scatterplot(
   data = mtcars, 
   x = "wt", y = "mpg", group = "cyl",
   point_opacity = 1
 ) %>% 
  # don't display all values on x-axis
 bb_axis(x = list(tick = list(fit = FALSE))) %>% 
 bb_point(r = 5) %>% 
  # add grids
  bb_x_grid(show = TRUE) %>%
  bb_y_grid(show = TRUE)

## ----scatter-bubble-----------------------------------------------------------
billboarder(data = mtcars) %>% 
  bb_scatterplot(
   mapping = aes(wt, mpg, group = cyl, size = scales::rescale(qsec, to = c(0.2, 7))),
   point_opacity = 1
  ) %>% 
  bb_axis(x = list(tick = list(fit = FALSE))) %>% 
  bb_x_grid(show = TRUE) %>%
  bb_y_grid(show = TRUE)

## ----pie----------------------------------------------------------------------
library(billboarder)

# data
data("prod_par_filiere")
nuclear2016 <- data.frame(
  sources = c("Nuclear", "Other"),
  production = c(
    prod_par_filiere$prod_nucleaire[prod_par_filiere$annee == "2016"],
    prod_par_filiere$prod_total[prod_par_filiere$annee == "2016"] -
      prod_par_filiere$prod_nucleaire[prod_par_filiere$annee == "2016"]
  )
)

# pie chart !
billboarder() %>% 
  bb_piechart(data = nuclear2016) %>% 
  bb_labs(
    title = "Share of nuclear power in France in 2016",
    caption = "Data source: RTE (https://opendata.reseaux-energies.fr/)"
  )

## ----donut--------------------------------------------------------------------
billboarder() %>% 
  bb_donutchart(data = nuclear2016) %>% 
  bb_donut(
    title = "Share of nuclear\nin France",
    label = list(
      format = JS("function(value, ratio, id) {	return id + ': ' + d3.format('.0%')(ratio);}")
    )
  ) %>% 
  bb_legend(show = FALSE) %>% 
  bb_labs(caption = "Data source: RTE (https://opendata.reseaux-energies.fr/)")

## ----lines-date---------------------------------------------------------------
library(billboarder)

# data
data("equilibre_mensuel")

# line chart
billboarder() %>% 
  bb_linechart(
    data = equilibre_mensuel[, c("date", "consommation", "production")], 
    type = "spline"
  ) %>% 
  bb_x_axis(tick = list(format = "%Y-%m", fit = FALSE)) %>% 
  bb_x_grid(show = TRUE) %>% 
  bb_y_grid(show = TRUE) %>% 
  bb_colors_manual("consommation" = "firebrick", "production" = "forestgreen") %>% 
  bb_legend(position = "right") %>% 
  bb_subchart(show = TRUE, size = list(height = 30)) %>% 
  bb_labs(
    title = "Monthly electricity consumption and production in France (2007 - 2017)",
    y = "In megawatt (MW)",
    caption = "Data source: RTE (https://opendata.reseaux-energies.fr/)"
  )

## ----lines-zoom1--------------------------------------------------------------
billboarder() %>% 
  bb_linechart(
    data = equilibre_mensuel[, c("date", "consommation", "production")], 
    type = "spline"
  ) %>% 
  bb_x_axis(tick = list(format = "%Y-%m", fit = FALSE)) %>% 
  bb_x_grid(show = TRUE) %>% 
  bb_y_grid(show = TRUE) %>% 
  bb_colors_manual("consommation" = "firebrick", "production" = "forestgreen") %>% 
  bb_legend(position = "right") %>% 
  bb_zoom(
    enabled = TRUE,
    type = "drag",
    resetButton = list(text = "Unzoom")
  ) %>% 
  bb_labs(
    title = "Monthly electricity consumption and production in France (2007 - 2017)",
    y = "In megawatt (MW)",
    caption = "Data source: RTE (https://opendata.reseaux-energies.fr/)"
  )

## ----lines-time---------------------------------------------------------------
library(billboarder)

# data
data("cdc_prod_filiere")

# Retrieve sunrise and and sunset data with `suncalc`
# library("suncalc")
# sun <- getSunlightTimes(date = as.Date("2017-06-12"), lat = 48.86, lon = 2.34, tz = "CET")
sun <- data.frame(
  sunrise = as.POSIXct("2017-06-12 05:48:14"),
  sunset = as.POSIXct("2017-06-12 21:55:32")
)


# line chart
billboarder() %>% 
  bb_linechart(
    data = cdc_prod_filiere,
    mapping = aes(date_heure, prod_solaire)
  ) %>% 
  bb_x_axis(tick = list(format = "%H:%M", fit = FALSE)) %>% 
  bb_y_axis(min = 0, padding = 0) %>% 
  bb_regions(
    list(
      start = as.numeric(cdc_prod_filiere$date_heure[1]) * 1000,
      end = as.numeric(sun$sunrise)*1000
    ), 
    list(
      start = as.numeric(sun$sunset) * 1000, 
      end = as.numeric(cdc_prod_filiere$date_heure[48]) * 1000
    )
  ) %>% 
  bb_x_grid(
    lines = list(
      list(value = as.numeric(sun$sunrise)*1000, text = "sunrise"),
      list(value = as.numeric(sun$sunset)*1000, text = "sunset")
    )
  ) %>% 
  bb_labs(
    title = "Solar production (2017-06-12)",
    y = "In megawatt (MW)",
    caption = "Data source: RTE (https://opendata.reseaux-energies.fr/)"
  )

## ----area-stacked-------------------------------------------------------------
library(billboarder)

# data
data("cdc_prod_filiere")

billboarder() %>% 
  bb_linechart(
    data = cdc_prod_filiere[, c("date_heure", "prod_eolien", "prod_hydraulique", "prod_solaire")], 
    type = "area"
  ) %>% 
  bb_data(
    groups = list(list("prod_eolien", "prod_hydraulique", "prod_solaire")),
    names = list("prod_eolien" = "Wind", "prod_hydraulique" = "Hydraulic", "prod_solaire" = "Solar")
  ) %>% 
  bb_legend(position = "inset", inset = list(anchor = "top-right")) %>% 
  bb_colors_manual(
    "prod_eolien" = "#238443", "prod_hydraulique" = "#225EA8", "prod_solaire" = "#FEB24C", 
    opacity = 0.8
  ) %>% 
  bb_y_axis(min = 0, padding = 0) %>% 
  bb_labs(
    title = "Renewable energy production (2017-06-12)",
    y = "In megawatt (MW)",
    caption = "Data source: RTE (https://opendata.reseaux-energies.fr/)"
  )

## ----lines-range--------------------------------------------------------------
# Generate data
dat <- data.frame(
  date = seq.Date(Sys.Date(), length.out = 20, by = "day"),
  y1 = round(rnorm(20, 100, 15)),
  y2 = round(rnorm(20, 100, 15))
)
dat$ymin1 <- dat$y1 - 5
dat$ymax1 <- dat$y1 + 5

dat$ymin2 <- dat$y2 - sample(3:15, 20, TRUE)
dat$ymax2 <- dat$y2 + sample(3:15, 20, TRUE)


# Make chart : use ymin & ymax aes for range
billboarder(data = dat) %>% 
  bb_linechart(
    mapping = aes(x = date, y = y1, ymin = ymin1, ymax = ymax1),
    type = "area-line-range"
  ) %>% 
  bb_linechart(
    mapping = aes(x = date, y = y2, ymin = ymin2, ymax = ymax2), 
    type = "area-spline-range"
  ) %>% 
  bb_y_axis(min = 50)

## ----histo--------------------------------------------------------------------
billboarder() %>%
  bb_histogram(data = rnorm(1e5), binwidth = 0.25) %>%
  bb_colors_manual()

## ----histo-group--------------------------------------------------------------
# Generate some data
dat <- data.frame(
  sample = c(rnorm(n = 1e4, mean = 1), rnorm(n = 1e4, mean = 2)),
  group = rep(c("A", "B"), each = 1e4), stringsAsFactors = FALSE
)
# Mean by groups
samples_mean <- tapply(dat$sample, dat$group, mean)
# histogram !
billboarder() %>%
  bb_histogram(data = dat, x = "sample", group = "group", binwidth = 0.25) %>%
  bb_x_grid(
    lines = list(
      list(value = unname(samples_mean['A']), text = "mean of sample A"),
      list(value = unname(samples_mean['B']), text = "mean of sample B")
    )
  )

## ----density-group------------------------------------------------------------
billboarder() %>%
  bb_densityplot(data = dat, x = "sample", group = "group") %>%
  bb_x_grid(
    lines = list(
      list(value = unname(samples_mean['A']), text = "mean of sample A"),
      list(value = unname(samples_mean['B']), text = "mean of sample B")
    )
  )

## ----radar-single-------------------------------------------------------------
data("avengers_wide")
billboarder() %>%
  bb_radarchart(
    data = avengers_wide[, 1:2]
  )

## ----radar-multiple-----------------------------------------------------------
data("avengers")
billboarder() %>%
  bb_radarchart(
    data = avengers, 
    mapping = bbaes(x = axis, y = value, group = group)
  )

## ----gauge-1------------------------------------------------------------------
billboarder() %>% 
  bb_gaugechart(value = 50, color = "#112446")

## ----gauge-2------------------------------------------------------------------
bauge(round(sample.int(100, 1)), subtitle = "of total")

## ----gauge-multiple-----------------------------------------------------------
billboarder() %>%
  bb_gaugechart(
    value = c(15, 30),
    name = c("A", "B"),
    color = c("steelblue", "firebrick")
  ) %>% 
  bb_gauge(max = 60) %>% 
  bb_data(
    labels = list(colors = "#FFF")
  )

## ----treemap-1----------------------------------------------------------------
data("mpg", package = "ggplot2")
billboarder() %>% 
  bb_treemapchart(
    data = table(manufacturer = mpg$manufacturer), 
    mapping = aes(x = manufacturer, y = Freq),
    label = list(show = TRUE, threshold = 0.03),
    tile = "binary" # or "slice" or "dice"
  ) %>% 
  bb_data(
    labels = list(colors = "#FFF")
  ) %>% 
  bb_color(
    palette = colorRampPalette(c("#08519C", "#9ECAE1"))(15) #15 = n manufacturer
  )

