source('analysis.R')
source('recomendation.R')

options(digits=3)

args = commandArgs(TRUE)

if (args[1] == 'user') {
	dataUser = read.arff('../datasets/result/result00.arff')

	minError = min(dataUser$error)
	maxError = max(dataUser$error)
	medError = (minError + maxError) / 2

	print(dataUser[,c('method', 'algorithm', 'error', 'sd')])

	heatmapRecomendation(dataUser, minError, maxError, medError)

} else {
	originalDataName = list.files(path = '../datasets/original/', pattern = '*.arff', recursive=TRUE)
	originalData = read.arff(paste('../datasets/original/', originalDataName, sep=''))

	original = read.arff('../datasets/result/result00.arff')

	print('Original dataset')
	print(original[,c('algorithm', 'error', 'sd')])

	data05 = read.arff('../datasets/result/result05.arff')
	data15 = read.arff('../datasets/result/result15.arff')
	data25 = read.arff('../datasets/result/result25.arff')

	minError = min(data05$error, data15$error, data25$error)
	maxError = max(data05$error, data15$error, data25$error)
	medError = (minError + maxError) / 2


	generateAnalysis(data05, '05', minError, maxError, medError)
	generateAnalysis(data15, '15', minError, maxError, medError)
	generateAnalysis(data25, '25', minError, maxError, medError)

}

print('You can find the result in ../plots!')
