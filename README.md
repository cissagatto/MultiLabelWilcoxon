# Wilcoxon Test Suite

## Overview

The Wilcoxon Test Suite is a comprehensive set of R scripts designed for conducting non-parametric Wilcoxon tests across multiple datasets. This suite is particularly useful for comparing two groups when the assumption of normality is violated. It includes functionality to handle single and multiple CSV files, providing results and visualizations in a structured manner.

## How to cite

```plaintext
@misc{MultiLabelWilcoxon2024,
  author = {Elaine Cecília Gatto},
  title = {MultiLabelWilcoxon: A package to performing wilcoxon between many methods},  
  year = {2024},
  note = {R package version 0.1.0. Licensed under CC BY-NC-SA 4.0},
  doi = {},
  url = {https://github.com/cissagatto/MultiLabelWilcoxon}
}
```


### Comparing Two Groups Using the Wilcoxon Test

When the assumption of normality is violated, the Wilcoxon test is an effective method for comparing two groups. As a non-parametric test, it does not rely on the data conforming to any specific parametric family of probability distributions. Non-parametric tests share the same goals as their parametric counterparts but offer two key advantages: they do not require the assumption of normal distribution, and they are more robust to outliers. However, non-parametric tests are typically less powerful than parametric tests when the normality assumption is met. As a result, when the data follow a normal distribution, non-parametric tests are less likely to reject the null hypothesis when it is false.

### Independent Samples

1. **Mann-Whitney-Wilcoxon Test**: Also known as the Wilcoxon rank-sum test or the Mann-Whitney U test, this test is used for comparing two independent samples. It is the non-parametric equivalent of the Student’s t-test for independent samples.

2. **Wilcoxon Signed-Rank Test**: This test is applied when comparing two paired or dependent samples. It serves as the non-parametric equivalent of the Student’s t-test for paired samples.

### Hypotheses of the Wilcoxon Test

The null and alternative hypotheses for the Wilcoxon test are as follows:

- **H0**: The two methods are equal in terms of the variable of interest.
- **H1**: The two methods differ in terms of the variable of interest.


### Interpreting the Results

The p-value (displayed after "p =" in the plot subtitle) indicates whether we reject the null hypothesis. In this case, with a p-value of 0.17, we do not reject the null hypothesis, suggesting that [?] are not significantly different.

*Note*: A small p-value (typically less than 0.05) suggests that there is sufficient evidence to reject the null hypothesis.


## Functionality

### Main Features

1. **Single File Analysis**: Compute Wilcoxon tests for a single CSV file and save results to the specified directory.
2. **Batch File Analysis**: Perform Wilcoxon tests for multiple CSV files within a directory and generate results for each file.

### CSV Example

| Dataset  | Model_1 | Model_2 | .... | Model_N |
| -------  | ------- | ------- | ---- |-------- |
| Dataset1 |         |         |      |         |
| Dataset2 |         |         |      |         |
| ........ |         |         |      |         |
| DatasetD |         |         |      |         |


**Mandatory: Rename the first column of the dataframe to "Dataset". This is crucial because the code assumes the first column is named "Dataset" for proper functioning.**


### Code Structure

- **`wilcoxon.R`**: Contains the core functions for performing the Wilcoxon test and plotting results.
- **`utils.R`**: Includes utility functions used throughout the scripts.
- **`libraries.R`**: Sources additional libraries required for the analysis.


## How It Works

### For a Single CSV File

1. Define the path to a single CSV file.
2. Read the CSV file into a data frame and rename the first column to "Dataset". If you don't rename, there will be a problem! This is 
3. Perform the Wilcoxon test using the `wilcoxon` function.
4. Save the results in the specified results directory.

### For Multiple CSV Files

1. Set the working directory to the folder containing the CSV files.
2. List and normalize paths for all CSV files.
3. Extract measure names from file paths.
4. Loop through each file, perform the Wilcoxon test, and save results.



### Progress Tracking

- A progress bar is included to provide real-time updates on the analysis status, especially useful for batch processing.


### Folder Structure

Ensure the following folder structure is set up:

- `FolderRoot`: Root directory of the project.
- `FolderData`: Directory where CSV data files are stored.
- `FolderResults`: Directory where results and plots are saved.


### Documentation

For more detailed documentation on each function, check out the `~/MultiLabelWilcoxon/docs`folder

A complete example is available in `~/MultiLabelWilcoxon/example` folder



## Instalation


```r
# install.packages("devtools")
library("devtools")
devtools::install_github("https://github.com/cissagatto/MultiLabelWilcoxon")
library(MultiLabelWilcoxon)
```

### Example for one single csv file

```r
library(MultiLabelWilcoxon)
FolderResults <- "path/to/your/results"
filename <- "path/to/your/accuracy.csv"
df <- data.frame(read.csv(filename))
names(df)[1] <- "Dataset"
res <- wilcoxon(data = df, measure.name = "accuracy", folder.path = FolderResults)
```


### Example for many csv files

```r
library(MultiLabelWilcoxon)
FolderResults <- "path/to/your/results"
setwd(FolderData)
files <- list.files(full.names = TRUE)
measure_names <- extract_measure_names(files)
for (i in seq_along(files)) {
  data <- data.frame(read.csv(files[i]))
  names(data)[1] <- "Dataset"
  res <- wilcoxon(data = data, measure.name = measure_names[i], folder.path = FolderResults)
}
```




## 📚 **Contributing**

We welcome contributions from the community! If you have suggestions, improvements, or bug fixes, please submit a pull request or open an issue in the GitHub repository.



## Acknowledgment
- This study was financed in part by the Coordenação de Aperfeiçoamento de Pessoal de Nível Superior - Brasil (CAPES) - Finance Code 001.
- This study was financed in part by the Conselho Nacional de Desenvolvimento Científico e Tecnológico - Brasil (CNPQ) - Process number 200371/2022-3.
- The authors also thank the Brazilian research agencies FAPESP financial support.

## 📧 **Contact**

For any questions or support, please contact:
- **Prof. Elaine Cecilia Gatto** (elainececiliagatto@gmail.com)
  

# Links

| [Site](https://sites.google.com/view/professor-cissa-gatto) | [Post-Graduate Program in Computer Science](http://ppgcc.dc.ufscar.br/pt-br) | [Computer Department](https://site.dc.ufscar.br/) |  [Biomal](http://www.biomal.ufscar.br/) | [CNPQ](https://www.gov.br/cnpq/pt-br) | [Ku Leuven](https://kulak.kuleuven.be/) | [Embarcados](https://www.embarcados.com.br/author/cissa/) | [Read Prensa](https://prensa.li/@cissa.gatto/) | [Linkedin Company](https://www.linkedin.com/company/27241216) | [Linkedin Profile](https://www.linkedin.com/in/elainececiliagatto/) | [Instagram](https://www.instagram.com/cissagatto) | [Facebook](https://www.facebook.com/cissagatto) | [Twitter](https://twitter.com/cissagatto) | [Twitch](https://www.twitch.tv/cissagatto) | [Youtube](https://www.youtube.com/CissaGatto) |
