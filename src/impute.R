library('RWeka')

source('imputationMethods.R')


imputeData <- function(dataPath, dataName, p) {
	for (i in 1:length(dataPath)) {
		data = read.arff(dataPath[i])

		print('Mean imputation...')
		meanData = meanImputation(data)
		meanData$imputationMethod = 'mean'
		print('Done!')

		print('Random Forest imputation...')
		randomForestData = randomForestImputation(data)
		randomForestData$imputationMethod = 'rf'
		print('Done!')

		print('KNN imputation...')
		print('k = 3')
		knnData3 = knnImputation(data, 3)
		knnData3$imputationMethod = 'knn3'
		print('k = 5')
		knnData5 = knnImputation(data, 5)
		knnData5$imputationMethod = 'knn5'
		print('k = 9')
		knnData9 = knnImputation(data, 9)
		knnData9$imputationMethod = 'knn9'
		print('Done!')
		
		write.arff(meanData, file=paste('../datasets/imputed/', p, '/', formatC(i, width=2, flag='0'), '_mean_', dataName[i], sep=''))
		write.arff(randomForestData, file=paste('../datasets/imputed/', p, '/', formatC(i, width=2, flag='0'), '_randomForest_', dataName[i], sep=''))
		write.arff(knnData3, file=paste('../datasets/imputed/', p, '/', formatC(i, width=2, flag='0'), '_knn3_', dataName[i], sep=''))
		write.arff(knnData5, file=paste('../datasets/imputed/', p, '/', formatC(i, width=2, flag='0'), '_knn5_', dataName[i], sep=''))
		write.arff(knnData9, file=paste('../datasets/imputed/', p, '/', formatC(i, width=2, flag='0'), '_knn9_', dataName[i], sep=''))
	}
}
