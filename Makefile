all: resume.pdf README.md

clean:
	rm -f *.xml *.blg *.bcf *.log *.pdf *.bbl

%.pdf: %.tex
	pdflatex $*
	biber $*
	pdflatex $*
	pdflatex $*
	
resume.tex: resume.md template.tex refs.bib
	pandoc --filter pandoc-citeproc --biblatex --biblio refs.bib --template $(word 2,$^) -o $@ $(word 1,$^)

README.md: resume.md
	pandoc -o $@ $^
