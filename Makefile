.SECONDARY:

all: resume.pdf

clean:
	rm -f *.xml *.blg *.bcf *.log *.pdf *.bbl

resume.pdf: resume.tex
	pdflatex $(patsubst %.tex,%,$^)
	biber $(patsubst %.tex,%,$^)
	pdflatex $(patsubst %.tex,%,$^)
	pdflatex $(patsubst %.tex,%,$^)
	
resume.tex: resume.md papers.bib template.tex
	pandoc --filter pandoc-citeproc --biblio papers.bib --biblatex --template $(word 3,$^) $(word 1,$^) -o $@
