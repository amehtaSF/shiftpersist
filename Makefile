
all: natl_qualtrics uw_qualtrics
	
FORCE:

clean:
	find results -type f -delete


natl_qualtrics: results/analysis_study2b_natl_qualtrics.html

uw_qualtrics: results/analysis_study2a_uw_pool2.html

alx: results/alexithymia_study2b_natl_qualtrics.html

# -------------------------------- #
# -- Study 2 National Qualtrics -- # 
# -------------------------------- #

raw_data_file = data/raw/2021-06-03/national_study_2b_raw.xlsx
proc_data_file = data/proc/national_study_2b_proc.csv
codebook_file = doc/Winter_2020_Survey_EWB_S2B_National_April_26_2021_11_30_codebook.xlsx

# -- Analyze data -- #

results/%.html: src/analysis/%.Rmd $(proc_data_file)
	Rscript -e 'rmarkdown::render("$<", output_dir="results", params=list(inputfile="$(proc_data_file)")'
	
# src/analysis/analysis_study2b_natl_qualtrics.Rmd: $(proc_data_file)

# src/analysis/alexithymia_study2b_natl_qualtrics.Rmd: $(proc_data_file)

# -- Preproc data -- #

preproc: $(proc_data_file)

$(proc_data_file): src/preproc/study2b_natl_qualtrics_preproc.Rmd
	Rscript -e 'rmarkdown::render("$<", params=list(inputfile="$(raw_data_file)", \
	codebookfile="$(codebook_file)", \
	outputfile="$(proc_data_file)"))'
