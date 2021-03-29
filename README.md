# Used Car Pricing - Deep Neural Network

This project focused on used car pricing below $20000 offering. Due the limitation of dataset building, the brands are limited to Toyota, Honda, Mitsubishi, Hyundai, Kia and Subaru. The dataset obtained is solely for academic and research purposes, it did not, will not and should not be used in any businesses. 

Given the information of a used car, the price can be estimated by a deep neural network with mean absolute error (~$1565.41):

![Summary of variables](variables_summary.png)

The model is a 2-layer densely connected network. The number of nodes in each layer is found by using the tuneGrid below:
