
# Load libraries ----------------------------------------------------

library(tidyverse)
library(readxl)

getROI <- function(x = .5, y = .5, whichtrial = "P13", coords = NA){
  coords <- coords %>% 
    filter(trial == whichtrial | trial == "door") %>% 
    select(trial, stimulus, animal, gp_topleftcorner_x:gp_bottomrightcorner_y)
  temp <- isInBox(x = x, y = y, x1 = coords$gp_topleftcorner_x, y1 = coords$gp_topleftcorner_y,
                  x2 = coords$gp_bottomrightcorner_x, y2 = coords$gp_bottomrightcorner_y)
  if(any(temp)){
    coords %>% filter(temp) %>% select(animal) %>% pull()
  } else{
    ""
  }
}

isInBox <- function(x = .5, y = .5, x1 = .5, y1 = .5, x2 = 1, y2 = 1){
  x >= x1 & x <= x2 & y >= y1 & y <= y2
}



# Example -----------------------------------------------

data_path <- '../Example'

example_file <- 'User 0_fixationsCAMILA.xlsx'
coords_file <- 'Coordenadas.xlsx'

data <- read_xlsx(file.path(data_path, example_file), skip = 1)
coords <- read_xlsx(file.path('../', coords_file))

data <- data %>% 
  mutate(ROI = getROI(x = BPOGX, y = BPOGY, whichtrial = ITEM, coords = coords), .by = FPOGID)

write.csv(data, file = file.path(data_path, "User 0_fixationsCAMILA_preprocessed.csv"),
          na = "", row.names = FALSE, fileEncoding = "UTF-16")


# Loop over folder -----------------------------------------------------------

data_path <- 'data/raw'
out_path <- 'data/preproc'

file_names <- dir(data_path)
coords_file <- 'Coordenadas.xlsx'
coords <- read_xlsx(file.path('data/', coords_file))

for(i in 1:length(file_names)){
  example_file <- file_names[i]
  data <- read_xlsx(file.path(data_path, example_file), skip = 1)
  
  data <- data %>% 
    mutate(ROI = getROI(x = BPOGX, y = BPOGY, whichtrial = ITEM, coords = coords), .by = FPOGID)
  
  write.csv(data, file = file.path(out_path, paste0(tools::file_path_sans_ext(file_names[i]), "_preprocessed.csv")),
            na = "", row.names = FALSE, fileEncoding = "UTF-16")
  
  data_roi <- data %>% drop_na(ITEM, FASE, ROI) %>% select(ITEM, FASE, ROI) %>% filter(ROI != "")
  write.csv(data_roi, file = file.path(out_path, paste0(tools::file_path_sans_ext(file_names[i]), "_preprocessed_ROI.csv")),
            na = "", row.names = FALSE, fileEncoding = "UTF-16")
}



