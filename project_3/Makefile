pull-pandas:
	docker pull amancevice/pandas:0.25.2-slim && touch $@

pull_tidyverse:
	docker pull rocker/tidyverse && touch $@

results/dataframe1.csv: pull-pandas scripts/generate_dataframe1.py
	docker run -it --rm \
	-v $(shell pwd):/workdir \
	-w /workdir \
	amancevice/pandas:0.25.2-slim \
		python scripts/generate_dataframe1.py 

results/dataframe2.csv: pull-pandas scripts/generate_dataframe2.py
	docker run -it --rm \
	-v $(shell pwd):/workdir \
	-w /workdir \
	amancevice/pandas:0.25.2-slim \
		python scripts/generate_dataframe2.py 

results/avg_stay_time.png \
results/visit_number.png \
results/lenth_of_stay.png \
results/rent_price.png \
results/unemployment_rate.png : pull_tidyverse \
						results/dataframe1.csv \
						results/dataframe2.csv \
						scripts/generate_figure.R
	docker run -it --rm \
	-v $(shell pwd):/workdir \
	-w /workdir rocker/tidyverse \
	Rscript scripts/generate_figure.R

results/report.html: results/report.Rmd \
					results/avg_stay_time.png \
					results/visit_number.png \
					results/lenth_of_stay.png \
					results/rent_price.png \
					results/unemployment_rate.png 
	docker run -it --rm \
	-v $(shell pwd):/workdir \
	-w /workdir rocker/tidyverse \
	Rscript -e "library(rmarkdown); rmarkdown::render('results/report.Rmd', 'html_document')"