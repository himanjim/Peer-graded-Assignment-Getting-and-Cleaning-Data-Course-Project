# Peer-graded Assignment: Getting and Cleaning Data Course Project

This is the assigment for the Getting and Cleaning Data Coursera course.

Below is the explanation of `run_analysis.R` R script:

1. Check if package exist `shape2` exists.
2. Load the package `shape2`.
3. Download and unzip the data if it doesn't exist into working directory.
4. Load activity labels.
5. Load features.
6. Get only mean and standard deviation data from features.
7. Clean the features data.
8. Load and merge various train datasets.
9. Load and merge various test datasets.
10. Merge train and test datasets and add labels.
11. Factorise activities & subjects in above combined data.
12. First melt the data then calculate mean of the above combined data.
13. Write the tidy dataset.

The final dataset is `tidy.txt`.
