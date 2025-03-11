DATE := $(shell date +%Y-%m-%d)
TIME := $(shell date +%H:%M:%S)
PDF_FILE := Ava_Hajratwala_resume_$(DATE).pdf
IMAGE_FILE := Ava_Hajratwala_resume_$(DATE).png
RESUME_DIR := ~/Documents/job-apps/resume

all: clean $(IMAGE_FILE) README.md

$(PDF_FILE): resume.tex
	@rm -f Ava_Hajratwala_resume_*.pdf
	@echo "Creating PDF..."
	@pdflatex -file-line-error -interaction=nonstopmode -synctex=1 -output-format=pdf -output-directory=./out resume.tex > /dev/null
	@cp ./out/resume.pdf $(PDF_FILE)

.PHONY: move-around
move-around: $(PDF_FILE)
	@find $(RESUME_DIR) -maxdepth 1 -name '*_resume_*.pdf' ! -name '$(PDF_FILE)' -exec mv {} $(RESUME_DIR)/old/ \;
	@cp $(PDF_FILE) $(RESUME_DIR)/$(PDF_FILE)
	@cp ./out/resume.pdf $(RESUME_DIR)/$(PDF_FILE)
	@rm ./out/resume.pdf
	@echo "PDF created: $(PDF_FILE)"

$(IMAGE_FILE): move-around
	@echo "Creating PNG..."
	@rm -f Ava_Hajratwala_resume_*.png
	@magick -density 300 $(PDF_FILE) -background white -alpha remove -flatten -quality 90 $(IMAGE_FILE)
	@echo "PNG created: $(IMAGE_FILE)"

README.md: $(IMAGE_FILE)
	@printf "Updating README... "
	@echo "# Ava's resume" > README.md
	@echo "Last updated: $(DATE) at $(TIME)" >> README.md
	@echo "![Resume](./$(IMAGE_FILE))" >> README.md
	@echo "[PDF Here](./$(PDF_FILE))" >> README.md
	@printf "done.\n"
.PHONY: clean
clean:
	@printf "Cleaning up old files... "
	@rm -rf ./out
	@mkdir ./out
	@rm -f Ava_Hajratwala_resume_*.pdf Ava_Hajratwala_resume_*.png
	@printf "done.\n"