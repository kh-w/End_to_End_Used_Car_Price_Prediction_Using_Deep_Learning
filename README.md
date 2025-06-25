# Content

<table>
  <tr>
    <td>
      <img src="https://github.com/user-attachments/assets/ed846c3e-da44-44b2-9610-68b67e3d1eda" alt="Cover1" width="200"/>
    </td>
    <td>
      <ul>
        <li><a href="#introduction">Introduction</a></li>
        <li><a href="#dataset">Dataset</a>
          <ul>
            <li><a href="#data_cleaning">Data_Cleaning</a></li>
            <li><a href="#data_visualization">Data_Visualization</a></li>
            <li><a href="#data_preprocessing">Data_Preprocessing</a></li>
          </ul>
        </li>
        <li>
          <li><a href="#dodel_and_results">Model_and_results</a></li>
        </li>
      </ul>
    </td>
    <td>
      <img src="https://github.com/user-attachments/assets/8ebde101-a2a8-47a3-9927-1b8fe80790d9" alt="Cover2" width="200"/>
    </td>
  </tr>
</table>


# Introduction

The goal of this project was to estimate used car prices under $20,000. I began by collecting data through web scraping from cars.com using respectful, low-frequency requests to avoid overloading the site’s servers. The dataset, intended solely for academic purposes, was then cleaned and preprocessed—this included removing blank rows, correcting typos, and engineering features such as grouping interior and exterior colors into broader color tones. For high-cardinality categorical variables like trim or engine descriptions, I applied word embedding techniques to capture semantic relationships. I also conducted exploratory data visualization to better understand the distribution and relationships within the dataset. Finally, I built and fine-tuned a deep neural network to predict car prices, optimizing its performance through validation and model tuning.

# Dataset

Disclaimer: Although the data used was publicly available, it is prohibited to use the dataset for any business purposes. Therefore, the data used in this project was solely for academic and research purposes, it did not, will not and should not be used in any businesses.

This project focused on used car pricing below $20,000 offering. Since I am web scrapping, the size of the dataset should be limited. The brands were limited to Toyota, Honda, Mitsubishi, Nissan, Maxda and Subaru, and the area I used is 500 miles from 60126 zipcode. The data I collected from each car are: ["make", "year", "trim", "model", "stock_type", "fuel_type", "bodystyle", "photo_count", "exterior_color", "interior_color", "drivetrain", "fuel_type", "transmission", "engine", "mileage", "accidents_or_damage", "clean_title", "one_owner_vehicle", "personal_use_only", "open_recall", "comfort_rating", "interior_rating", "performance_rating", "value_rating", "exterior_rating", "reliability_rating", "price"], where "price" is the target variables. 

The data was raw, i.e. include blank rows, missing values, granular categories, spelling differences of the same category, etc, such that data cleaning and preprocessing are needed. 

## Data_Cleaning

The dataset was compiled gradually over several days using a gentle scraping method, which led to the presence of some blank rows as certain car listings were removed during the process. For the same reason, some listings changed to over $20,000 which requires removal in this analysis. Additionally, some listings contained missing values, for example: certain ratings were occasionally unavailable. To address this, we searched for other listings in the dataset of the same model to fill in the missing data; if no matching records were found, the missing values were filled using average ratings. Inconsistent naming across categorical variables (e.g., "AWD" vs. "All-Wheel-Drive") was resolved through manual standardization. Missing values in categorical features were replaced with a default category such as "Unknown". During this step, some granular categories such as interior/exterior colors and transmission types—were also consolidated for improved consistency. Listings with rare attributes—such as pink exterior color or double-clutch transmission—were also removed to avoid issues during train/test splitting. Finally, listings with $0 listing price are also being removed. 

