# Predicting the 2025 Oscar Best Picture Winner

## Overview

The Oscars Best Picture award is widely regarded as the most prestigious award in the film industry. Through the years, the Oscars have historically favoured films with certain characteristics. To test whether this is true, we can use the historical data to build a regression model and predict this year's Oscar winner in the Best Picture category.

## Fitting the full model

I fit a generalised linear regression model to predict the Oscar Best Picture winner, which included awards and nominations, genre information, movie ratings, critical ratings and Guild awards as predictors. From the 65 predictors used in the model, the most significant coefficient was PGA (Producers Guild winner) with a p-value of 1.04e-12 and an estimate of 3.547. To interpret this in terms of odds, we must take the exponential of the estimate. Using our estimate for PGA, we get that films with a Producers Guild Award are 34.7x more likely to win Best Picture compared to those without.

<p align="center">
  <img src="images/figure1_ci_log_odds.png" alt="90% confidence interval for the PGA coefficient on the log-odds scale: 2.728532 to 4.366357" />
  <br>
  <em>Figure 1: 90% confidence interval for the log odds of a Producers Guild winner</em>
</p>

<p align="center">
  <img src="images/figure2_ci_odds.png" alt="90% confidence interval for the PGA effect on the odds scale: 15.3104 to 78.75618" />
  <br>
  <em>Figure 2: 90% confidence interval after taking the exponential, for the true odds</em>
</p>

After fitting the generalised linear regression model and identifying that PGA is the most significant coefficient, I reported the confidence interval with a 90% confidence level to understand how impactful winning the Producers Guild Award is when winning Best Picture. From the results shown in Figure 2, the evidence suggests we are 90% confident that the true effect of winning the Producers Guild Award on the odds of winning Best Picture is between 15.3x and 78.8x (to 3 s.f.).

## Model selection and fitting the best model

<p align="center">
  <img src="images/figure3_final_model.png" alt="R output of the final model after backwards elimination, listing each remaining predictor with its deviance, AIC, likelihood ratio test statistic and p-value. PGA is the most significant predictor." />
</p>

From the full model it was evidently clear that PGA was the strongest coefficient when compared to the rest of the predictors. However, it was just as clear that most of the predictors were insignificant. Knowing this, I used manual backwards elimination to remove any predictors that were deemed insignificant towards predicting the winner of Best Picture. The likelihood ratio test is the only suitable test to use for a generalised linear model, since the F-test relies on assuming normality. The condition I used to determine which predictor to drop was which predictor has the smallest AIC value, and the backwards elimination stops when removing a predictor doesn't decrease the AIC value. I chose to analyse AIC values because it is a good measure of model quality as well as a good way to prevent overfitting the model. After completing backwards elimination, we are left with the model shown above in Figure 3. This is the most complete generalised linear model we can fit from the data we started with.

## Area under the Curve and optimal threshold based on ROC curve

Now that we have fitted the best possible model from the data, we now want to know whether the model performs well in general. To determine this, I used a ROC curve to evaluate how well the full model distinguishes between winning and not winning. Figure 4 below shows that the curve quickly rises to the top left corner of the graph. The graph indicates that there's a high true positive rate (sensitivity) and a low false positive rate, meaning the model has a good performance. This is backed up by the fact that the area under the curve is 0.925709, which generally means excellent discrimination between winners and non-winners. Lastly, the true positive rate (sensitivity) for the model is 85.7%, meaning that the model correctly predicts the winner from the data 85.7% of the time.

<p align="center">
  <img src="images/figure4_roc_curve.png" width="600" alt="ROC curve for the Oscars data, rising steeply towards the top left corner, with an AUC of 0.925709" />
  <br>
  <em>Figure 4: ROC curve and AUC value for the final model</em>
</p>

## Results – Predicting probabilities

Using the final model, trained on the previous nominees, I predicted probabilities for the 2025 Best Picture nominees. The predicted probabilities were then normalised to sum to 1 so that they form a valid probability distribution. Figure 5 shows that the model predicts Anora to win the Best Picture award by a significant margin. The model has heavily favoured Anora because the film has a combination of strong predictor values, such as the Producers Guild Award, a Director nomination and an Editing nomination.

<p align="center">
  <img src="images/figure5_predicted_probabilities.png" alt="Table of predicted win probabilities for the ten 2025 Best Picture nominees. Anora is highest at 0.869; Nickel Boys is next at 0.047." />
  <br>
  <em>Figure 5: Predicted probabilities for the nominees to win the 2025 Best Picture</em>
</p>

## Conclusion – Suitability

From the results, it seems that logistic regression was a good baseline model for classifying the Oscars data. However, there are many disadvantages to using logistic regression, which implies that there are more suitable models. For example, logistic regression assumes linearity, which is an issue when trying to capture complex interactions between variables. In addition, logistic regression struggles with imbalanced data, which causes bias if one class dominates.

There are multiple suitable approaches which may model the data better. A good example is gradient boosting. Gradient boosting uses multiple weak learners, such as decision trees, to create a strong predictive model. For structured data problems, gradient boosting often outperforms logistic regression: it can learn non-linear relationships and interactions, and it handles imbalanced data well with weighted loss functions.
