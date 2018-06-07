library('RWeka')
library('ggplot2')


heatmap = function(data, algorithm, p, minError, maxError, medError) {

	name = list.files(path = '../datasets/original/', pattern = '*.arff', recursive=TRUE)
	name = tools::file_path_sans_ext(name)

	if (p == 'user') {
		title = paste('Erro dos modelos gerados pelo ', algorithm, sep='')
	} else {
		title = paste('Erro dos modelos gerados pelo ', algorithm, ' para ', p , '% de valores ausentes', sep='')
	}

	file = paste('../plots/', name, '_', algorithm, '_', p, '.png', sep='')

	hm = ggplot(data = data, aes(x = dataset, y = method)) +
		geom_tile(aes(fill = error)) +
		scale_fill_gradient2(
			name = 'Erro',
			low = 'blue',
			mid = 'white',
			high = 'red',
			limits = c(minError, maxError),
			midpoint = medError
		) +
		geom_text(
			aes(
				label = round(error, 3),
				fontface='bold'
			),
			size=5
		) +
		labs(
			title=title,
			x='Bases de dados',
			y='Métodos de imputação'
		) +
		theme(
			plot.title=element_text(size=13, hjust = 0.5, face='bold'),
			axis.text=element_text(size=13, face='bold'),
			axis.title=element_text(size=13,face='bold'),
			legend.text=element_text(size=13),
			legend.title=element_text(size=13, hjust = -1),
			axis.text.x = element_text(size=13, hjust = 0.5, face='bold')
		)

	ggsave(filename=file, width = 20, height = 12, units = 'cm')
}


generateAnalysis <- function(data, p, minError, maxError, medError) {	
	c45 = data[which(data$algorithm == 'c45'),]
	heatmap(c45, 'C45', p, minError, maxError, medError)

	svm = data[which(data$algorithm == 'svm'),]
	heatmap(svm, 'SVM', p, minError, maxError, medError)

	rf = data[which(data$algorithm == 'rf'),]
	heatmap(rf, 'RF', p, minError, maxError, medError)
}
