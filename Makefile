sprawko:
	pdflatex tex/BDBT.tex
	pdflatex tex/BDBT.tex
	evince BDBT.pdf &

clean:
	if pgrep evince; then pkill evince; fi
	rm -rf BDBT* _minted
