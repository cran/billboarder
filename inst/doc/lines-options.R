## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(billboarder)

## -----------------------------------------------------------------------------
# wide format
wide <- data.frame(
  index = seq_len(100),
  Sine = sin(1:100/10),
  Cosine = 0.5 * cos(1:100/10),
  Sine2 = sin(1:100/10) * 0.25 + 0.5
)
# long format (to use with mapping)
long <- reshape(
  data = wide, 
  times = c("Sine", "Cosine", "Sine2"),
  varying = list(2:4), 
  idvar = "index", 
  direction = "long", 
  v.names = "value"
)

## -----------------------------------------------------------------------------
billboarder(height = "200px") %>% 
  bb_linechart(data = wide, type = "spline")

## -----------------------------------------------------------------------------
billboarder(height = "200px") %>% 
  bb_linechart(data = wide, type = "step")

## -----------------------------------------------------------------------------
billboarder(height = "200px") %>% 
  bb_linechart(data = wide, type = "area")

## -----------------------------------------------------------------------------
billboarder() %>% 
  bb_linechart(data = wide, type = c("area", "spline", "step"))

## -----------------------------------------------------------------------------
billboarder() %>% 
  bb_linechart(
    data = long, 
    mapping = bbaes(index, value, group = time),
    type = c("area", "spline", "step")
  )

## -----------------------------------------------------------------------------
billboarder() %>% 
  bb_linechart(data = wide, dasharray = 4)

## -----------------------------------------------------------------------------
billboarder() %>% 
  bb_linechart(data = wide, dasharray = "6 2 1 2")

## -----------------------------------------------------------------------------
billboarder() %>% 
  bb_linechart(data = wide, dasharray = c("0", "4 2", "8 3 2 3"))

## -----------------------------------------------------------------------------
billboarder() %>% 
  bb_linechart(
    data = long, 
    mapping = bbaes(index, value, group = time),
    dasharray = c("2", "4 2", "8 3 2 3")
  )

## -----------------------------------------------------------------------------
billboarder() %>% 
  bb_linechart(data = wide, width = 3)

## -----------------------------------------------------------------------------
billboarder() %>% 
  bb_linechart(data = wide, width = c(1, 4, 8))

## -----------------------------------------------------------------------------
billboarder() %>% 
  bb_linechart(
    data = long, 
    mapping = bbaes(index, value, group = time),
    width = c(1, 4, 8)
  )

## -----------------------------------------------------------------------------
billboarder() %>% 
  bb_linechart(
    data = long, 
    mapping = bbaes(index, value, group = time),
    dasharray = c("2", "4 2", "8 3 2 3"),
    width = c(1, 4, 8)
  )

