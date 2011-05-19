#
# UFRGS TeX Users Group
# $Id: Makefile,v 1.1.1.1 2005/01/18 23:54:34 avila Exp $
#
INSTALLDIR = /usr/local/iiufrgs
INPUTS = $(INSTALLDIR)/tex/latex/iiufrgs
DOC = $(INSTALLDIR)/doc/latex/iiufrgs

all:
	@echo "Digite \`\`make install'' para instalar o pacote."
	@echo "Por padrão, os arquivos serão instalados a partir de $(INSTALLDIR)"
	@echo "Você pode mudar essa configuração alterando a variável INSTALLDIR, no Makefile"
	@echo

install:
	install -d $(INPUTS) $(DOC)
	cp -R inputs/* $(INPUTS)
	cp -R exemplos/* MINI-HOWTO-prosper.txt $(DOC)
	cp README GPL CHANGELOG BUGS $(INSTALLDIR)
	@echo
	@echo "Arquivos instalados com sucesso."
	@echo
	@echo "Para o iiufrgs ser incluído no path padrão do LaTeX:"
	@echo "# cd /usr/local/share/texmf/tex/latex"
	@echo "# ln -sf $(INSTALLDIR)/tex/latex/iiufrgs"
	@echo "# mktexlsr"
	@echo
	@echo "Bom trabalho. ;-)"