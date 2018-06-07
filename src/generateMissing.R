library('RWeka')
library('missForest')

generateMissing <- function(data, p) {
	
	missData = prodNA(data[, !(colnames(data) == 'class')], noNA=p)
	missData$class = data$class

	return(missData)
}

dataName = list.files(path = '../datasets/original/', pattern='*.arff', recursive=FALSE)
dataPath = paste('../datasets/original/', dataName, sep='')

data = read.arff(dataPath)

files = 10

for (i in 1:files) {
	missData = generateMissing(data, 0.05)
	write.arff(missData, file=paste('../datasets/missing/05/', i, '_', dataName, sep=''))

	missData = generateMissing(data, 0.15)
	write.arff(missData, file=paste('../datasets/missing/15/', i, '_', dataName, sep=''))

	missData = generateMissing(data, 0.25)
	write.arff(missData, file=paste('../datasets/missing/25/', i, '_', dataName, sep=''))
}
