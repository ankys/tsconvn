
#
# Makefile for ankys mathwork version 20210517
# Copyright 2021 Atsushi Nakayasu. MIT License.
#

TEX=tex.pl
# TEXMK=latexmk -silent -Werror
BIBTEX=bibtex
INKSCAPE=inkscape
BB=extractbb

TEXM:=$(shell $(TEX) -F $(wildcard *.tex))
# TEXM:=$(shell grep -l '^[^%]*\\begin{document}' *.tex)
SRC:=$(TEXM)
TRG:=$(SRC:.tex=.pdf)
VERSION:=$(shell date +%Y%m%d)
EXF:=\
	\$$RECYCLE.BIN \
	Thumbs.db \
	.Trashes \
	.fseventsd \
	.TemporaryItems \
	.DS_Store \
	._* \
	*.settings \
	*.stackdump \
	*.bak \
	\\\#*\\\# \
	.\\\#* \
	*~ \
	.*~ \
	*.a \
	*.out \
	*.dll \
	*.exe \
	*.dvi \
	*.pdvi \
	*.aux \
	*.log \
	*.nav \
	*.idx \
	*.out \
	*.snm \
	*.toc \
	*.tdo \
	*.fdb_latexmk \
	*.fls \
	*.synctex.gz \
	*.bbl \
	*.blg \
	*.ps \
	*.pdf \
	*.eps \
	*.eps_tex \
	*.pdf_tex \
	*.md.tex \
	*.md.b.tex \
	*.bb \
	*.xbb \

.DEFAULT_GOAL=all

README=Readme.txt
RELEASE=Release~
DEPENDS=.depends~

-include $(README)
ifneq ($(MAKECMDGOALS),clean)
-include $(DEPENDS)
endif

# .PHONY: $(DEPENDS)
$(DEPENDS):
	$(TEX) -M $(TEXM) > $@
# $(DEPENDS):
# 	export TEMP=$$(mktemp -d) && $(TEXMK) -pdfdvi -outdir=$$TEMP -deps -deps-out=$@ && rm -rf $$TEMP

.SUFFIXES:
%.pdf: %.tex
	$(TEX) $<
# %.pdf: %.tex
# 	export TEMP=$$(mktemp -d) && $(TEXMK) -pdfdvi -outdir=$$TEMP $< && mv $$TEMP/$@ $@ && rm -rf $$TEMP
# %.dvi: %.tex
# 	$(TEX) --synctex -c $<
# %.aux: %.tex
# 	$(TEX) -S $<
# %.bbl: %.aux
# 	$(BIBTEX) $<; ret=$$?; rm -f $*.blg; exit $$ret
%.eps_tex: %.svg
	$(INKSCAPE) -z $< --export-eps=$*.eps --export-latex
%.pdf_tex: %.svg
	$(INKSCAPE) -z $< --export-pdf=$*.pdf --export-latex
	$(BB) $*.pdf
%.md.tex: %.md
	pandoc -fmarkdown -tlatex $< -o$@
%.md.b.tex: %.md
	pandoc -fmarkdown -tbeamer $< -o$@
# %-$(VERSION).tex: %.tex
# 	$(TEX) -E $< > $@

.PHONY: all clean release gettarget
all: $(TRG)
clean:
	rm -rf $(EXF)
release: $(TRG:.pdf=-$(VERSION).tex) $(TRG:.pdf=-$(VERSION).pdf)
	rm -rf $(RELEASE)
	mkdir -p $(RELEASE)
	mv $(TRG:.pdf=-$(VERSION).pdf) $(RELEASE)
	mv $(TRG:.pdf=-$(VERSION).tex) $(RELEASE)
gettarget:
	echo "$(TRG)"
