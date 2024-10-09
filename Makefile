DATE := $(shell date +%Y-%m-%d)
PDF_FILE := Ava_Hajratwala_resume_$(DATE).pdf

all: $(PDF_FILE) update-readme

$(PDF_FILE): resume.tex
	@pdflatex -file-line-error -interaction=nonstopmode -synctex=1 -output-format=pdf -output-directory=/Users/ava/github/resume/out resume.tex
	@cp /Users/ava/github/resume/out/resume.pdf $(PDF_FILE)
	@open $(PDF_FILE)
	@rm /Users/ava/github/resume/out/resume.pdf

update-readme: $(PDF_FILE)
	@echo "# resume" > README.md
	@echo "<embed src=\"$(PDF_FILE)\" width=\"800px\" height=\"2100px\" />" >> README.md

.PHONY: clean
clean:
	@rm -rf /Users/ava/github/resume/out
	@mkdir /Users/ava/github/resume/out