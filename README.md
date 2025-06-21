# About this project

The goal of this project was to estimate used car prices under $20,000.

In this project, I did:
- Web scaping using Python on cars.com using gentle methods, i.e. web scrape slowly to avoid sudden traffic for the website. The dataset obtained is solely for academic purposes.
- Performed data cleaning including remove blank rows, typo fixing and data pre-processing including create color tunes as a bigger grouping for exterior/interior colors, create word embedding for categorical variables with large number of categories.
- Built and fine-tuned deep neural network to price used cars.

# Dataset

Disclaimer: Although the data used was publicly available, it is prohibited to use the dataset for any business purposes. Therefore, the data used in this project was solely for academic and research purposes, it did not, will not and should not be used in any businesses.

This project focused on used car pricing below $20,000 offering. Since I am web scrapping, the size of the dataset should be limited. The brands were limited to Toyota, Honda, Mitsubishi, Nissan, Maxda and Subaru, and the area I used is 500 miles from 60126 zipcode. The data I collected from each car are: ["make", "year", "trim", "model", "stock_type", "fuel_type", "bodystyle", "photo_count", "exterior_color", "interior_color", "drivetrain", "fuel_type", "transmission", "engine", "mileage", "accidents_or_damage", "clean_title", "one_owner_vehicle", "personal_use_only", "open_recall", "comfort_rating", "interior_rating", "performance_rating", "value_rating", "exterior_rating", "reliability_rating", "singleurl", "price"], where "price" is the target variables. 

The data was raw, i.e. include blank rows, typos, granular categories, spelling differences of the same category, etc, such that data cleaning and preprocessing are needed.

## Data Cleaning



## Data Preprocessing



# Model and results



# Conclusion

