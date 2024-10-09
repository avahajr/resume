DATE := $(shell date +%Y-%m-%d)
PDF_FILE := Ava_Hajratwala_resume_$(DATE).pdf
IMAGE_FILE := Ava_Hajratwala_resume_$(DATE).png

all: $(IMAGE_FILE) update-readme

$(PDF_FILE): resume.tex
	@rm -f Ava_Hajratwala_resume_*.pdf
	@pdflatex -file-line-error -interaction=nonstopmode -synctex=1 -output-format=pdf -output-directory=/Users/ava/github/resume/out resume.tex
	@cp /Users/ava/github/resume/out/resume.pdf $(PDF_FILE)
	@rm /Users/ava/github/resume/out/resume.pdf

$(IMAGE_FILE): $(PDF_FILE)
	@magick -density 300 $(PDF_FILE) -background white -alpha remove -flatten -quality 90 $(IMAGE_FILE)

update-readme: $(IMAGE_FILE)
	@echo "# resume" > README.md
	@echo "![Resume](./$(IMAGE_FILE))" >> README.md
	@echo "[PDF Here](./$(PDF_FILE))" >> README.md

.PHONY: clean
clean:
	@rm -rf /Users/ava/github/resume/out
	@mkdir /Users/ava/github/resume/out
	@rm -f Ava_Hajratwala_resume_*.pdf Ava_Hajratwala_resume_*.png