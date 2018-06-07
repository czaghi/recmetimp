source('impute.R')


args = commandArgs(TRUE)

if (args[1] == 'user') {
	dataUser = list.files(path = '../datasets/original/', pattern = '*.arff', recursive=TRUE)
	dataPathUser = paste('../datasets/original/', dataUser, sep='')

	imputeData(dataPathUser, dataUser, 'user')
} else {
	dataName05 = list.files(path = '../datasets/missing/05/', pattern = '*.arff', recursive=TRUE)
	dataPath05 = paste('../datasets/missing/05/', dataName05, sep='')

	dataName15 = list.files(path = '../datasets/missing/15/', pattern = '*.arff', recursive=TRUE)
	dataPath15 = paste('../datasets/missing/15/', dataName15, sep='')

	dataName25 = list.files(path = '../datasets/missing/25/', pattern = '*.arff', recursive=TRUE)
	dataPath25 = paste('../datasets/missing/25/', dataName25, sep='')

	imputeData(dataPath05, dataName05, '05')
	imputeData(dataPath15, dataName15, '15')
	imputeData(dataPath25, dataName25, '25')
}