After data cleaning, the dataset contains 25 predictors across 30,189 car listings:
![image](https://github.com/user-attachments/assets/33218918-36d2-4bf3-a2b5-208c6c6aa94c)

## Data_Visualization

Pair plots of continuous variables: ['price', 'mileage', 'year', 'photo_count', 'comfort_rating', 'interior_rating', 'performance_rating', 'value_rating', 'exterior_rating', 'reliability_rating']. The plots suggest that the predictor variables are suitable for preprocessing via normalization. Additionally, the scatterplots indicate that the rating variables are moderately correlated with the listing price.
<img src="https://github.com/user-attachments/assets/20b18bf3-64f3-49ae-8caf-a7e962f13d2b" alt="Untitled" width="450"/>
<img src="https://github.com/user-attachments/assets/9e2c056b-56bc-4cae-b82f-0642c2129d7d" alt="Untitled" width="500"/>
As a follow-up to the scatterplots, the correlation heatmap above highlights that mileage and year are also significantly correlated with the listing price—relationships that were less visually apparent in the scatterplots.

The plot of mileage versus price is color-coded by any two makes of — Toyota, Honda, Subaru, and Nissan — which are the most represented in the dataset. 
![image](https://github.com/user-attachments/assets/28a1f9ca-d09d-46e7-9873-714cf6bac934)
Similarly, year versus price:
![image](https://github.com/user-attachments/assets/b8fa5ed4-a442-4cd2-9d0f-b099e5edc326)
The two graphs above show that Toyota and Honda tend to have older vehicles—with higher mileage or age—priced similarly to newer or less-used cars from other brands. This suggests stronger overall demand for these makes, likely due to their reputation for reliability.

Categorical variables versus price can be explored by boxplots, along with their counts in the dataset. The count plots provide a quick overview of category distributions, helping to spot any irregularities or dominant patterns in the data. When a category appears infrequently, any unusual patterns it shows may be insignificant in the context of the entire dataset.
![Untitled](https://github.com/user-attachments/assets/1d354e5b-d00e-44e7-9395-46bb27ed0920)


## Data_Preprocessing

Continuous (numerical) variables will be normalized before being fed into the model. Categorical features with low-cardinality will be integer-encoded. For high-cardinality categorical features — such as engine (1,199 unique descriptions), trim (609 variations), and model (194 types) — word embeddings will be used to capture semantic relationships and reduce dimensionality (compared to one-hot encoding).

Low-cardinality categorical features before and after integer-encoding:
![image](https://github.com/user-attachments/assets/ce75fe79-fb3a-48e9-b0e1-c980c561b4be)

A Keras Tokenizer was used to convert the free-text descriptions in the 'engine' column into numerical sequences suitable for input into a deep learning model. The tokenizer was configured with a vocabulary limit of the 1,000 most frequent tokens (num_words=1000) and an out-of-vocabulary token (<OOV>) to handle rare or unseen words during inference. After fitting the tokenizer on the training data, the engine descriptions were transformed into sequences of integers representing the word indices. These sequences were then padded to a fixed length for uniform input shape.

Here is an example of 10 'engine' values before and after word embedding:
![image](https://github.com/user-attachments/assets/f6624892-3f9e-411f-85e0-034d6975e040)

# Model_and_results

The model is a multi-input regression neural network designed to predict a continuous target, i.e. listing price, based on a set of categorical and numerical features. Categorical inputs such as make, model, fuel type, drivetrain, and others are passed through embedding layers to convert each discrete category into dense vector representations. Some features like trim, engine, and model accept multiple tokens and are embedded as sequences. These embeddings are flattened and concatenated with normalized numerical inputs like year, mileage, and user ratings (comfort, performance, reliability, value, exterior, interior). The resulting concatenated feature vector with length 233 is fed through 3 fully connected layers with 64, 64, and 32 neurons respectively, each using ReLU activation. Finally, a single neuron with linear activation produces the regression output. With approximately 46,000 parameters, this model effectively predicted car prices with Mean Absolute Error $1,759.90. The average of car prices is $13,665.27, therefore the error is roughly 13% of the average price. The R² is 0.73 which means 73% of the variability of the listing price can be explained through the available predictors under this model.

![image](https://github.com/user-attachments/assets/07525732-6c2c-4430-ba15-6e42b8626428)

# Conclusion

This project successfully developed a deep learning regression model to estimate used car prices under $20,000 based on a dataset collected via web scraping. After thorough data cleaning, preprocessing, and exploratory analysis, the model leveraged a combination of normalized numerical features and word-embedded categorical variables to capture complex relationships within the data.

The model achieved a Mean Absolute Error (MAE) of $1,759.90, which corresponds to about 13% of the average car price ($13,665). The R² score of 0.73 indicates that the model explains 73% of the variance in used car prices, demonstrating strong predictive performance given the complexity and variability inherent in used car markets.

These results suggest that embedding techniques for high-cardinality categorical features, combined with a multi-input neural network architecture, are effective strategies for modeling real-world pricing data. However, there remains room for improvement, especially in reducing prediction error further and capturing more subtle market dynamics.

Future work could explore incorporating additional external factors (for example: geographic trends, economic indicators), refining feature engineering, and experimenting with more advanced architectures or ensemble methods to enhance accuracy and robustness.
