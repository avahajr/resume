.PHONY: all
all:
	pdflatex -file-line-error -interaction=nonstopmode -synctex=1 -output-format=pdf -output-directory=/Users/ava/github/resume/out resume.tex
	cp out/resume.pdf Ava_Hajratwala_resume_$(shell date +%Y-%m-%d).pdf
	open Ava_Hajratwala_resume_$(shell date +%Y-%m-%d).pdf
	rm out/resume.pdf
.PHONY: clean
clean:
	rm -rf out
	mkdir out