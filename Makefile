DATE := $(shell date +%Y-%m-%d)
PDF_FILE := Ava_Hajratwala_resume_$(DATE).pdf
IMAGE_FILE := Ava_Hajratwala_resume_$(DATE).png

all: $(IMAGE_FILE) update-readme

$(PDF_FILE): resume.tex
	@rm -f Ava_Hajratwala_resume_*.pdf  ~/Documents/job-apps/$(PDF_FILE)
	@pdflatex -file-line-error -interaction=nonstopmode -synctex=1 -output-format=pdf -output-directory=/Users/ava/github/resume/out resume.tex
	@cp ./out/resume.pdf $(PDF_FILE)
	@cp ./out/resume.pdf ~/Documents/job-apps/$(PDF_FILE)
	@rm ./out/resume.pdf
	@echo "PDF created: $(PDF_FILE)"

$(IMAGE_FILE): $(PDF_FILE)
	@rm -f Ava_Hajratwala_resume_*.png
	@magick -density 300 $(PDF_FILE) -background white -alpha remove -flatten -quality 90 $(IMAGE_FILE)

update-readme: $(IMAGE_FILE)
	@echo "# Ava's resume" > README.md
	@echo "Last updated: $(DATE)" >> README.md
	@echo "![Resume](./$(IMAGE_FILE))" >> README.md
	@echo "[PDF Here](./$(PDF_FILE))" >> README.md

.PHONY: clean
clean:
	@rm -rf ./out
	@mkdir ./out
	@rm -f Ava_Hajratwala_resume_*.pdf Ava_Hajratwala_resume_*.png