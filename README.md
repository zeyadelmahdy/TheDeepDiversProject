# TheDeepDivers Mid-Bootcamp Project 
by Arne Thielenhaus & Zeyad ElMahdy

![TheDeepDiversProject](https://github.com/zeyadelmahdy/TheDeepDiversProject/blob/main/4760796.jpg)
![TheDeepDiversProject](https://github.com/zeyadelmahdy/TheDeepDiversProject/blob/main/communityIcon_anc30b6ykk461.jpg)

## Predicting Real-Estate Prices in King County

### Table of content

- [Problem Statement](#problem-statement)
- [Methodology](#methodology)
- [Visualization](#visualization)
- [Findings](#findings)

### Problem Statement

We are Anlaysts for a real estate company and we have been recently tasked with predicting the prices in King County based on a number of features. Additionaly, we should conclude what features correspond to houses being sold for over $650,000. 

#### The Data Set: 

We are given a data set of some 20,000 properties sold between 2014 and 2015 in King County, WA. In the data set, there are a number of features and elements such as # of floors, bathrooms, and year renovated. 

#### The Task: 

Build a Machine Learning model to help predict the selling price based on the provided features. 


### Methodology 

- Exploring & cleaning the data
- Scaling the data
- Applying the model
- Reviewing results

##### Exploring & cleaning the data
First steps were to take a look at the data in both Python and Tableau to see if we can identify any issues/trends within the data. 

We were able to quickly identify some outliers that might skew the data falsly. 
```
# Drop lot sizes with >250,000 square feet since these are likely not houses but farms 
df.drop(df[df.sqft_lot15 > 200000].index, inplace=True)
```
Then we found some redundant columns that could be dropped as they do not have significant value to us such as id and date. 
After some further exploration we decided to create clusters based on geospacial data using Kmeans algorithm. We began experimenting with 20 clusters but ultimately settled on 500 clusters, as these provided better results.

We were able to convert Lat/Long into addresses using Geopy. The initial plan was to obtain the names of the streets on which the properties were located and further improve the accuracy of the model. However, the data-conversion into street names as well as the conversion of the gathered street names into binary and subsequent training of the model with several thousand columns was very time consuming. Furthermore, the performance of the model appeared to be markedly worse afterwards. It was therefore decided to return to geographical clustering with Kmeans.

In order to check for potential areas of improvement, the predictions and test data were exported. It was thereby discovered that there were some Zip Codes in which there was a particularly large number of significant mispredictions (off by more than 25%). The following is a list of the top 5 zip code areas with the largest number of excessively low predictions:

Zip Code    No. of sig. mispredictions     Prop. of sig. mispredictions       Prop. of dataset
98023	                66	                            0.084	                        0.025
98178	                42	                            0.053	                        0.014
98198	                40	                            0.051	                        0.013
98038	                38	                            0.048	                        0.031
98001	                34	                            0.043	                        0.018

A review of these areas on Google Maps did not reveal any obvious features (ex: proximity to airport) which could explain these discrepancies. As a result, no adjustments to the model were made.

![image](https://user-images.githubusercontent.com/80153403/142478023-b988d21f-a262-443f-a1d1-239938437ae4.png)


![TheDeepDiversProject](https://github.com/zeyadelmahdy/TheDeepDiversProject/blob/main/download.png)

##### Scaling the data

Next step was to start exploring the different scaling methods and how they would affect the data.

We found that the Robust Scaler yielded slightly better results than all other methods used (Normalizer, StandardScaler, MinMax)

```
from sklearn.preprocessing import RobustScaler

# Model 2 - Robust Scale
transformer_s =  RobustScaler().fit(numerical)
X_rob_scaled = transformer_s.transform(numerical)
```


##### Applying the Model

Here we decided to use Linear Regression as our model as it was more accurate than KNN.

For a further detailed documentation of the code used, please click [here](https://github.com/zeyadelmahdy/TheDeepDiversProject/blob/main/Housing_Data_Analysis_V2.ipynb)


##### Reviewing results

The model achieved an accuracy measure of approximately 85% after we used the clustering method mentioned earlier
What this means is that we can now predict housing prices with an accuracy of 85% based on the given features. 

R2 score= 0. 853...
Mean absolute error = 84357

These values indicate that there is still significant room for improvement with regards to the mean error.

### Visualization 

You can see below some of our visualizations that we were able to create. For more visualizations, click [here](https://public.tableau.com/app/profile/zeyad.elmahdy/viz/HousingDataDashboard_16370759374640/Dashboard1?publish=yes)

![TheDeepDivers](https://github.com/zeyadelmahdy/TheDeepDiversProject/blob/main/2021-11-18%2017_59_59-Greenshot.png)
![TheDeepDivers](https://github.com/zeyadelmahdy/TheDeepDiversProject/blob/main/image.png)



### Findings

To conclude, we can predict housing prices in King County with an accuracy of 85%. In addition, we can make certain pricing recommendations on undervalued & overvalued properties in order to optimize their pricing. 

However, to achieve a higher prediction accuracy we would require more hyperlocal data points in order dive deeper into the underlying trends and insights. Presumably the model can also be tweaked to better reflect the existing data.



Thanks for reading and happy diving!

![TheDeepDivers](https://github.com/zeyadelmahdy/TheDeepDiversProject/blob/main/20120305-065858.jpg)
