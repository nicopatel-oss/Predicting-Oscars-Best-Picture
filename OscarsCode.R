oscars <- read.csv("oscars.csv",header = TRUE)

# 1. Fit the full (largest) model. interpret one of the significant coefficients and report the confidence interval
head(oscars)
attach(oscars)

#Separate the data frame into training data and prediction data depending on the ch score
train_data <- oscars[Ch >= 1, ]
test_data <- oscars[Ch == 0, ]
detach(oscars)
attach(train_data)

#Convert 2 to 0 and other values to 1 in Ch (the response variable)
NomOutcome <- ifelse(Ch == 2, 0, 1)

#Do the same but in the dataframe
train_data$Ch <- NomOutcome

#Fix Scr variable by subtracting 1 from nom for each that have 2 in Scr, then set those to 1 as well 
train_data$Nom[Scr == 2] <- Nom[Scr == 2] - 1
train_data$Scr[Scr == 2] <- 1 

#Fix gd variable from 2 to 1 for roma
train_data$Gd[Gd == 2] <- 1

#remove variables year and name
train_data <- train_data[, !(names(train_data) %in% c("Year", "Name","Pic"))]

#Fit the model
Modelfull <- glm(Ch ~ ., data = train_data, family = binomial)

#Analyse the model and interpret one of the significant coefficients
summary(Modelfull)
#PGA has the smallest P-values making it the most significant coefficient in the model
#report the confidence interval of PGA
CI_PGA <- confint.default(Modelfull,"PGA", level = 0.90)
View(CI_PGA)
xOdds_PGA <- exp(CI_PGA)
View(xOdds_PGA)

