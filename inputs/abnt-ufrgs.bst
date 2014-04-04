%==============================================================================
% abnt.bst
% Estilo BibTeX de formatação de referências bibliográficas no padrão ABNT
%
% UFRGS TeX Users Group
% Informatics Institute --- UFRGS
% Porto Alegre, Brazil
% http://www.inf.ufrgs.br/utug
% Discussion list: utug-l@inf.ufrgs.br
%
% $Id: abnt.bst,v 5.7 2003/04/15 15:09:10 avila Exp $
%
% Copyright (C) 2001-2003 UFRGS TeX Users Group
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
%==============================================================================

%==============================================================================
% Definição dos campos das entradas
%==============================================================================
ENTRY
{ 
	author
	editor
	title
	booktitle
	chapter
	pages
	address
	publisher
	year
	journal
	month
	number
	edition
	howpublished
	institution
	key
	note
	organization
	school
	series
	type
	volume
}
{}
{
	label
	year.char
}

INTEGERS {i j n}
STRINGS {s t last.label last.year.char current.letter names new.pages}

%==============================================================================
% Definicao dos nomes dos meses
%==============================================================================
MACRO {jan} {"Jan."}
MACRO {feb} {"Feb."}
MACRO {mar} {"Mar."}
MACRO {apr} {"Apr."}
MACRO {may} {"May"}
MACRO {jun} {"June"}
MACRO {jul} {"July"}
MACRO {aug} {"Aug."}
MACRO {sep} {"Sept."}
MACRO {oct} {"Oct."}
MACRO {nov} {"Nov."}
MACRO {dec} {"Dec."}

%==============================================================================
% Definicao de strings usados na elaboracao das referencias
%==============================================================================
FUNCTION {str:mastersthesis} {"Disserta{\c{c}}{\~a}o (Mestrado em Ci{\^e}ncia da Computa{\c{c}}{\~a}o)"}
FUNCTION {str:phdthesis} {"Tese (Doutorado em Ci{\^e}ncia da Computa{\c{c}}{\~a}o)"}
FUNCTION {str:chapter} {"Cap."}

%==============================================================================
% Definicao das abreviaturas padrao
%==============================================================================
MACRO {acmcs} {"ACM Computing Surveys"}
MACRO {acta} {"Acta Informatica"}
MACRO {cacm} {"Communications of the ACM"}
MACRO {ibmjrd} {"IBM Journal of Research and Development"}
MACRO {ibmsj} {"IBM Systems Journal"}
MACRO {ieeese} {"IEEE Transactions on Software Engineering"}
MACRO {ieeetc} {"IEEE Transactions on Computers"}
MACRO {ieeetcad}
	{"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}
MACRO {ipl} {"Information Processing Letters"}
MACRO {jacm} {"Journal of the ACM"}
MACRO {jcss} {"Journal of Computer and System Sciences"}
MACRO {scp} {"Science of Computer Programming"}
MACRO {sicomp} {"SIAM Journal on Computing"}
MACRO {tocs} {"ACM Transactions on Computer Systems"}
MACRO {tods} {"ACM Transactions on Database Systems"}
MACRO {tog} {"ACM Transactions on Graphics"}
MACRO {toms} {"ACM Transactions on Mathematical Software"}
MACRO {toois} {"ACM Transactions on Office Information Systems"}
MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}
MACRO {tcs} {"Theoretical Computer Science"}

%==============================================================================
% Exibe warning quando um campo ``required'' esta' faltando. Recebe na pilha o
% tipo do campo.
%==============================================================================
FUNCTION {show.missing.field.warning}
{
	"Falta o campo " swap$ " em " cite$ * * * warning$
}

