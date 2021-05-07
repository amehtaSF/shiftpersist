
# Using a natl_qualtrics phony file in order to subdivide projects
# I can later add other projects and make them individually
all: natl_qualtrics
	
# The FORCE target with no prerequisites forces a recipe to run when FORCE is a prerequisite
FORCE:

clean:
	find output -type f -delete


# Final endpoint for a given project
natl_qualtrics: output/analysis_study2b_natl_qualtrics.html


# -- Analyze data -- #

# Default rule for everything in output folder; looks for Rmd files with same filename
output/%.html: src/analysis/%.Rmd
	Rscript -e 'rmarkdown::render("$<", output_dir="output")'
	
src/analysis/analysis_study2b_natl_qualtrics.Rmd: data/raw/Winter_2020_Survey_EWB_S2B_National_April_26_2021_11_30.csv
src/analysis/analysis_study2b_natl_qualtrics.Rmd: lib/Winter_2020_Survey_EWB_S2B_National_April_26_2021_11_30_codebook.xlsx

# -- Gather data -- #

# Whenever we run gather, we use FORCE since the original data source is not being checked by Make
gather: FORCE
	bash src/gather/gather_natl_qualtrics_data.sh;
	
lib/Winter_2020_Survey_EWB_S2B_National_April_26_2021_11_30_codebook.xlsx: src/gather/gather_natl_qualtrics_data.sh
	bash src/gather/gather_natl_qualtrics_data.sh;
data/raw/Winter_2020_Survey_EWB_S2B_National_April_26_2021_11_30.csv: src/gather/gather_natl_qualtrics_data.sh
	bash src/gather/gather_natl_qualtrics_data.sh;