#2.) Using an appropriate model selection strategy discussed in class, choose and fit the best model.
#use backwards elimination to fit the best model
drop1(Modelfull,test = "LRT")
#remove Anf as it has the smallest AIC in the model (AIC = 386.21)
fit02 <- update(Modelfull, .~.- Anf)
drop1(fit02, test = "LRT")
#remove Aml as it has the smallest AIC in the model (AIC = 384.21)
fit03 <- update(fit02, .~.- Aml)
drop1(fit03, test = "LRT")
#remove Nom as it has the smallest AIC in the model (AIC = 382.22)
fit04 <- update(fit03, .~.- Nom)
drop1(fit04, test = "LRT")
#remove Western as it has the smallest AIC in the model (AIC = 380.22)
fit05 <- update(fit04, .~.- Western)
drop1(fit05, test = "LRT")
#remove Animation as it has the smallest AIC in the model (AIC = 378.23)
fit06 <- update(fit05, .~.- Animation)
drop1(fit06, test = "LRT")
#remove Comedy as it has the smallest AIC in the model (AIC = 376.25)
fit07 <- update(fit06, .~.- Comedy)
drop1(fit07, test = "LRT")
#remove Docu as it has the smallest AIC in the model (AIC = 374.27)
fit08 <- update(fit07, .~.- Docu)
drop1(fit08, test = "LRT")
#remove For as it has the smallest AIC in the model (AIC = 372.32)
fit09 <- update(fit08, .~.- For)
drop1(fit09, test = "LRT")
#remove Length as it has the smallest AIC in the model (AIC = 370.37)
fit10 <- update(fit09, .~.- Length)
drop1(fit10, test = "LRT")
#remove Son as it has the smallest AIC in the model (AIC = 368.43)
fit11 <- update(fit10, .~.- Son)
drop1(fit11, test = "LRT")
#remove NBR as it has the smallest AIC in the model (AIC = 366.51)
fit12 <- update(fit11, .~.- NBR)
drop1(fit12, test = "LRT")
#remove Gmc as it has the smallest AIC in the model (AIC = 364.61)
fit13 <- update(fit12, .~.- Gmc)
drop1(fit13, test = "LRT")
#remove Afs as it has the smallest AIC in the model (AIC = 362.73)
fit14 <- update(fit13, .~.- Afs)
drop1(fit14, test = "LRT")
#remove Sport as it has the smallest AIC in the model (AIC = 360.85)
fit15 <- update(fit14, .~.- Sport)
drop1(fit15, test = "LRT")
#remove Horror as it has the smallest AIC in the model (AIC = 358.98)
fit16 <- update(fit15, .~.- Horror)
drop1(fit16, test = "LRT")
#remove NYFCC as it has the smallest AIC in the model (AIC = 357.1)
fit17 <- update(fit16, .~.- NYFCC)
drop1(fit17, test = "LRT")
#remove Adventure as it has the smallest AIC in the model (AIC = 355.23)
fit18 <- update(fit17, .~.- Adventure)
drop1(fit18, test = "LRT")
#remove Cin as it has the smallest AIC in the model (AIC = 353.37)
fit19 <- update(fit18, .~.- Cin)
drop1(fit19, test = "LRT")
#remove Gm2 as it has the smallest AIC in the model (AIC = 351.51)
fit20 <- update(fit19, .~.- Gm2)
drop1(fit20, test = "LRT")
#remove Art as it has the smallest AIC in the model (AIC = 349.66)
fit21 <- update(fit20, .~.- Art)
drop1(fit21, test = "LRT")
#remove U as it has the smallest AIC in the model (AIC = 347.85)
fit22 <- update(fit21, .~.- U)
drop1(fit22, test = "LRT")
#remove Eff as it has the smallest AIC in the model (AIC = 346.12)
fit23 <- update(fit22, .~.- Eff)
drop1(fit23, test = "LRT")
#remove Film.noir as it has the smallest AIC in the model (AIC = 344.44)
fit24 <- update(fit23, .~.- Film.noir)
drop1(fit24, test = "LRT")
#remove Ebert as it has the smallest AIC in the model (AIC = 342.78)
fit25 <- update(fit24, .~.- Ebert)
drop1(fit25, test = "LRT")
#remove History as it has the smallest AIC in the model (AIC = 341.12)
fit26<- update(fit25, .~.- History)
drop1(fit26, test = "LRT")
#remove Music as it has the smallest AIC in the model (AIC = 339.43)
fit27 <- update(fit26, .~.- Music)
drop1(fit27, test = "LRT")
#remove Biography as it has the smallest AIC in the model (AIC = 337.79)
fit28 <- update(fit27, .~.- Biography)
drop1(fit28, test = "LRT")
#remove Gf2 as it has the smallest AIC in the model (AIC = 336.18)
fit29 <- update(fit28, .~.- Gf2)
drop1(fit29, test = "LRT")
#remove Scr as it has the smallest AIC in the model (AIC = 334.66)
fit30 <- update(fit29, .~.- Scr)
drop1(fit30, test = "LRT")
#remove Afl as it has the smallest AIC in the model (AIC = 333.18)
fit31 <- update(fit30, .~.- Afl)
drop1(fit31, test = "LRT")
#remove Sco as it has the smallest AIC in the model (AIC = 331.74)
fit32 <- update(fit31, .~.- Sco)
drop1(fit32, test = "LRT")
#remove Gf1 as it has the smallest AIC in the model (AIC = 330.38)
fit33 <- update(fit32, .~.- Gf1)
drop1(fit33, test = "LRT")
#remove Mystery as it has the smallest AIC in the model (AIC = 329.03)
fit34 <- update(fit33, .~.- Mystery)
drop1(fit34, test = "LRT")
#remove Musical as it has the smallest AIC in the model (AIC = 327.79)
fit35 <- update(fit34, .~.- Musical)
drop1(fit35, test = "LRT")
#remove Cos as it has the smallest AIC in the model (AIC = 326.44)
fit36 <- update(fit35, .~.- Cos)
drop1(fit36, test = "LRT")
#remove Thriller as it has the smallest AIC in the model (AIC = 325.16)
fit37 <- update(fit36, .~.- Thriller)
drop1(fit37, test = "LRT")
#remove LAFCA as it has the smallest AIC in the model (AIC = 323.96)
fit38 <- update(fit37, .~.- LAFCA)
drop1(fit38, test = "LRT")
#remove Gm1 as it has the smallest AIC in the model (AIC = 322.70)
fit39 <- update(fit38, .~.- Gm1)
drop1(fit39, test = "LRT")
#remove G as it has the smallest AIC in the model (AIC = 321.52)
fit40 <- update(fit39, .~.- G)
drop1(fit40, test = "LRT")
#remove Sou as it has the smallest AIC in the model (AIC = 320.40)
fit41 <- update(fit40, .~.- Sou)
drop1(fit41, test = "LRT")
#remove Crime as it has the smallest AIC in the model (AIC = 319.20)
fit42 <- update(fit41, .~.- Crime)
drop1(fit42, test = "LRT")
#remove AD as it has the smallest AIC in the model (AIC = 318.26)
fit43 <- update(fit42, .~.- AD)
drop1(fit43, test = "LRT")
#remove Family as it has the smallest AIC in the model (AIC = 317.48)
fit44 <- update(fit43, .~.- Family)
drop1(fit44, test = "LRT")
#remove Fantasy as it has the smallest AIC in the model (AIC = 316.51)
fit45 <- update(fit44, .~.- Fantasy)
drop1(fit45, test = "LRT")
#remove War as it has the smallest AIC in the model (AIC = 315.96)
fit46 <- update(fit45, .~.- War)
drop1(fit46, test = "LRT")
#remove Drama as it has the smallest AIC in the model (AIC = 315.39)
fit47 <- update(fit46, .~.- Drama)
drop1(fit47, test = "LRT")
#remove Action as it has the smallest AIC in the model (AIC = 314.64)
fit48 <- update(fit47, .~.- Action)
drop1(fit48, test = "LRT")
#remove Mak as it has the smallest AIC in the model (AIC = 314.40)
fit49 <- update(fit48, .~.- Mak)
drop1(fit49, test = "LRT")
#remove Ams as it has the smallest AIC in the model (AIC = 313.98)
fit50 <- update(fit49, .~.- Ams)
drop1(fit50, test = "LRT")
#removing anymore predictors would not give us a lower AIC there the backwards elimination is complete.

