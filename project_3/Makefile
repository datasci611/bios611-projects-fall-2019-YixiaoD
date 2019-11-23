pull-pandas:
	docker pull amancevice/pandas:0.25.2-slim && touch $@

pull_tidyverse:
	docker pull rocker/tidyverse && touch $@

lenth_of_stay-unemployment_rate_and_rent_price.csv: pull-pandas \
							scripts/generate_dataframes.py
	docker run -it --rm \
	-v $(shell pwd):/workdir \
	-w /workdir \
	amancevice/pandas:0.25.2-slim \
		python scripts/generate_dataframes.py 

results/lenth_of_stay.png \
results/rent_price.png \
results/unemployment_rate.png : scripts/generate_figure.R \
				lenth_of_stay-unemployment_rate_and_rent_price.csv \
				pull_tidyverse
	docker run -it --rm \
	-v $(shell pwd):/workdir \
	-w /workdir rocker/tidyverse \
	Rscript scripts/generate_figure.R