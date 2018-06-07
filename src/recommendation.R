library('RWeka')
library('ggplot2')


heatmapRecomendation = function(data, minError, maxError, medError) {

	name = list.files(path = '../datasets/original/', pattern = '*.arff', recursive=TRUE)
	name = tools::file_path_sans_ext(name)

	title = 'Erro dos modelos gerados'

	file = paste('../plots/', name,'.png', sep='')

	hm = ggplot(data = data, aes(x = algorithm, y = method)) +
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
			x='Algoritmos de AM',
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
