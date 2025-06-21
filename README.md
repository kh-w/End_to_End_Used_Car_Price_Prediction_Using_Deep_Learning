# About this project

The goal of this project was to estimate used car prices under $20,000.

In this project, I did:
- Web scaping using Python on cars.com using gentle methods, i.e. web scrape slowly to avoid sudden traffic for the website. The dataset obtained is solely for academic purposes.
- Performed data cleaning including remove blank rows, typo fixing and data pre-processing including create color tunes as a bigger grouping for exterior/interior colors, create word embedding for categorical variables with large number of categories.
- Built and fine-tuned deep neural network to price used cars.

# Dataset

Disclaimer: Although the data used was publicly available, it is prohibited to use the dataset for any business purposes. Therefore, the data used in this project was solely for academic and research purposes, it did not, will not and should not be used in any businesses.

This project focused on used car pricing below $20,000 offering. Since I am web scrapping, the size of the dataset should be limited. The brands were limited to Toyota, Honda, Mitsubishi, Nissan, Maxda and Subaru, and the area I used is 500 miles from 60126 zipcode. The predictors I collected from each car are: ["make", "year", "trim", "model", "stock_type", "fuel_type", "bodystyle", "photo_count", "exterior_color", "interior_color", "drivetrain", "fuel_type", "transmission", "engine", "mileage", "accidents_or_damage", "clean_title", "one_owner_vehicle", "personal_use_only", "open_recall", "comfort_rating", "interior_rating", "performance_rating", "value_rating", "exterior_rating", "reliability_rating", "singleurl", "price"].


# Model and results

The price of an used car could be estimated by a deep neural network. The model was a 2-layer densely connected network. The number of nodes in each layer was found by using the tuneGrid below. Noted that the models were sorted by the mean absolute error (mae) of the model on the hold-out validation dataset.

![tuneGrid of 2-layer densely connected network](tuneGrid.png)

The best performance was from a 2-layer model with 128 nodes on the first hidden layer, and 256 nodes on the second hidden layer. The mae is $1505.98. 

# Conclusion

The range of error, ±$1500, was reasonable because it was quite common that a few thousands dollars discount appeared on some used car if the listing was long enough. From used car dealers' point of view, this mae could provide insight on what is the reasonable price range for a certain car if the car condition is unknown. They could list the car using the ceiling of this price range. From indiviudal sellers' point of view, this price range could provide insight on how much the car dealer is going to list their cars. This insight could be a useful reference to get a good deal.
