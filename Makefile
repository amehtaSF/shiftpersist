
all: natl_qualtrics uw_qualtrics
	
FORCE:

clean:
	find results -type f -delete


natl_qualtrics: results/analysis_study2b_natl_qualtrics.html

uw_qualtrics: results/analysis_study2a_uw_pool2.html


# -- Analyze data -- #

results/%.html: src/analysis/%.Rmd
	Rscript -e 'rmarkdown::render("$<", output_dir="results")'
	
src/analysis/analysis_study2b_natl_qualtrics.Rmd: data/proc/national_study_2b_proc.csv
src/analysis/analysis_study2b_natl_qualtrics.Rmd: lib/Winter_	2020_Survey_EWB_S2B_National_April_26_2021_11_30_codebook.xlsx

# -- Preproc data -- #

preproc: data/proc/national_study_2b_proc.csv

data/proc/national_study_2b_proc.csv: src/preproc/study2b_natl_qualtrics_preproc.Rmd
	Rscript -e 'rmarkdown::render("$<")'

# -- Gather data -- # 