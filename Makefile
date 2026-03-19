PACKAGE := infufrgs
VERSION := $(shell sed -n '1{s/^Version[[:space:]]*//;p;q;}' CHANGELOG)
ARCHIVE := $(PACKAGE).tgz

DOC_SOURCE := infufrgs-doc.tex
DOC_PDF := infufrgs-doc.pdf
DOC_AUX := infufrgs-doc.aux infufrgs-doc.log infufrgs-doc.out infufrgs-doc.toc

EXAMPLE_SOURCE := infufrgs-example.tex
EXAMPLE_PDF := infufrgs-example.pdf
EXAMPLE_BASENAME := $(basename $(EXAMPLE_PDF))
EXAMPLE_AUX := infufrgs-example.aux infufrgs-example.bbl infufrgs-example.blg infufrgs-example.lof infufrgs-example.log \
	infufrgs-example.lot infufrgs-example.out infufrgs-example.toc

PDFS := $(DOC_PDF) $(EXAMPLE_PDF)
ARCHIVE_CONTENTS := $(wildcard *.tex) $(wildcard *.bib) README.md CHANGELOG COPYING \
	infufrgs.cls $(PDFS)

.PHONY: all pdfs package clean

all: package

pdfs: $(PDFS)

package: pdfs
	tar -czf "$(ARCHIVE)" --transform "s,^,$(PACKAGE)/," -- $(ARCHIVE_CONTENTS)

$(DOC_PDF): $(DOC_SOURCE) infufrgs.cls
	pdflatex -interaction=nonstopmode -halt-on-error -jobname="$(basename $@)" $(DOC_SOURCE)
	pdflatex -interaction=nonstopmode -halt-on-error -jobname="$(basename $@)" $(DOC_SOURCE)

$(EXAMPLE_PDF): $(EXAMPLE_SOURCE) infufrgs-example.bib infufrgs.cls
	pdflatex -interaction=nonstopmode -halt-on-error -jobname="$(basename $@)" $(EXAMPLE_SOURCE)
	bibtex "$(EXAMPLE_BASENAME)"
	pdflatex -interaction=nonstopmode -halt-on-error -jobname="$(basename $@)" $(EXAMPLE_SOURCE)
	pdflatex -interaction=nonstopmode -halt-on-error -jobname="$(basename $@)" $(EXAMPLE_SOURCE)

clean:
	rm -f $(PDFS) $(DOC_AUX) $(EXAMPLE_AUX)
	rm -f "$(ARCHIVE)"
