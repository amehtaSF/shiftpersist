
all: natl_qualtrics uw_qualtrics
	
FORCE:

clean:
	find results -type f -delete


natl_qualtrics: results/analysis_study2b_natl_qualtrics.html

uw_qualtrics: results/analysis_study2a_uw_pool.html

alx: results/alexithymia_study2b_natl_qualtrics.html

# --------------------------------- #
# -- Study 2b National Qualtrics -- # 
# --------------------------------- #

natl_raw_data_file = data/raw/2021-06-03/national_study_2b_raw.xlsx
natl_proc_data_file = data/proc/national_study_2b_proc.csv
natl_codebook_file = doc/Winter_2020_Survey_EWB_S2B_National_April_26_2021_11_30_codebook.xlsx

# -- Analyze data -- #

results/analysis_study2b_natl_qualtrics.html: src/analysis/analysis_study2b_natl_qualtrics.Rmd $(natl_proc_data_file)
	Rscript -e 'rmarkdown::render("$<", output_dir="results", params=list(inputfile="$(natl_proc_data_file)"))'
	

# -- Preproc data -- #

preproc_natl: $(natl_proc_data_file)

$(natl_proc_data_file): src/preproc/study2b_natl_qualtrics_preproc.Rmd
	Rscript -e 'rmarkdown::render("$<", params=list(inputfile="$(natl_raw_data_file)", \
	codebookfile="$(natl_codebook_file)", \
	outputfile="$(natl_proc_data_file)"))'


# -------------------------------- #
# -- Study 2a UW pool Qualtrics -- # 
# -------------------------------- #

uw_raw_data_file = data/raw/Study_2A_UW_Psych_Pool_EWB_GB.xlsx
uw_proc_data_file = data/proc/uw_study_2a_proc.csv
uw_codebook_file = doc/Codebook_Study_2a_Psych_Pool_Winter2021_EWB_Shift_Persist.xlsx

# -- Analyze data -- #

results/analysis_study2a_uw_pool.html: src/analysis/analysis_study2a_uw_pool.Rmd $(uw_proc_data_file)
	Rscript -e 'rmarkdown::render("$<", output_dir="results", params=list(inputfile="$(uw_proc_data_file)"))'
	

# -- Preproc data -- #

preproc_uw: $(uw_proc_data_file)

$(proc_data_file): src/preproc/study2b_natl_qualtrics_preproc.Rmd
	Rscript -e 'rmarkdown::render("$<", params=list(inputfile="$(uw_raw_data_file)", \
	codebookfile="$(uw_codebook_file)", \
	outputfile="$(uw_proc_data_file)"))'