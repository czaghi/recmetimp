library('stringi')
library('RWeka')
library('mlr')


getClassifErrors <- function(data, cv) {
	classif.c45 = makeLearner('classif.J48')
	classif.svm = makeLearner('classif.svm')
	classif.rf = makeLearner('classif.randomForest')

	task  = makeClassifTask(data=data, target='class')
	c45.mmce = resample(classif.c45, task, cv)$aggr[1]
	svm.mmce = resample(classif.svm, task, cv)$aggr[1]
	randomForest.mmce = resample(classif.rf, task, cv)$aggr[1]

	return(c(c45.mmce, svm.mmce, randomForest.mmce))
}


testData <- function(dataPath, dataName, p) {	
	iter = 30
	cv = makeResampleDesc("CV", iters=10)

	final.results = setNames(
		data.frame(matrix(ncol=5, nrow=0)),
		c('dataset', 'method', 'algorithm', 'error', 'sd')
	)

	for (i in 1:length(dataPath)) {
		data = read.arff(dataPath[i])
		
		dataset = stri_extract_first_regex(dataName[i], '[0-9]+')
		method = data$imputationMethod[1]
		data = data[, !(colnames(data) == 'imputationMethod')]
		
		if (is.null(method)) {
			method = 'original'
			dataset = '00'
		}

		c45Error = c()
		svmError = c()
		rfError = c()

		for (j in 1:iter) {
			errors = getClassifErrors(data, cv)

			c45Error = c(c45Error, errors[1])
			svmError = c(svmError, errors[2])
			rfError = c(rfError, errors[3])
		}

		c45ErrorMed = mean(c45Error)
		c45ErrorSd = sd(c45Error)
		svmErrorMed = mean(svmError)
		svmErrorSd = sd(svmError)
		rfErrorMed = mean(rfError)
		rfErrorSd = sd(rfError)
		
		final.results[nrow(final.results) + 1,] = list(dataset, method, 'c45', c45ErrorMed, c45ErrorSd)
		final.results[nrow(final.results) + 1,] = list(dataset, method, 'svm', svmErrorMed, svmErrorSd)
		final.results[nrow(final.results) + 1,] = list(dataset, method, 'rf', rfErrorMed, rfErrorSd)
	}

	final.results = final.results[order(final.results$error),]

	print(final.results)
	write.arff(final.results, paste('../datasets/result/result', p, '.arff', sep=''))
}

