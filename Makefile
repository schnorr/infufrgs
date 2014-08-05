#
# UFRGS TeX Users Group
# $Id: Makefile,v 1.1.1.1 2005/01/18 23:54:34 avila Exp $
#

# DO NOT CHANGE
# This is the default user package directory, by installing here
# there is no need to run mktexlsr or to use sudo
DEFAULT_INSTALLDIR = $(HOME)/texmf/

# USER CONFIG
INSTALLDIR = $(DEFAULT_INSTALLDIR)

INPUTS = $(INSTALLDIR)/tex/latex/iiufrgs
DOC = $(INSTALLDIR)/doc/latex/iiufrgs
BIB = $(INSTALLDIR)/bibtex/bst

all:
	@echo "Digite \`\`make install'' para instalar o pacote."
	@echo
	@echo "Por padrão, os arquivos serão instalados a partir de $(DEFAULT_INSTALLDIR),"
	@echo "e o pacote deve ser encontrado automaticamente pelo latex."
	@echo
	@echo "Você pode mudar essa configuração alterando a variável INSTALLDIR no Makefile,"
	@echo "neste caso pode ser necessário adicionar o diretório ao caminho padrão do latex,"
	@echo "digitando \`\`make add_to_latex_default_path\`\` após a instalação."
	@echo

install:
	install -d $(INPUTS) $(DOC) $(BIB)
	cp -R inputs/* $(INPUTS)
	cp inputs/abnt-ufrgs.bst $(BIB)
	cp README.md COPYING CHANGELOG BUGS $(INSTALLDIR)
	@echo
	@echo "Arquivos instalados com sucesso em $(INSTALLDIR)."
	@echo
	@echo "Caso o latex ainda não ache o pacote:"
	@echo "make add_to_latex_default_path"
	@echo
	@echo "Bom trabalho. ;-)"

add_to_latex_default_path: $(INSTALLDIR)/tex/latex/iiufrgs
	ln -sf $(INSTALLDIR)/tex/latex/iiufrgs /usr/local/share/texmf/tex/latex/
	mktexlsr
