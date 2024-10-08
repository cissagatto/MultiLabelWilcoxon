% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wilcoxon.R
\name{wilcoxon.plot}
\alias{wilcoxon.plot}
\title{Wilcoxon Plot Function}
\usage{
wilcoxon.plot(data, measure.name, folder.path)
}
\arguments{
\item{data}{A data frame where the first column is an identifier and the 
following columns represent the methods to be compared. The data frame should 
contain at least two columns for comparison.}

\item{measure.name}{A string representing the name of the measure to be used 
in the plot filenames. This will be included in the filenames of the saved plots.}

\item{folder.path}{A string representing the path to the folder where the 
plots will be saved. The folder must exist before running the function.}
}
\value{
This function does not return a value. It saves the generated plots 
as PDF files in the specified folder.
}
\description{
This function generates two types of plots for comparing methods using 
Wilcoxon test statistics.

The first plot is a boxplot that visualizes the distribution of the methods' 
performance. The second plot is a paired samples plot that illustrates 
the differences between the paired samples using the Wilcoxon test.

The plots are saved as PDF files in the specified folder. The filenames 
include the provided measure name for identification.
}
\examples{
# Example usage:
# Suppose 'my_data' is a data frame with the first column as an identifier 
# and the next two columns representing the methods to compare.
# The plots will be saved in the '/plots' directory with 'accuracy' as the measure name.
wilcoxon.plot(data = my_data, measure.name = "accuracy", folder.path = "/plots")

}