%==============================================================================
% Funcoes logicas
%==============================================================================
FUNCTION {not}
{
		{ #0 }
		{ #1 }
	if$
}

FUNCTION {and}
{
		'skip$
		{ pop$ #0 }
	if$
}

FUNCTION {or}
{
		{ pop$ #1 }
		'skip$
	if$
}

FUNCTION {is.numeric.char}
{
	#1 #1 substring$
	duplicate$ "" =
		{pop$ #0}
		{
			duplicate$ chr.to.int$ #47 >
			swap$ chr.to.int$ #58 <
			and
		}
	if$
}

FUNCTION {is.uppercase.char}
{
	#1 #1 substring$
	duplicate$ "" =
		{pop$ #0}
		{
			duplicate$ chr.to.int$ #64 >
			swap$ chr.to.int$ #91 <
			and
		}
	if$
}

%==============================================================================
% Escreve no arquivo o comando que gera o item
%
% Parm:
%	 um string com a formatacao do item
%==============================================================================
FUNCTION {write.item}
{
	"\bibitem[" label * "]{" * cite$ * "} " *
	swap$ *
	write$ newline$ newline$
}

%==============================================================================
% Separa o titulo em titulo e sub-titulo, empilhando o sub-titulo e o titulo,
% nessa ordem
%
% Parm:
%	 o titulo
%==============================================================================
FUNCTION {extract.subtitle}
{
	#1 'i :=

	duplicate$
	i #1 substring$
	{
		duplicate$ ":" = not
		swap$ "" = not
		and
	}
	{
		#1 i + 'i :=
		duplicate$
		i #1 substring$
	} while$

	duplicate$ i #999 substring$
	swap$
	#1 i #1 - substring$
}

%==============================================================================
% Separa a primeira palavra do texto, empilhando o resto e a palavra, nessa
% ordem
%
% Parm:
%	 o texto
%==============================================================================
FUNCTION {extract.first.word}
{
	#1 'i :=

	duplicate$
	i #1 substring$
	{
		duplicate$ " " = not
		swap$ "" = not
		and
	}
	{
		#1 i + 'i :=
		duplicate$
		i #1 substring$
	} while$

	duplicate$ i #999 substring$
	swap$
	#1 i #1 - substring$
}

%==============================================================================
% Enfatiza um string
%
% Parm:
%	 o string
%==============================================================================
FUNCTION {emphasize}
{
	"\textbf{" swap$ * "}" *
}

%==============================================================================
% Adiciona um texto (se nao-empty$) ja' formatado ao item, separando-o por
% ponto.
% Ex.: NOME. Titulo. data. ano.
%
% Parm:
%	 um string representando o item (pode ser vazio, para iniciar o item)
%	 o texto a ser adicionado
%==============================================================================
FUNCTION {add.to.item}
{
	duplicate$ empty$
		'pop$
		{
			swap$
			duplicate$ empty$
				'skip$
				{" " *}
			if$
			swap$ add.period$ *
		}
	if$
}

%==============================================================================
% Adiciona um item (se nao-empty$) a uma lista do tipo "a, b, c, ..."
%
% Parm:
%	 um string representando a lista (pode ser vazio, para criar uma lista)
%	 o item a ser adicionado
%==============================================================================
FUNCTION {add.to.list}
{
	duplicate$ empty$
		'pop$
		{
			swap$
			duplicate$ empty$
				'skip$
				{", " *}
			if$
			swap$ *
		}
	if$
}

%==============================================================================
% Adiciona um nome a uma lista de nomes (separados por ponto-e-virgula)
%
% Parm:
%	 um string representando a lista (pode ser vazio, para criar uma lista)
%	 o nome a ser adicionado
%==============================================================================
FUNCTION {add.to.namelist}
{
	swap$
	duplicate$ empty$
		'skip$
		{"; " *}
	if$
	swap$ *
}

%==============================================================================
% Formata uma lista de nomes.
%
% Parm:
%	 os nomes a serem formatados
%==============================================================================
FUNCTION {format.names}
{
	duplicate$ num.names$ 'n :=
	#1 'i :=
	"" 'names :=

	{i n #1 + <}
	{
		duplicate$ duplicate$ i "{ll}{~jj}" format.name$
		duplicate$ "others" =
		n #3 >
		i #2 =
		and
		or
		{
			pop$ pop$ names " et~al." *
			n 'i :=
		}{
			"u" change.case$ swap$
			i "{, f.}{~vv}" format.name$ *
			names swap$ add.to.namelist
		} if$ 'names :=
		#1 i + 'i :=
	} while$
	pop$
	names
	duplicate$ #-1 #1 substring$ "." = {
		#-2 global.max$ substring$
		"\@." *
	}
		'skip$
	if$
}

%==============================================================================
% Formata uma lista de sobrenomes.
%
% Parm:
%	 os nomes a serem formatados
%==============================================================================
FUNCTION {format.family.names}
{
	duplicate$ num.names$ 'n :=
	#1 'i :=
	"" 'names :=

	{i n #1 + <}
	{
		duplicate$ i "{ll}{~jj}" format.name$
		duplicate$ "others" =
		n #3 >
		i #2 =
		and
		or
		{
			pop$ names " et~al." *
			n 'i :=
		}{
			"u" change.case$
			names swap$ add.to.namelist
		} if$ 'names :=
		#1 i + 'i :=
	} while$
	pop$
	names
}

%==============================================================================
% Formata uma lista de sobrenomes com todos os autores.
%
% Parm:
%	 os nomes a serem formatados
%==============================================================================
FUNCTION {format.family.names.all}
{
	duplicate$ num.names$ 'n :=
	#1 'i :=
	"" 'names :=

	{i n #1 + <}
	{
		duplicate$ i "{ll}{~jj}" format.name$
		duplicate$ "others" =
		{
			pop$ names " et~al." *
			n 'i :=
		}{
			"u" change.case$
			names swap$ add.to.namelist
		} if$ 'names :=
		#1 i + 'i :=
	} while$
	pop$
	names
}

%==============================================================================
% Formata um titulo (pode ser `title' ou `booktitle')
%
% Parm:
%	 um valor (0 ou 1) que indica se a formatacao deve ser enfatizada ou nao
%	 um string com o titulo a ser formatado
%==============================================================================
FUNCTION {format.title}
{
        swap$
                {extract.subtitle emphasize}
                {extract.subtitle}
        if$
        swap$ "l" change.case$ *
}

%==============================================================================
% Retorna a indicacao de paginas ajustada para ter dois tracos (`--') se a
% entrada so' tiver um.
%==============================================================================
FUNCTION {get.adjusted.pages}
{
	#1 'i :=
	"" 'new.pages :=
	pages #1 #1 substring$
	{duplicate$ "" = not}
	{
		duplicate$ "-" =
		pages i #1 - #1 substring$ "-" = not
		and
		pages i #1 + #1 substring$ "-" = not
		and
			{"-" *}
			'skip$
		if$
		new.pages swap$ * 'new.pages :=
		#1 i + 'i :=
		pages i #1 substring$
	} while$
	pop$
	new.pages
}

%==============================================================================
% Coloca a primeira palavra do titulo em letras maiusculas e o resto em
% minusculas. Esta funcao e' usada para gerar referencias cuja entrada e' pelo
% titulo.
%==============================================================================
FUNCTION {format.entrytitle}
{
	#0 title format.title
	extract.first.word "u" change.case$
	swap$ * 
}

%==============================================================================
% Converte a edicao literal ("First", "Second", etc., que é o padrão indicado
% no manual do BibTeX) para o algarismo correspondente. Recebe na pilha o
% string e devolve o numero.
%==============================================================================
FUNCTION {convert.to.number}
{
	duplicate$ "First" =
	{pop$ "1"}
	{duplicate$ "Second" =
	{pop$ "2"}
	{duplicate$ "Third" =
	{pop$ "3"}
	{duplicate$ "Fourth" =
	{pop$ "4"}
	{duplicate$ "Fifth" =
	{pop$ "5"}
	{duplicate$ "Sixth" =
	{pop$ "6"}
	{duplicate$ "Seventh" =
	{pop$ "7"}
	{duplicate$ "Eighth" =
	{pop$ "8"}
	{duplicate$ "Ninth" =
	{pop$ "9"}
	{duplicate$ "Tenth" =
	{pop$ "10"}
	{skip$
	} if$
	} if$
	} if$
	} if$
	} if$
	} if$
	} if$
	} if$
	} if$
	} if$
}

%=========================================================================
% Formatacao dos campos. Se o campo nao existir a funcao devolve um string
% vazio.
%==============================================================================
FUNCTION {format.author}
{
	author empty$
		{""}
		{author format.names}
	if$
}

FUNCTION {format.editor}
{
	editor empty$
		{""}
		{editor format.names "~(Ed.)" *}
	if$
}

FUNCTION {format.edition}
{
	edition empty$
		{""}
		{edition convert.to.number ".ed." *}
	if$
}

FUNCTION {format.volume}
{
	volume empty$
		{""}
		{"v." volume *}
	if$
}

FUNCTION {format.number}
{
	number empty$
		{""}
		{"n." number *}
	if$
}

FUNCTION {format.month}
{
	month empty$
		{""}
		{month}
	if$
}

FUNCTION {format.address}
{
	address empty$
		{""}
		{address}
	if$
}

FUNCTION {format.publisher}
{
	type$ "mastersthesis" =
	type$ "phdthesis" =
	or {
		school empty$ {""} {school} if$
	}{
	type$ "techreport" = {
		institution empty$ {""} {institution} if$
	}{
	type$ "manual" = {
		organization empty$ {""} {organization} if$
	}{
		publisher empty$ {""} {publisher} if$
	} if$
	} if$
	} if$
}

FUNCTION {format.year}
{
	year empty$
		{""}
		{year}
	if$
}

FUNCTION {format.chapter}
{
	chapter empty$
		{""}
		{
			type empty$
				{str:chapter}
				{type "~" *}
			if$
			chapter *
		}
	if$
}

FUNCTION {format.pages}
{
	pages empty$
		{""}
		{"p." get.adjusted.pages *}
	if$
}

FUNCTION {format.totalpages}
{
	pages empty$
		{""}
		{pages "p." *}
	if$
}

FUNCTION {format.note}
{
	note empty$
		{""}
		{note}
	if$
}

FUNCTION {format.month.year}
{
	month empty$
		{year}
		{month "~" * year *}
	if$
}

FUNCTION {format.type}
{
	type empty$
		'skip$
		{pop$ type}
	if$
}

FUNCTION {format.howpublished}
{
	howpublished empty$
		{""}
		{howpublished}
	if$
}

FUNCTION {format.series}
{
	series empty$
		{""}
		{series}
	if$
}

FUNCTION {format.parenthised.number}
{
	number empty$ {
		""
	}{
		"(" number * ")" *
	} if$
}

%==============================================================================
% As seguintes funcoes adicionam um item a uma lista passada na pilha.
%==============================================================================
FUNCTION {add.address} {format.address add.to.list}
FUNCTION {add.publisher} {format.publisher add.to.list}
FUNCTION {add.year} {format.year add.to.list}
FUNCTION {add.chapter} {format.chapter add.to.list}
FUNCTION {add.edition} {format.edition add.to.list}
FUNCTION {add.volume} {format.volume add.to.list}
FUNCTION {add.number} {format.number add.to.list}
FUNCTION {add.month} {format.month add.to.list}
FUNCTION {add.totalpages} {format.totalpages add.to.list}
FUNCTION {add.pages} {format.pages add.to.list}
FUNCTION {add.note} {format.note add.to.list}
FUNCTION {add.month.year} {format.month.year add.to.list}
FUNCTION {add.howpublished} {format.howpublished add.to.list}

%==============================================================================
% Converte virgula para dois-pontos; usado na formatacao do publisher de
% proceedings e inproceedings, que normalmente levam tambem o local de publi-
% cao; no padrao ABNT essa separacao deve ser por dois-pontos.
% Recebe o string original e devolve o novo.
%==============================================================================
FUNCTION {comma.to.colon}
{
	's :=
	"" 't :=
	#1 'i :=
	{s i #1 substring$ "" = not}
	{
		s i #1 substring$ duplicate$ "," =
			{pop$ t ":" * 't :=}
			{t swap$ * 't :=}
		if$
		i #1 + 'i :=
	} while$
	t
}

%
% localiza a posicao do primeiro caractere maiusculo
% recebe o string, devolve a posicao
%
FUNCTION {find.first.uppercase.char}
{
	's :=
	#1 'j :=
	#1 'i :=
	{
		s i #1 substring$ 't :=
		t "" = not
		t is.uppercase.char not
		and
	}
	{
		i #1 + 'i :=
		t "\" = not
		t "{" = not
		and
		t "}" = not
		and
			{i 'j :=}
			'skip$
		if$
	} while$
	t "" =
		{#1}
		{j}
	if$
}

%
% extrai o primeiro numero que aparece no string passado na pilha,
% retornando-o; se nao ha' numero, retorna ""
%
FUNCTION {extract.first.number}
{
	's :=
	"" 't :=
	#1 'i :=
	{
		s i #1 substring$
		duplicate$ is.numeric.char not
		swap$ "" = not
		and
	}
	{
		i #1 + 'i :=
	} while$
	{s i #1 substring$ is.numeric.char}
	{
		t s i #1 substring$ * 't :=
		i #1 + 'i :=
	} while$
	t
}

%
% divide um string em dois
% recebe o string e a posicao
% devolve a primeira e a segunda parte
FUNCTION {split.string}
{
	swap$ 's :=
	duplicate$
	s swap$ #1 swap$ #1 - substring$
	swap$ s swap$ global.max$ substring$
}

%
% recebe o titulo original e devolve, na ordem, o tipo de proceedings e o
% restante do titulo
%
FUNCTION {extract.proceedings.type}
{
	's :=
	type empty$ not
		{type s}
		{"dummy"
	pop$ s #1 #11 substring$ duplicate$ "Proceedings" =
		{s #12 global.max$ substring$}{
	pop$ s #1 #5 substring$ duplicate$ "Proc." =
		{pop$ "Proceedings" s #6 global.max$ substring$}{
	pop$ s #1 #22 substring$ duplicate$ "Conference Proceedings" =
		{pop$ "Proceedings" s #23 global.max$ substring$}{
	pop$ s #1 #6 substring$ duplicate$ "Annals" =
		{s #7 global.max$ substring$}{
	pop$ s #1 #5 substring$ duplicate$ "Actas" =
		{s #6 global.max$ substring$}{
	pop$ s #1 #5 substring$ duplicate$ "Anais" =
		{s #6 global.max$ substring$}{
	pop$ s #1 #6 substring$ duplicate$ "Anales" =
		{s #7 global.max$ substring$}{
	pop$ s #1 #8 substring$ duplicate$ "Memorias" =
		{s #9 global.max$ substring$}{
	pop$ s #1 #22 substring$ duplicate$ "Trabajos Seleccionados" =
		{s #23 global.max$ substring$}{
	pop$ s #1 #11 substring$ duplicate$ "Tagungsband" =
		{s #12 global.max$ substring$}
		{pop$ "Anais" s} if$
	} if$
	} if$
	} if$
	} if$
	} if$
	} if$
	} if$
	} if$
	} if$
	} if$
}

%==============================================================================
% Converte um booktitle do tipo "Proc. of XXX" no padrao ABNT
% Recebe na pilha o titulo original
% Devolve na pilha, na ordem:
% - o tipo de publicacao
% - o titulo ja' formatado (em maiusculas e com a edicao)
%==============================================================================
FUNCTION {process.proceedings.booktitle}
{
	extract.proceedings.type
	duplicate$ find.first.uppercase.char split.string "u" change.case$
	swap$ extract.first.number
	duplicate$ empty$
		'pop$
		{", " swap$ * * "." *}
	if$
}

%==============================================================================
% Estas funcoes formatam partes comuns a varios tipos de referencia.
%==============================================================================
FUNCTION {format.publication}
{
	""
	address empty$
		{
			"[S.l."
			format.publisher empty$
				{":~s.n.]" *}
				{"]: " format.publisher * *}
			if$ add.year add.to.item
		}
		{
			format.address
			format.publisher empty$
				{": [s.n.]" *}
				{": " format.publisher * *}
			if$ add.year add.to.item
		}
	if$
}

FUNCTION {format.proceedings.publication}
{
	publisher empty$
		{"[S.l.:~s.n.]"}
		{publisher comma.to.colon}
	if$ add.year
}

FUNCTION {format.misc.publication}
{
	publisher empty$ {
		format.address add.year
	}{
		format.publication
	} if$
}

FUNCTION {format.series.info}
{
	"(" format.series *
	add.volume ")" *
}

FUNCTION {format.complementary.data.with.totalpages}
{
	"" format.totalpages add.to.item
	""
	series empty$
		{add.volume add.number add.to.item}
		{add.number add.to.item format.series.info add.to.item}
	if$
}

FUNCTION {format.complementary.data.with.page.range}
{
	""
	series empty$
		{add.volume add.number add.pages}
		{"" add.number add.pages add.to.item format.series.info add.to.item}
	if$
}

%
% esta funcao recebe o titulo a ser formatado
%
FUNCTION {format.proceedings.booktitle}
{
	process.proceedings.booktitle "" swap$ add.year add.address add.to.item
	swap$ "{\ldots}" * emphasize " " swap$ * *
}

%==============================================================================
% Formatacao das entradas
%==============================================================================
FUNCTION {article}
{
	""
	format.author add.to.item
	#0 title format.title add.to.item
	journal emphasize
		address empty$ {
			"[S.l.]" add.to.list
		}{
			add.address
		} if$
		add.volume add.number add.pages add.month.year add.to.item
	format.note add.to.item

	write.item
}

FUNCTION {book}
{
	""
	editor empty$
		{format.author}
		{format.editor}
	if$ add.to.item
	#1 title format.title add.to.item
	format.edition add.to.item
	format.publication add.to.item
	format.complementary.data.with.totalpages add.to.item
	format.note add.to.item

	write.item
}

FUNCTION {inbook}
{
	""
	editor empty$
		{format.author}
		{format.editor}
	if$ add.to.item
	#1 title format.title add.to.item
	format.edition add.to.item
	format.publication add.to.item
	format.complementary.data.with.page.range add.to.item
	format.note add.to.item

	write.item
}

FUNCTION {incollection}
{
	""
	format.author add.to.item
	#0 title format.title add.to.item
	"In:"
		editor empty$
			'skip$
			{format.editor add.to.item}
		if$ 
		#1 booktitle format.title add.to.item add.to.item
	format.edition add.to.item
	format.publication add.to.item
	format.complementary.data.with.page.range add.to.item
	format.note add.to.item

	write.item
}

FUNCTION {inproceedings}
{
	""
	format.author add.to.item
	#0 title format.title add.to.item
	" In: " booktitle format.proceedings.booktitle * *
	format.proceedings.publication add.to.item
	format.complementary.data.with.page.range add.to.item
	format.note add.to.item

	write.item
}

FUNCTION {manual}
{
	""
	author empty$
		{format.entrytitle add.to.item}
		{
			format.author add.to.item
			#1 title format.title add.to.item
		}
	if$

	format.edition add.to.item
	format.publication add.to.item
	format.complementary.data.with.totalpages add.to.item
	format.note add.to.item

	write.item
}

FUNCTION {mastersthesis}
{
	""
	format.author add.to.item
	#1 title format.title add.to.item
	format.year add.to.item
	format.totalpages add.to.item
	str:mastersthesis format.type " --- " * format.publisher *
		add.address add.to.item
	format.note add.to.item
	format.parenthised.number add.to.item

	write.item
}

FUNCTION {misc}
{
	""
	author empty$
		{
			title empty$
				'skip$
				{format.entrytitle add.to.item}
			if$
		}
		{
			format.author add.to.item
			title empty$
				'skip$
				{#1 title format.title add.to.item}
			if$
		}
	if$
	note empty$ {
		format.misc.publication add.to.item
		format.complementary.data.with.totalpages add.to.item
	}{
		format.note add.howpublished add.to.item
	} if$

	write.item
}

FUNCTION {phdthesis}
{
	""
	format.author add.to.item
	#1 title format.title add.to.item
	format.year add.to.item
	format.totalpages add.to.item
	str:phdthesis format.type " --- " * format.publisher *
		add.address add.to.item
	format.note add.to.item
	format.parenthised.number add.to.item

	write.item
}

FUNCTION {proceedings}
{
	""
	title format.proceedings.booktitle *
	format.proceedings.publication add.to.item
	format.complementary.data.with.page.range add.to.item
	format.note add.to.item

	write.item
}

FUNCTION {techreport}
{
	""
	format.author add.to.item
	#1 title format.title add.to.item
	format.publication add.to.item
	type empty$
		{""}
		{type}
	if$ add.note add.to.item
	format.parenthised.number add.to.item

	write.item
}

FUNCTION {booklet} {misc}
FUNCTION {unpublished} {misc}
FUNCTION {default.type} {misc}

%==============================================================================
% Inicializa algumas variaveis globais
%==============================================================================
FUNCTION {init}
{
	"" 'last.label :=
	"b" 'current.letter :=
}

%==============================================================================
% Retorna na pilha o string a ser usado para a ordenacao das entradas.
%==============================================================================
FUNCTION {get.sortstring}
{
	author empty$ not {format.author " AAA" *}{
	editor empty$ not {format.editor " AAA" *}{
	title empty$ not {title}{
	note empty$ not {note}{
	key empty$ not {key}{
	"???"
	} if$
	} if$
	} if$
	} if$
	} if$

	type$ "inbook" =
	booktitle empty$ not
	and
		{
			booktitle title = not
				{pop$ title}
				'skip$
			if$
		}
		'skip$
	if$

	type$ "proceedings" = {
		pop$
		title process.proceedings.booktitle
		swap$ pop$
	}
		'skip$
	if$
	purify$ "l" change.case$
}

%==============================================================================
% Define as ``keys'' para ordenacao
%==============================================================================
FUNCTION {set.sortkeys}
{
	get.sortstring
	format.year *
	#1 entry.max$ substring$
	#1 global.max$ substring$
	'sort.key$ :=
}

%==============================================================================
% Ajusta os labels, adicionando letras minusculas aos labels de mesmo autor e
% ano
%==============================================================================
FUNCTION {adjust.label}
{
        last.label
        label 'last.label :=
        label = {
                current.letter 'year.char :=
                current.letter chr.to.int$
                #1 + int.to.chr$
                'current.letter :=
        }{
		"" 'year.char :=
                "b" 'current.letter :=
	} if$
}
FUNCTION {reverse.adjust.label}
{
        last.year.char "b" = {
		"a" 'year.char :=
	}
		'skip$
	if$
        year.char 'last.year.char :=
}

%==============================================================================
% Retorna na pilha o string a ser usado para a construcao do label. Quase sempre
% sera' o sobrenome do primeiro autor, mas para alguns tipos de referencia pode
% ser o editor, a entidade ou o titulo
%==============================================================================
FUNCTION {get.labelstring}
{
	author empty$ not
		{author format.family.names}
		{
			editor empty$ not
				{editor format.family.names}
				{
					title empty$ not
						{title "u" change.case$}
						{
							key empty$ not
								{key}
								{"???"}
							if$
						}
					if$
				}
			if$
		}
	if$

	type$ "inbook" =
	booktitle empty$ not
	and
		{
			booktitle title = not
				{pop$ title "u" change.case$}
				'skip$
			if$
		}
		'skip$
	if$
}

%==============================================================================
% Retorna na pilha o string a ser usado para a construcao do label. Quase sempre
% sera' o sobrenome do primeiro autor, mas para alguns tipos de referencia pode
% ser o editor, a entidade ou o titulo
%
% esta versao retorna os nomes completos
%==============================================================================
FUNCTION {get.labelstring.all}
{
	author empty$ not
		{author format.family.names.all}
		{
			editor empty$ not
				{editor format.family.names.all}
				{
					title empty$ not
						{title "u" change.case$}
						{
							key empty$ not
								{key}
								{"???"}
							if$
						}
					if$
				}
			if$
		}
	if$

	type$ "inbook" =
	booktitle empty$ not
	and
		{
			booktitle title = not
				{pop$ title "u" change.case$}
				'skip$
			if$
		}
		'skip$
	if$
}

%==============================================================================
% Construção dos labels
%==============================================================================
FUNCTION {prepare.label.sorting}
{
	get.labelstring.all format.year *
	duplicate$ 'label := 'sort.key$ :=
}
FUNCTION {make.label}
{
	get.labelstring
	"(" *
	year empty$ {
		"????"
	}{
		year year.char *
	} if$ *
	")" *
	get.labelstring.all *
	#1 entry.max$ substring$
	#1 global.max$ substring$
	'label :=
}

%==============================================================================
% Inicia a definicao das referencias
%==============================================================================
FUNCTION {begin.bib}
{
	preamble$ empty$
		'skip$
		{preamble$ write$ newline$ newline$}
	if$
	"\begin{thebibliography}{\hspace{\parindent}}" write$ newline$
	newline$
}

%==============================================================================
% Termina a definicao das referencias
%==============================================================================
FUNCTION {end.bib}
{
	"\end{thebibliography}" write$ newline$
}

%==============================================================================
% main()
%==============================================================================
READ
EXECUTE {init}
ITERATE {prepare.label.sorting}
SORT
ITERATE {adjust.label}
REVERSE {reverse.adjust.label}
ITERATE {make.label}
ITERATE {set.sortkeys}
SORT
EXECUTE {begin.bib}
ITERATE {call.type$}
EXECUTE {end.bib}
