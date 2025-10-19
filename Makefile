sprawko:
	pdflatex tex/BDBT.tex
	pdflatex tex/BDBT.tex
	evince BDBT.pdf

clean:
	rm -rf BDBT*
