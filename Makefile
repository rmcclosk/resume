all: resume.pdf resume.html README.md

clean:
	rm -f *.xml *.blg *.bcf *.log *.pdf *.bbl

%.pdf: %.tex
	pdflatex $*
	biber $*
	pdflatex $*
	pdflatex $*
	
resume.tex: resume.md template.tex refs.bib
	pandoc --filter pandoc-citeproc --biblatex --biblio refs.bib --template $(word 2,$^) -o $@ $(word 1,$^)

resume.html: resume.md full.csl
	pandoc --ascii --filter pandoc-citeproc --csl $(word 2,$^) --biblio refs.bib -t html $(word 1,$^) | hxremove div.references > $@

README.md: resume.md md_template.html full.csl
	pandoc --filter pandoc-citeproc --template $(word 2,$^) --csl $(word 3,$^) --biblio refs.bib -t html $(word 1,$^) > $@
