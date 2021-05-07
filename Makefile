
# Using a natl_qualtrics phony file in order to subdivide projects
# I can later add other projects and make them individually
all: natl_qualtrics
	
# The FORCE target with no prerequisites forces a recipe to run when FORCE is a prerequisite
FORCE:

# Whenever we run gather, we want to regather the data since the original data source is not being checked
gather: FORCE
	bash src/gather/gather_natl_qualtrics_data.sh;
	
clean:
	find output -type f


# Here we add all the endpoints of the DAG for natl_qualtrics
# natl_qualtrics: data/raw/Winter_2020_Survey_EWB_S2B_National_April_26_2021_11_30.csv 
# natl_qualtrics: lib/Winter_2020_Survey_EWB_S2B_National_April_26_2021_11_30_codebook.xlsx
natl_qualtrics: output/analysis_study2b_natl_qualtrics.html


data/raw/Winter_2020_Survey_EWB_S2B_National_April_26_2021_11_30.csv: src/gather/gather_natl_qualtrics_data.sh
	bash src/gather/gather_natl_qualtrics_data.sh;

lib/Winter_2020_Survey_EWB_S2B_National_April_26_2021_11_30_codebook.xlsx: src/gather/gather_natl_qualtrics_data.sh
	bash src/gather/gather_natl_qualtrics_data.sh;

src/analysis/analysis_winter_natl_qualtrics.Rmd: data/raw/Winter_2020_Survey_EWB_S2B_National_April_26_2021_11_30.csv
src/analysis/analysis_winter_natl_qualtrics.Rmd: lib/Winter_2020_Survey_EWB_S2B_National_April_26_2021_11_30_codebook.xlsx


# Default rule for everything in output folder; looks for Rmd files with same filename
output/%.html: src/analysis/%.Rmd
	Rscript -e 'rmarkdown::render("$<", output_dir="output")'
	