Fitted.oscars.model <- glm(Ch ~ Dir+Edi+Dan+Gdr+Gd+PGA+DGA+Romance+SciFi+Days+PG+PG13+R+NSFC+WR, data = train_data, family = binomial)

#question 3: Calculate the area under the curve of your final model.
#use the optimal threshold based on the ROC curve and calculate the sensitivity of your final model

#Getting predicted probabilities
Predicted.probs <- predict.glm(Fitted.oscars.model, type = "response")

#Getting train data labels
actual.labels <- train_data$Ch

#sorting predicted probabilities in descending order
ordered.indices <- order(Predicted.probs, decreasing = TRUE)
ordered.probs <- Predicted.probs[ordered.indices]
ordered.actual.labels <- actual.labels[ordered.indices]

#Initialising True Positive Rate (TPR) and False Positive Rate (FPR) vectors
n <- length(actual.labels)
TPR <- numeric(n + 1)
FPR <- numeric(n + 1)

#computing the TPR and FPR at each threshold
for (i in 1:n) {threshold <- ordered.probs[i]
predictions <- ifelse(Predicted.probs >= threshold, 1,0)

TP <- sum(predictions == 1 & actual.labels == 1)#True Positive
TN <- sum(predictions == 0 & actual.labels == 0)#True negative
FP <- sum(predictions == 1 & actual.labels == 0)#False Positive
FN <- sum(predictions == 0 & actual.labels == 1)#False Negative

TPR[i + 1] <- TP/(TP + FN)
FPR[i + 1] <- FP/(FP + TN)}

mean(TPR)

#Plot the ROC curve
plot(FPR, TPR, type = "l", col = "blue", lwd = 2,
     xlab = "False Positive Rate (FPR)", ylab = "True Positive Rate (TPR)",
     main = "ROC curve for Oscars Data")

#Calculating the area under the curve (AUC) 
AUC <- sum((FPR[-1] - FPR[-length(FPR)]) * (TPR[-1] + TPR[-length(TPR)])) / 2
legend("bottomright", legend = paste("AUC = ", round(AUC, 6)), col = "blue", lwd = 2)

#Question 4: Based on your final model, give the predicted probability of winning
# for each contender in this year's best picture category.
test_data <- test_data[, !(names(test_data) %in% c("Year","Pic","Anf","Aml","Nom","Western","Animation","Comedy","Docu","For","Length","Son","NBR","Gmc","Afs","Sport","Horror","NYFCC","Adventure","Cin","Gm2","Art","U","Eff","Film.noir","Ebert","History","Music","Biography","Gf2","Scr","Afl","Sco","Gf1","Mystery","Musical","Cos","Thriller","LAFCA","Gm1","G","Sou","Crime","AD","Family","Fantasy","War","Drama","Action","Mak","Ams" ))]
#predict the winner of this year's nominees based off the data from the final model.
raw.probs <- predict.glm(Fitted.oscars.model, newdata = test_data, type = "response")
#adjust the probabilities to sum up to 1
test_data$Win.prob <- raw.probs/sum(raw.probs)
predicted.results <- data.frame(
  Film = c("A Complete Unknown","Anora","Conclave","Dune: Part Two","Emilia Perez","I'm Still Here","Nickel Boys","The Brutalist","The Substance","Wicked"),
  XWin = c(0.0129631106,0.8691658492,0.0105556762,0.0008996347,0.0197148679,0.0069455186,0.0470089588,0.0124081002,0.0012658410,0.0190724429) 
)



