Analyses on the classification of urbanized regions
================
18 november, 2020

This manuscript uses the Workflow for Open Reproducible Code in Science (Van Lissa et al. 2020) to ensure reproducibility and transparency. All code <!--and data--> are available at <https://github.com/jakkermans/Open-Science-Introdcuction.git>.

This is an example of a non-essential citation (Van Lissa et al. 2020). If you change the rendering function to `worcs::cite_essential`, it will be removed.

## Introduction

This project focused on the Sustainable Development Goals, which were created in 2015 by the United Nations. These goals serve the purpose of improving the world and should be achieved by 2030. Recently, the Global Data Lab (GDL) conducted household surveys in various subnational regions to collect data on several socioeconomic, health and demographic variables. The current dataset created by the GDL contains 126 variables for 1337 subregions in 128 countries. A subset of the data will be used to answer the question 'How well can highly urbanized regions versus lowly urbanized regions be classified?'.

## Methods

Data from 217 subregions was selected to be analyzed in this project. These subregionswere selected by the coordinators before the project began. Some exclusions had to be made to ensure that the classifiers worked properly. Since not all classifiers could handle categorical data, it was decided to exclude these variables from the dataset, except for the urbanization variable which was the predictor. The data was subsequently scaled since many numerical variables had widely differing scales. The resulting data was then used to test the classification of urbanized regions.

## Procedure

Classification works by first training a classifier on a training set to learn certain patterns in the data. It is then applied on the test set to attempt to correctly 'guess' the class of a test case. Therefore, the scaled data is divided into a training and a test set, with a 75/25 ratio. Subsequently, two classifiers will be used. Those are a logistic regression classifier and a random forest classifier. Each classifier will first be tested on the training set and subsequently tested on the test set. The performance of the classifiers is evaluated in terms of the accuracy of the classifiers, i.e. the proportion of correctly classified cases.

## Results

Classification through logistic regression and random forest yielded the following results:

``` r
set.seed(123)
accuracy <- function(predictions, answers){sum((predictions==answers)/length(answers))} #function to calculate the accuracy of a classifier
ntrain <- round(nrow(scaled_urban_data)*3/4) #determine how many observations are needed for the training set
train <- sample(1:nrow(scaled_urban_data), ntrain) #sample the observations to be included in the training set

#Logistic regression results
urban_model <- glm(urban ~ ., data = scaled_urban_data[train,], family = "binomial")
```

    ## Warning: glm.fit: algorithm did not converge

    ## Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred

``` r
urban_preds <- round(predict(urban_model, newdata = scaled_urban_data[-train,], type = "response"))
```

    ## Warning in predict.lm(object, newdata, se.fit, scale = 1, type = if (type == :
    ## prediction from a rank-deficient fit may be misleading

``` r
urban_preds <- ifelse(urban_preds==1,"low", "high")
accuracy(urban_preds, scaled_urban_data[-train,3])
```

    ## [1] 0.8703704

``` r
table(urban_preds, scaled_urban_data[-train,3])
```

    ##            
    ## urban_preds high low
    ##        high   18   4
    ##        low     3  29

``` r
#Random Forest
urban_forest <- randomForest(urban ~ ., data = scaled_urban_data[train,], importance = TRUE, ntree = 2000, mtry = 5)
urban_forest_preds <- predict(urban_forest, newdata = scaled_urban_data[-train,])
accuracy(urban_forest_preds, scaled_urban_data[-train,3])
```

    ## [1] 0.8888889

``` r
table(urban_forest_preds, scaled_urban_data[-train,3])
```

    ##                   
    ## urban_forest_preds high low
    ##               high   18   3
    ##               low     3  30

## Discussion

The question in this project was 'How well can highly urbanized regions versus lowly urbanized regions be classified?'. It was expected that a 'guess-one' (i.e. only guesses one category) classifier would be beaten. The logistic regression classifier and the random forest classifier both achieved an accuracy higher than 50%, which is what a 'guess-one' classifier would be expected to achieve. Therefore, we can conclude that highly urbanized regions versus lowly urbanized regions can be classified relatively well. However, this project utilized a seed, which allows for exact replications of the results every time the code is ran. Since the sampling of the training data depends on sampling, using a different seed will most likely lead to different results which could potentially disprove the current conclusion. This is something that could be tested in the future.

Van Lissa, Caspar J., Andreas M. Brandmaier, Loek Brinkman, Anna-Lena Lamprecht, Aaron Peikert, Marijn E. Struiksma, and Barbara Vreede. 2020. “WORCS: A Workflow for Open Reproducible Code in Science,” May. OSF. doi:[10.17605/OSF.IO/ZCVBS](https://doi.org/10.17605/OSF.IO/ZCVBS).
