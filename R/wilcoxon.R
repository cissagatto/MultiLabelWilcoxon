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
#   Attribution — You must give appropriate credit , provide a link to the   #
#     license, and indicate if changes were made . You may do so in any      #
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



##############################################################################
# WORKSPACE
##############################################################################
FolderRoot <- "~/MultiLabelWilcoxon"
FolderScripts <- "~/MultiLabelWilcoxon/R"


#' @title Wilcoxon Plot Function
#' @description
#' This function generates two types of plots for comparing methods using 
#' Wilcoxon test statistics.
#'
#' The first plot is a boxplot that visualizes the distribution of the methods' 
#' performance. The second plot is a paired samples plot that illustrates 
#' the differences between the paired samples using the Wilcoxon test.
#'
#' The plots are saved as PDF files in the specified folder. The filenames 
#' include the provided measure name for identification.
#'
#' @param data A data frame where the first column is an identifier and the 
#' following columns represent the methods to be compared. The data frame should 
#' contain at least two columns for comparison.
#' @param measure.name A string representing the name of the measure to be used 
#' in the plot filenames. This will be included in the filenames of the saved plots.
#' @param folder.path A string representing the path to the folder where the 
#' plots will be saved. The folder must exist before running the function.
#'
#' @return This function does not return a value. It saves the generated plots 
#' as PDF files in the specified folder.
#'
#' @examples
#' # Example usage:
#' # Suppose 'my_data' is a data frame with the first column as an identifier 
#' # and the next two columns representing the methods to compare.
#' # The plots will be saved in the '/plots' directory with 'accuracy' as the measure name.
#' wilcoxon.plot(data = my_data, measure.name = "accuracy", folder.path = "/plots")
#'
#' @export
wilcoxon.plot <- function(data, measure.name, folder.path){
  
  # Remove the first column of the data (assumed to be an identifier)
  df <- data[,-1]
  
  # Convert the data from wide to long format for easier plotting
  df <- data.frame(pivot_longer(df, cols = 1:2))
  
  # Sort the data by the 'value' column in decreasing order
  df <- df[order(df$value, decreasing = TRUE), ]
  
  # Rename the columns to 'Methods' and 'Performance'
  colnames(df) <- c("Methods", "Performance")
  
  # Create the first plot (boxplot) and save as a PDF
  file.name.1 <- paste(folder.path, "/", measure.name, "-plot.1.pdf", sep = "")
  pdf(file.name.1, width = 15, height = 10)
  print(ggplot(df) +
          aes(x = Methods, y = Performance) +
          geom_boxplot(fill = "#dfbc64") +
          theme_minimal() +
          theme(text = element_text(size = 20)))
  dev.off()
  
  # Create the second plot (paired samples plot using Wilcoxon test) and save as a PDF
  file.name.2 <- paste(folder.path, "/", measure.name, "-plot.2.pdf", sep = "")
  pdf(file.name.2, width = 15, height = 10)
  print(ggwithinstats( # Paired samples plot
    data = df, x = Methods, y = Performance,
    type = "nonparametric", # Wilcoxon test
    centrality.plotting = FALSE # Remove median line
  ) + theme(text = element_text(size = 20)))
  dev.off()
  
}





