default:
	make pdf
wiki2beamer:
	wiki2beamer git.wiki > git.tex
dvi:
	make wiki2beamer
	latex git
pdf:
	make wiki2beamer
	pdflatex git
