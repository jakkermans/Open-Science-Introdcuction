Analyses on the classification of urbanized regions
================
17 november, 2020

This manuscript uses the Workflow for Open Reproducible Code in Science (Van Lissa et al. 2020) to ensure reproducibility and transparency. All code <!--and data--> are available at <https://github.com/jakkermans/Open-Science-Introdcuction.git>.

This is an example of a non-essential citation (Van Lissa et al. 2020). If you change the rendering function to `worcs::cite_essential`, it will be removed.

## Introduction

This project focused on the Sustainable Development Goals, which were created in 2015 by the United Nations. These goals serve the purpose of improving the world and should be achieved by 2030. Recently, the Global Data Lab (GDL) conducted household surveys in various subnational regions to collect data on several socioeconomic, health and demographic variables. The current dataset created by the GDL contains 126 indicators for 1337 subregions in 128 countries. A subset of the data will be used to answer the question 'How well can highly urbanized regions versus lowly urbanized regions be classified?'.

## Methods

How was the sample size determined, which data exclusions were used, all manipulations

## Participants

Who are the participants in the study

## Procedure

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

Here comes a conclusion

Van Lissa, Caspar J., Andreas M. Brandmaier, Loek Brinkman, Anna-Lena Lamprecht, Aaron Peikert, Marijn E. Struiksma, and Barbara Vreede. 2020. “WORCS: A Workflow for Open Reproducible Code in Science,” May. OSF. doi:[10.17605/OSF.IO/ZCVBS](https://doi.org/10.17605/OSF.IO/ZCVBS).
