source('models.R')


args = commandArgs(TRUE)

if (args[1] == 'user') {
	dataNameUser = list.files(path = '../datasets/imputed/user/', pattern = '*.arff', recursive=TRUE)
	dataPathUser = paste('../datasets/imputed/user/', dataNameUser, sep='')
	testData(dataPathUser, dataNameUser, '00')
} else {

	dataOriginal = list.files(path = '../datasets/original/', pattern = '*.arff', recursive=TRUE)
	dataOriginal = paste('../datasets/original/', dataOriginal, sep='')

	dataName05 = list.files(path = '../datasets/imputed/05/', pattern = '*.arff', recursive=TRUE)
	dataPath05 = paste('../datasets/imputed/05/', dataName05, sep='')

	dataName15 = list.files(path = '../datasets/imputed/15/', pattern = '*.arff', recursive=TRUE)
	dataPath15 = paste('../datasets/imputed/15/', dataName15, sep='')

	dataName25 = list.files(path = '../datasets/imputed/25/', pattern = '*.arff', recursive=TRUE)
	dataPath25 = paste('../datasets/imputed/25/', dataName25, sep='')

	testData(dataOriginal, dataOriginal, '00')
	testData(dataPath05, dataName05, '05')
	testData(dataPath15, dataName15, '15')
	testData(dataPath25, dataName25, '25')
}
