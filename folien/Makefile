default: pdf
wiki2beamer:
	wiki2beamer git.wiki > git.tex
dvi: wiki2beamer
	latex git
pdf: wiki2beamer
	pdflatex git
clean:
	git clean -fx
