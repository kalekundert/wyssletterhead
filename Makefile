NAME  = wyssletter
SHELL = bash
PWD   = $(shell pwd)
VERS  = $(shell ltxfileinfo -v $(NAME).dtx|sed -e 's/^v//')
LOCAL = $(shell kpsewhich --var-value TEXMFLOCAL)
UTREE = $(shell kpsewhich --var-value TEXMFHOME)
LYX   = /usr/share/lyx
ULYX  = $(HOME)/.lyx
all:	$(NAME).pdf
	test -e README.txt && mv README.txt README || exit 0
$(NAME).pdf: $(NAME).dtx
	pdflatex -shell-escape -recorder -interaction=batchmode $(NAME).dtx >/dev/null
	if [ -f $(NAME).glo ]; then makeindex -q -s gglo.ist -o $(NAME).gls $(NAME).glo; fi
	if [ -f $(NAME).idx ]; then makeindex -q -s gind.ist -o $(NAME).ind $(NAME).idx; fi
	pdflatex --recorder --interaction=nonstopmode $(NAME).dtx > /dev/null
	pdflatex --recorder --interaction=nonstopmode $(NAME).dtx > /dev/null
clean:
	rm -f $(NAME).{aux,fls,glo,gls,hd,idx,ilg,ind,ins,log,out}
distclean: clean
	rm -f $(NAME).{pdf,cls} README
inst: all
	mkdir -p $(UTREE)/{tex,source,doc}/latex/$(NAME)
	cp $(NAME).dtx $(UTREE)/source/latex/$(NAME)
	cp $(NAME).cls $(UTREE)/tex/latex/$(NAME)
	cp $(NAME).pdf $(UTREE)/doc/latex/$(NAME)
	mkdir -p $(ULYX)/layouts/
	cp $(NAME).layout $(ULYX)/layouts/
install: all
	sudo mkdir -p $(LOCAL)/{tex,source,doc}/latex/$(NAME)
	sudo cp $(NAME).dtx $(LOCAL)/source/latex/$(NAME)
	sudo cp $(NAME).cls $(LOCAL)/tex/latex/$(NAME)
	sudo cp $(NAME).pdf $(LOCAL)/doc/latex/$(NAME)
	mkdir -p $(LYX)/layouts/
	cp $(NAME).layout $(LYX)/layouts/
zip: all
	ln -sf . $(NAME)
	zip -Drq $(PWD)/$(NAME)-$(VERS).zip $(NAME)/{README,$(NAME).{pdf,dtx,layout}}
	rm $(NAME)
