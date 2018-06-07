#!/bin/bash

missing() {
	echo 'Generating datasets with missing values...'
	echo
	Rscript generateMissing.R
	echo
	echo 'Done!'
}

impute() {
	echo 'Applying imputations...'
	echo
	Rscript generateImputation.R "$1"
	echo
	echo 'Done!'
}

models() {
	echo 'Applying ML algorithms to datasets...'
	echo
	Rscript generateModels.R "$1"
	echo
	echo 'Done!'
}

analysis() {
	echo 'Generating analysis...'
	echo
	Rscript generateAnalysis.R "$1"
	echo
	echo 'Done!'
}

help() {
	echo 'usage: ./run recommendation|analysis'
}

# Check if there's an argument.
[ "$1" ] || {
	help
	exit
}

rm -f ../datasets/missing/05/*.arff 
rm -f ../datasets/missing/15/*.arff 
rm -f ../datasets/missing/25/*.arff 
rm -f ../datasets/imputed/05/*.arff
rm -f ../datasets/imputed/15/*.arff
rm -f ../datasets/imputed/25/*.arff
rm -f ../datasets/imputed/user/*.arff
rm -f ../datasets/result/*.arff
rm -f ../plots/*.png

# Execute R scripts.
case "$1" in
	analysis)
		missing
		;&
	recommendation)
		impute "$1"
		models "$1"
		analysis "$1"
		;;
	*)
		echo 'error: wrong argument'
		exit
esac
