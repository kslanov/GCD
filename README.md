---
title: "Coursera. Getting and Cleaning Data Course project Readme"
author: "Konstantin Slanov"
date: "20 08 2020"
output: pdf_document
---




# This is the README file for course project of the Getting and Cleaning Data course on Coursera.

The project includes the R script (run_analysis.R), for the following data manipulation: 

>FILE PREPARATION

* Establishing working directory for the initial data set (unzipped files) 

> READING DATA

* Reading both the train and test datasets as data tables, reading features and activity labels 

> TRANSFORMING DATA

* Extracting columns named 'mean'(-mean) and 'standard'(-std) and modifying column names to descriptive. (-mean to Mean, -std to Std, and remove non-char symbols like -, (, )) 

*  Merging train and test data set into x(measurements), y(activity) and subject.


* Extracting data by selected columns(from step 1), and merging x, y(activity) and subject data. Also, replace y(activity) column to it's name by referring activity label (loaded step 3). \newline

* Generating a 'Tidy Dataset' that consists of the average (mean) of each variable for each subject and each activity. Writing the tidy dataset to tidy_dataset.txt file 




