##############################################################################
# Copyright (C) 2024                                                         #
#                                                                            #
# CC BY-NC-SA 4.0                                                            #
#                                                                            #
# Canonical URL https://creativecommons.org/licenses/by-nc-sa/4.0/           #
# Attribution-NonCommercial-ShareAlike 4.0 International CC BY-NC-SA 4.0     #
#                                                                            #
# Prof. Elaine Cecilia Gatto | Prof. Ricardo Cerri | Prof. Mauri Ferrandin   #
#                                                                            #
# Federal University of São Carlos - UFSCar - https://www2.ufscar.br         #
# Campus São Carlos - Computer Department - DC - https://site.dc.ufscar.br   #
# Post Graduate Program in Computer Science - PPGCC                          # 
# http://ppgcc.dc.ufscar.br - Bioinformatics and Machine Learning Group      #
# BIOMAL - http://www.biomal.ufscar.br                                       #
#                                                                            #
# You are free to:                                                           #
#     Share — copy and redistribute the material in any medium or format     #
#     Adapt — remix, transform, and build upon the material                  #
#     The licensor cannot revoke these freedoms as long as you follow the    #
#       license terms.                                                       #
#                                                                            #
# Under the following terms:                                                 #
#   Attribution — You must give appropriate credit, provide a link to the    #
#     license, and indicate if changes were made. You may do so in any       #
#     reasonable manner, but not in any way that suggests the licensor       #
#     endorses you or your use.                                              #
#   NonCommercial — You may not use the material for commercial purposes     #
#   ShareAlike — If you remix, transform, or build upon the material, you    #
#     must distribute your contributions under the same license as the       #
#     original.                                                              #
#   No additional restrictions — You may not apply legal terms or            #
#     technological measures that legally restrict others from doing         #
#     anything the license permits.                                          #
#                                                                            #
##############################################################################


# Clear the workspace
rm(list = ls())

##############################################################################
# Define Folder Paths
##############################################################################  
FolderRoot <- "~/MultiLabelWilcoxon"
FolderScripts <- "~/MultiLabelWilcoxon/R"
FolderData <- "~/MultiLabelWilcoxon/data"      
FolderResults <- "~/MultiLabelWilcoxon/results"


##############################################################################
# Load Required Libraries
##############################################################################

# Load any required libraries
library(pairComparison)  # Uncomment if you need this library

# Set working directory to the scripts folder and source required scripts
# setwd(FolderScripts)
# source("libraries.R")  # Source library dependencies
# source("utils.R")      # Source utility functions
#source("wilcoxon.R")   # Source Wilcoxon test functions


##############################################################################
# Compute Wilcoxon Test for a Single CSV File
##############################################################################

# Define the file path for a single CSV file
filename <- "C:/Users/Cissa/Documents/MultiLabelWilcoxon/data/accuracy.csv"

# Read the CSV file into a data frame
df <- data.frame(read.csv(filename))

# Rename the first column to "Dataset"
names(df)[1] <- "Dataset"

# Perform the Wilcoxon test and save results
res <- wilcoxon(data = df,
                measure.name = "accuracy",
                folder.path = FolderResults)


##############################################################################
# Compute Wilcoxon Test for Multiple CSV Files
##############################################################################

# Set working directory to the data folder
setwd(FolderData)

# Get the list of all CSV files in the directory
files <- list.files(full.names = TRUE)

# Normalize the file paths
full_paths <- sapply(files, function(file) normalizePath(file))

# Extract measure names from file paths (custom function)
measure_names <- extract_measure_names(full_paths)

# Loop through each file to perform the Wilcoxon test
for (i in seq_along(files)) {
  cat("\n\n==================================================================")
  cat("\n COMPUTING WILCOXON FOR: ", files[i], " - ", measure_names[i])
  
  # Read the current CSV file into a data frame
  data <- data.frame(read.csv(files[i]))
  
  # Rename the first column to "Dataset"
  names(data)[1] <- "Dataset"
  
  # Perform the Wilcoxon test and save results
  res <- wilcoxon(data = data, 
                  measure.name = measure_names[i],
                  folder.path = FolderResults)
  
  cat("\nDONE!")
}



