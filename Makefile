SRC = $(wildcard *.md)

PDFS=$(SRC:.md=.pdf)
HTML=$(SRC:.md=.html)
DOC=$(SRC:.md=.docx)
LATEX_TEMPLATE=./pandoc-templates/default.latex
GRAVATAR_OPTION=--no-gravatar

all:    clean $(PDFS) $(HTML) $(DOC)

pdf:   clean $(PDFS)
html:  clean $(HTML)
docx:   clean $(DOC)

%.html: %.md
	python resume.py html $(GRAVATAR_OPTION) < $< | pandoc -t html -c resume.css -o $@

%.docx: %.md
	python resume.py passthrough < $< | pandoc -t docx -o $@

%.pdf:  %.md $(LATEX_TEMPLATE)
	python resume.py tex < $< | pandoc --template=$(LATEX_TEMPLATE) -H header.tex -o $@

clean:
	rm -f *.html *.pdf *.docx

$(LATEX_TEMPLATE):
	git submodule update --init