#' @title Wilcoxon Test and Plotting Function
#' @description
#' This function performs a paired Wilcoxon test on two columns of a data frame, 
#' saves the results to a text file, and generates plots to visualize the results.
#'
#' The Wilcoxon test is a non-parametric statistical test used to compare two paired samples. 
#' This function computes the test and provides a summary of the results, including 
#' the number of zero differences, the test statistic, and the p-value. 
#' It also generates plots to help visualize the distribution and results of the test.
#'
#' @param data A data frame where the first column is an identifier and the following 
#' columns represent the two groups to be compared. The two columns for comparison should be 
#' in the second and third positions.
#' @param measure.name A string representing the name of the measure, used for naming 
#' output files.
#' @param folder.path A string representing the path to the folder where output files 
#' will be saved.
#'
#' @return A data frame containing the following columns:
#' \item{zeros}{Number of zero differences between the two columns.}
#' \item{statistic}{The test statistic from the Wilcoxon test.}
#' \item{parameter}{The parameter used in the Wilcoxon test.}
#' \item{p.value}{The p-value from the Wilcoxon test.}
#' \item{location.shift}{The location shift parameter used in the Wilcoxon test.}
#' \item{alternative}{The alternative hypothesis used in the Wilcoxon test.}
#' \item{method}{The method used for the Wilcoxon test.}
#'
#' @examples
#' # Example usage:
#' # Suppose 'my_data' is a data frame with columns 'Identifier', 'Group1', and 'Group2'.
#' # The first column should be named 'Identifier' and the columns to be compared should be 
#' # the second and third columns.
#' result <- wilcoxon.compute(data = my_data, measure.name = "accuracy", folder.path = "/results")
#'
#' @export
wilcoxon.compute <- function(data, measure.name, folder.path){
  
  # Perform the paired Wilcoxon test between the two columns
  result <- wilcox.test(data[,2], data[,3], paired = TRUE, exact = FALSE)
  
  # Calculate the differences between the two columns
  differences <- data[,2] - data[,3]
  
  # Count the number of zero differences
  num_zeros <- sum(differences == 0)
  
  # Save the test results to a text file
  file_path <- paste(folder.path, "/", measure.name, ".txt", sep="")
  sink(file_path)
  print(result)
  sink()
  
  # Generate plots using the wilcoxon.plot function
  wilcoxon.plot(data, measure.name, folder.path)
  
  # Extract relevant information from the test result
  statistic <- as.numeric(result$statistic)
  parameter <- toString(result$parameter)
  p.value <- as.numeric(result$p.value)
  location_shift <- as.numeric(result$null.value)
  alternative <- toString(result$alternative)
  method <- toString(result$method)
  
  # Combine the results into a data frame
  result_df <- data.frame(zeros = num_zeros, statistic, parameter, p.value, 
                          location_shift, alternative, method)
  
  return(result_df)
}





#' @title Wilcoxon Test for Multiple Column Pairs
#' @description This function performs Wilcoxon tests on all possible pairs of columns from a data frame, 
#' saves the results and plots for each pair, and generates a summary CSV file of the test results.
#' @param data A data frame where the first column is an identifier and the following columns represent the groups to be compared.
#' @param measure.name A string representing the name of the measure, used for naming output files.
#' @param folder.path A string representing the path to the folder where output files will be saved.
#' @return A list containing the results of the Wilcoxon tests, with a summary CSV file saved in the specified folder.
#' @examples
#' # Example usage:
#' # Suppose 'my_data' is a data frame with columns 'Dataset', 'Group1', and 'Group2'.
#' # The first column should be named 'Dataset'.
#' result <- wilcoxon(data = my_data, measure.name = "accuracy", folder.path = "/results")
#' @export
wilcoxon <- function(data, measure.name, folder.path){
  
  retorno = list()
  
  # Generate all possible combinations of columns (excluding the first column)
  column_combinations <- combn(names(data)[-1], 2, simplify = FALSE)
  
  # Create data frames for each combination of columns
  data_frames_list <- lapply(column_combinations, function(cols) {
    new_dataframe <- data[c("Dataset", cols)]
    return(new_dataframe)
  })
  
  # Name the data frames in the list
  data_frame_names <- sapply(column_combinations, function(cols) {
    name <- paste("", cols[1], "_", cols[2], sep = "")
    return(name)
  })
  
  # Assign names to the data frames in the list
  names(data_frames_list) <- data_frame_names
  
  # Create directory for saving results if it does not exist
  save_directory <- paste(folder.path, "/", measure.name, sep="")
  if(dir.exists(save_directory) == FALSE) { dir.create(save_directory) }
  
  results_list = list()
  
  # Initialize the progress bar
  pb <- txtProgressBar(min = 1, max = length(data_frames_list), style = 3)
  
  for(i in 1:length(data_frames_list)){
    
    column_names <- colnames(data_frames_list[[i]])
    save_name = paste(column_names[2], "-", column_names[3], sep="")
    df_list = data.frame(data_frames_list[[i]])
    colnames(df_list) = column_names
    
    # Perform the Wilcoxon test
    results_list[[i]] = wilcoxon.compute(data = df_list, 
                                         measure.name = save_name, 
                                         folder.path = save_directory)
    
    # Update the progress bar
    setTxtProgressBar(pb, i)
  }
  
  # Close the progress bar
  close(pb)
  
  # Name the results list
  names(results_list) <- data_frame_names
  
  # Combine all results into a single data frame
  combined_results <- do.call(rbind, results_list)
  
  # Determine if the methods are different based on the p-value
  result_status = ifelse(combined_results$p.value < 0.05, "methods are different", "methods are not different")
  combined_results = cbind(combined_results, result_status)
  
  # Save the results to a CSV file
  results_file_path = paste(save_directory, "/results.csv", sep="")
  write.csv2(combined_results, results_file_path)
  
  retorno$results = combined_results
  return(retorno)
}






