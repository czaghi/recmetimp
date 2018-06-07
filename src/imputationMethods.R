library('VIM')
library('missForest')
library('randomForest')

meanImputation <- function(missData) {
	imputedData = na.roughfix(missData)
	return(imputedData)
}

randomForestImputation <- function(missData) {
	imputedData = rfImpute(class ~ ., missData)
	return(imputedData)
}

knnImputation <- function(missData, k) {
	imputedData = kNN(missData, k=k, imp_var=FALSE)
	return(imputedData)
}
