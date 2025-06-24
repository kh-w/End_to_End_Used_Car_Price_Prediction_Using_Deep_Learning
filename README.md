- [Introduction](#introduction)
- [Dataset](#dataset)
  - [Data_Cleaning](#data_cleaning)
  - [Data_Visualization](#data_visualization)
  - [Data_Preprocessing](#data_preprocessing)

# Introduction

The goal of this project was to estimate used car prices under $20,000.

In this project, I did:
- Web scaping using Python on cars.com using gentle methods, i.e. web scrape slowly to avoid sudden traffic for the website. The dataset obtained is solely for academic purposes.
- Performed data cleaning including remove blank rows, typo fixing and data pre-processing including create color tunes as a bigger grouping for exterior/interior colors, create word embedding for categorical variables with large number of categories.
- Visualized the dataset.
- Built and fine-tuned deep neural network to price used cars.

# Dataset

Disclaimer: Although the data used was publicly available, it is prohibited to use the dataset for any business purposes. Therefore, the data used in this project was solely for academic and research purposes, it did not, will not and should not be used in any businesses.

This project focused on used car pricing below $20,000 offering. Since I am web scrapping, the size of the dataset should be limited. The brands were limited to Toyota, Honda, Mitsubishi, Nissan, Maxda and Subaru, and the area I used is 500 miles from 60126 zipcode. The data I collected from each car are: ["make", "year", "trim", "model", "stock_type", "fuel_type", "bodystyle", "photo_count", "exterior_color", "interior_color", "drivetrain", "fuel_type", "transmission", "engine", "mileage", "accidents_or_damage", "clean_title", "one_owner_vehicle", "personal_use_only", "open_recall", "comfort_rating", "interior_rating", "performance_rating", "value_rating", "exterior_rating", "reliability_rating", "price"], where "price" is the target variables. 

The data was raw, i.e. include blank rows, missing values, granular categories, spelling differences of the same category, etc, such that data cleaning and preprocessing are needed. 

After data cleaning, the dataset contains 25 predictors across 30,195 car listings:
![image](https://github.com/user-attachments/assets/30781b46-f840-42d1-878f-4053f81dff88)

## Data_Cleaning

The dataset was compiled gradually over several days using a gentle scraping method, which led to the presence of some blank rows as certain car listings were removed during the process. Additionally, some listings contained missing values, for example: certain ratings were occasionally unavailable. To address this, we searched for other listings in the dataset of the same model to fill in the missing data; if no matching records were found, the missing values were filled using average ratings. Inconsistent naming across categorical variables (e.g., "AWD" vs. "All-Wheel-Drive") was resolved through manual standardization. Missing values in categorical features were replaced with a default category such as "Unknown". During this step, some granular categories such as interior/exterior colors and transmission types—were also consolidated for improved consistency.

## Data_Visualization

## Data_Preprocessing

Continuous (numerical) variables will be normalized before being fed into the model. Categorical features with a limited number of distinct values will be integer-encoded. For highly granular categorical features—such as engine (1,199 unique descriptions), trim (609 variations), and model (194 types)—word embeddings will be used to capture semantic relationships and reduce dimensionality.

# Model and results



# Conclusion

