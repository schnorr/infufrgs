%==============================================================================
% iiufrgs - classe de documento com padrões do II/UFRGS
% $Id: iiufrgs.cls,v 4.4.0 2010/08/13 12:00:00 laffernandes Exp $
%
% Copyright (C) 2001-2014 UFRGS TeX Users Group
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
%
% UFRGS TeX Users Group
% Institute of Informatics --- UFRGS
% Porto Alegre, Brazil
% http://www.inf.ufrgs.br/utug
% Discussion list: utug-l@inf.ufrgs.br
%==============================================================================

%==============================================================================
% Identificação
%==============================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iiufrgs}[2010/08/13 v4.4.0 Formatacao de documentos para o II/UFRGS]

%==============================================================================
% Declaração de opções
%==============================================================================
\newcommand{\iiu@novodoc}[1]{\DeclareOption{#1}{\AtEndOfClass{\input{#1.def}}}}
\newcommand{\iiu@aliasdoc}[2]{\DeclareOption{#1}{\AtEndOfClass{\input{#2.def}}}}

% programas
\iiu@novodoc{cic}
\iiu@novodoc{ecp}
\iiu@novodoc{unibral}
\iiu@novodoc{pgmicro}
\iiu@novodoc{ppgc}

% tipos de documento
\iiu@novodoc{dipl}
\iiu@aliasdoc{tc}{dipl}
\iiu@novodoc{ti}
\iiu@novodoc{rp}
\iiu@novodoc{pep}
\iiu@novodoc{prop-tese}
\iiu@novodoc{plano-doutorado}

% Documentos de Doutorado e Mestrado
\iiu@novodoc{diss}
\iiu@novodoc{tese}
\iiu@aliasdoc{mestrado}{diss}
\iiu@aliasdoc{doutorado}{tese}
\iiu@novodoc{espec}
\iiu@novodoc{formais}

% outros
\iiu@novodoc{nominatalocal}
\DeclareOption{english}{\@englishtrue\OptionNotUsed}\newif\if@english
\DeclareOption{noabntcite}{\@noabntcitetrue\OptionNotUsed}\newif\if@noabntcite
\DeclareOption{oneside}{\AtEndOfClass{\@twosidefalse}\OptionNotUsed}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

%==============================================================================
% Herança da classe `report' e inclusão de pacotes e arquivos necessários
%==============================================================================

\LoadClass[12pt,a4paper,twoside]{report}

\RequirePackage{xspace}
\RequirePackage{keyval}

\RequirePackage[english,brazilian]{babel}
\input{brazilian.babel}
\input{english.babel}
\if@english
        \selectlanguage{english}
        \AtBeginDocument{\selectlanguage{english}}
\fi
\RequirePackage{lastpage}
\RequirePackage{indentfirst}
\RequirePackage{iidefs}
\RequirePackage{setspace}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage[usenames,dvipsnames,svgnames,table]{xcolor}
\RequirePackage[tocindentauto,tocfullflat]{tocstyle}
\settocfeature[toc][0]{entryhook}{\bfseries\uppercase}
\settocfeature[toc][1]{entryhook}{\bfseries}
\settocstylefeature{pagenumberbox}{\pnbox}
\settocfeature[lof][1]{entryhook}{\figurename\hspace{0.2em}} % valor calculado no olho. Deveria ser um espaço de tamanho fixo, mas ~ tem tamanho variável
\settocfeature[lot][1]{entryhook}{\tablename\hspace{0.2em}}

\RequirePackage[%
        bookmarksnumbered=true,
        breaklinks=true,
        unicode=true,
%
        colorlinks=true,
        anchorcolor=black,
        citecolor=black,
        filecolor=black,
        linkcolor=black,
        urlcolor=black
]{hyperref}[2009/10/09]
\RequirePackage[all]{hypcap}

%\RequirePackage[T1]{fontenc}    % accedted characters in a T1 encoding are 1 glyph -- works better for pt_BR and other
\ifxetex
%\usepackage{fontspec}
  %\setmainfont{TeX Gyre Termes}
  \usepackage{tgtermes}
  %\usepackage{polyglossia}
  %\setmainlanguage{portuguese}
\else
  \usepackage{times}              % pacote para usar fonte Adobe Times
  \RequirePackage[T1]{fontenc}
\fi

\if@noabntcite
\else
\RequirePackage[
    % Habilita o uso de citações no formato autor-data.
	alf,
	% O modelo da UFRGS requer que os títulos dos trabalhos estejam em negrito.
    % Isso é opcional na norma ABNT (que permite que seja usado itálico) e
    % não é o padrão do abntex2.
    abnt-emphasize=bf,
    bibjustif
]{abntex2cite}
\fi

% espaçamento entre as linhas
\newcommand{\setlinespacing}{\setstretch{1.415}}
\setlinespacing

% estes valores estão no segundo parágrafo da introdução dos documentos da biblioteca e, portanto, estão corretos
% a numeração deve estar a 20mm do topo, logo headsep=30mm-20mm = 10mm
\RequirePackage[top=30mm,bottom=20mm,left=30mm,right=30mm,headsep=10mm]{geometry}
%\RequirePackage{calc}

\vfuzz=30pt % prevent "overfull \vbox while \output is active" warning

%==============================================================================
% Margens do texto
%==============================================================================

% indentação dos parágrafos (medido no olho)
\setlength{\parindent}{3em}
\AtBeginDocument{\setlength{\parskip}{0mm}}

%==============================================================================
% Numeração das páginas
%==============================================================================
\def\ps@iiufrgs{
        \let\@oddfoot\@empty
        \let\@evenfoot\@empty
        \def\@evenhead{{\small\thepage}}
        \def\@oddhead{\hspace*{\fill}{\small\thepage}}
}
\pagestyle{empty}
\let\ps@plain\ps@empty

%==============================================================================
% Definição de autor(es), orientador e co-orientador
%==============================================================================
\newcounter{ii@authorcount}
\renewcommand{\author}[2]{
        \addtocounter{ii@authorcount}{1}
        \expandafter\gdef\csname @author\alph{ii@authorcount}last\endcsname{#1}
        \expandafter\gdef\csname @author\alph{ii@authorcount}first\endcsname{#2}
        \expandafter\gdef\csname @author\alph{ii@authorcount}\endcsname{#2 #1}
}
\DeclareRobustCommand{\advisor}[3][]{
        \gdef\@advisorlast{#2}
        \gdef\@advisorfirst{#3}
        \gdef\@advisor{#1~#3 #2}
}
\DeclareRobustCommand{\coadvisor}[3][]{
        \gdef\@coadvisorlast{#2}
        \gdef\@coadvisorfirst{#3}
        \gdef\@coadvisor{#1~#3 #2}
}

%==============================================================================
% Definição do Departamento relacionado ao documento
% deve ser definido como `ina' ou `int'
%==============================================================================
\newcommand{\dept}[1]{\gdef\@dept{#1}}

%==============================================================================
% Definição das palavras-chave (máx. 10)
%==============================================================================
\newcounter{kwcounter}
\newcommand{\keyword}[1]{
        \addtocounter{kwcounter}{1}
        \expandafter\gdef\csname keyw\alph{kwcounter}\endcsname{#1}
}
\newcommand{\@cipkw}{%
        \@ifundefined{keywa}{}{1.~\expandafter\MakeUppercase\keywa\@. }%
        \@ifundefined{keywb}{}{2.~\expandafter\MakeUppercase\keywb\@. }%
        \@ifundefined{keywc}{}{3.~\expandafter\MakeUppercase\keywc\@. }%
        \@ifundefined{keywd}{}{4.~\expandafter\MakeUppercase\keywd\@. }%
        \@ifundefined{keywe}{}{5.~\expandafter\MakeUppercase\keywe\@. }%
        \@ifundefined{keywf}{}{6.~\expandafter\MakeUppercase\keywf\@. }%
        \@ifundefined{keywg}{}{7.~\expandafter\MakeUppercase\keywg\@. }%
        \@ifundefined{keywh}{}{8.~\expandafter\MakeUppercase\keywh\@. }%
        \@ifundefined{keywi}{}{9.~\expandafter\MakeUppercase\keywi\@. }%
        \@ifundefined{keywj}{}{10.~\expandafter\MakeUppercase\keywj\@. }%
}
\newcommand{\@abstractkw}{%
        \@ifundefined{keywa}{}{\expandafter\MakeUppercase\keywa}%
        \@ifundefined{keywb}{}{. \keywb}%
        \@ifundefined{keywc}{}{. \keywc}%
        \@ifundefined{keywd}{}{. \keywd}%
        \@ifundefined{keywe}{}{. \keywe}%
        \@ifundefined{keywf}{}{. \keywf}%
        \@ifundefined{keywg}{}{. \keywg}%
        \@ifundefined{keywh}{}{. \keywh}%
        \@ifundefined{keywi}{}{. \keywi}%
        \@ifundefined{keywj}{}{. \keywj}%
}

%==============================================================================
% Redefinição da data (para ter mês e ano separados)
%==============================================================================
\renewcommand{\date}[2]{
        \gdef\@publmonth{#1}
        \gdef\@publyear{#2}%
}
\date{\monthname}{\number\year}

%==============================================================================
% Definição padrão da folha de rosto.
% Os dados específicos do tipo de trabalho (dissertação, tese, etc.) são
% informados definindo-se o comando \titlepagespecificinfo. Veja os
% arquivos .def incluídos com a classe.
%==============================================================================
\newlength{\titlepagewinwidth}\setlength{\titlepagewinwidth}{95mm}
\newlength{\titlepagewinheight}\setlength{\titlepagewinheight}{64mm}
\newlength{\titlepagewinvoffset}\setlength{\titlepagewinvoffset}{112mm}
\newcommand{\location}[2]{
        \gdef\@city{#1}
        \gdef\@state{#2}
}
\location{Porto~Alegre}{RS}
\renewcommand{\maketitle}{%
  \setstretch{0.92}
  \hypersetup{%
    pdftitle={\@title},%
    pdfauthor={%
      \@authora%
      \@ifundefined{@authorb}{}{, \@authorb}%
      \@ifundefined{@authorc}{}{, \@authorc}%
      \@ifundefined{@authord}{}{, \@authord}%
    },%
    pdfkeywords={%
      \@ifundefined{keywa}{}{\keywa}%
      \@ifundefined{keywb}{}{. \keywb}%
      \@ifundefined{keywc}{}{. \keywc}%
      \@ifundefined{keywd}{}{. \keywd}%
      \@ifundefined{keywe}{}{. \keywe}%
      \@ifundefined{keywf}{}{. \keywf}%
      \@ifundefined{keywg}{}{. \keywg}%
      \@ifundefined{keywh}{}{. \keywh}%
      \@ifundefined{keywi}{}{. \keywi}%
      \@ifundefined{keywj}{}{. \keywj}%
    }%
  }%
  \begin{titlepage}
      \thetitlepage
  \end{titlepage}%
  \clearpage
  \setcounter{page}{2}%
  \@ifundefined{@cipspecificinfo}{\@makenominatapage}{\@makecippage}
  \setlinespacing
}
\newcommand{\thetitlepage}{%
  \noindent\@topbox\\
  \vspace{5.9ex}\\
  \setstretch{0.95}
  \@ifundefined{titlepagespecificinfo}{}{
    \hspace*{\fill}\makebox[.56\textwidth][l]{%
      \parbox[b]{0.56\textwidth}{\lefthyphenmin=64\titlepagespecificinfo}%
    }%
    \vspace{5.5ex}\\
  }
  \@ifundefined{@advisor}{}{
    \hspace*{\fill}\makebox[.56\textwidth][l]{%
      \parbox[b]{0.56\textwidth}{\raggedright\lefthyphenmin=64\titlepageadvisorinfo}%
    }%
    \vfill
  }
  \centerline{\@city}
  \centerline{\ii@date}
  \vspace{8mm}
}
\def\@topbox{%
        \parbox[t]{\textwidth}{%
                \centering%
                \vbox to \titlepagewinvoffset{%
                        \titlepagetopinfo\vfill\@winbox
                }
        }
}
\def\@winbox{%
%       \fbox{
        \parbox[b]{\titlepagewinwidth}{%
        \centering\vbox to \titlepagewinheight{%
                \vspace*{3ex}
                \MakeUppercase{\@authora}\\
                \@ifundefined{@authorb}{}{\MakeUppercase{\@authorb}\\}%
                \@ifundefined{@authorc}{}{\MakeUppercase{\@authorc}\\}%
                \@ifundefined{@authord}{}{\MakeUppercase{\@authord}\\}%
                \vspace{12.65ex}
                {\large\textbf{\@title}\par}
                \vfill
        }}%
%       }%
}
\newcommand{\course}[1]{\gdef\@course{#1}}
\newcommand{\titlepagetopinfo}{%
        \MakeUppercase{\ufrgs}\\
        \MakeUppercase{\ii}\\
        \@ifundefined{@dept}{}{\MakeUppercase{\csname dept\@dept\endcsname}\\}%
        \MakeUppercase{\@course}\\
}
\newcommand{\titlepageadvisorinfo}{%
        \@ifundefined{@advisor}{}{\advisorname:~\@advisor\\}%
        \@ifundefined{@coadvisor}{}{\coadvisorname:~\@coadvisor\\}%
}

%==============================================================================
% Catalogação na fonte (CIP) e nominata
%==============================================================================
\newcommand{\@makecippage}{%
        \clearpage%
        \begin{center}
                \textbf{\cipcaption}\\[2ex]
                \iiu@cipwindow
        \end{center}
        \vfill
        \nominata
}

%===============================================================================
% Faz apenas a nomionata (TCs não tem nominata, aparentemente)
%===============================================================================
\newcommand{\@makenominatapage}{%
    \clearpage
    ~
    \vfill
    \nominata
}%

% definição do quadro
\def\iiu@cipwindow{%
        \framebox[120mm]{%
        \begin{minipage}{110mm}%
                \vspace*{0.2ex}
                \setlength{\parindent}{1.5em}%
                \setlength{\parskip}{1.3ex}%
                \noindent\@authoralast, \@authorafirst\par
                \@title\ / \@authora.\ -- \@city: \nomeDoProgramaPG~da~UFRGS, \@publyear.\par
                \pageref{LastPage}~f.: il.\par
                \@cipspecificinfo\ -- \ufrgs. \@course, \@city, BR--\@state, \@publyear. \advisorname: \@advisorfirst\ \@advisorlast\@ifundefined{@coadvisor}{}{; \coadvisorname: \@coadvisorfirst\ \@coadvisorlast}.\par
                \@cipkw I.~\@advisorlast, \@advisorfirst. \@ifundefined{@coadvisorfirst}{II.~T\'{\i}tulo.}{II.~\@coadvisorlast, \@coadvisorfirst. III.~T\'{\i}tulo.}\\
                \vspace{0.2ex}
        \end{minipage}%
        }%
}

\AtEndOfClass{\input{nominata.def}}
\newcommand{\nominata}{
  \setstretch{0.95}
  \noindent\MakeUppercase{\ufrgs}

  \noindent\nominataReitname: \nominataReit

  \noindent\nominataPRCAname: \nominataPRCA

  \noindent\nominataPRAPGname: \nominataPRAPG

  \noindent\nominataDirname: \nominataDir

  \noindent\nominataCoordname: \nominataCoord

  \noindent\nominataBibchefename: \nominataBibchefe

  \setlinespacing
  \vspace{18.25mm}
}


%==============================================================================
% Ajuste do sumário
%==============================================================================
\renewcommand{\@dotsep}{0}
\newlength{\dottedspace}
\newcommand{\pnbox}[1]{\settowidth{\dottedspace}{\bfseries#1}\hb@xt@\dottedspace{#1}}

\newcommand\samepagechapter{
                    %\thispagestyle{plain}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}

\setcounter{tocdepth}{3}
\newif\if@aftertoc
\@aftertocfalse
\renewcommand{\tableofcontents}{%
  \chapter*{\contentsname}
  \vspace{0.4\baselineskip}
  \setstretch{0.95}
  \@starttoc{toc}\@aftertoctrue%
  % retorna o espaçamento ao seu valor original
  \setlinespacing
}
\renewcommand{\listoffigures}{%
  \chapter*{\listfigurename}
  \setstretch{0.95}
  \@starttoc{lof}%
  % retorna o espaçamento ao seu valor original
  \setlinespacing
}
\renewcommand{\listoftables}{%
  \chapter*{\listtablename}
  \setstretch{0.95}
  \@starttoc{lot}%
  % retorna o espaçamento ao seu valor original
  \setlinespacing
}

%==============================================================================
% Definição das listas de abreviaturas e siglas e de símbolos
%==============================================================================
\newenvironment{listofabbrv}[1]{
        \chapter*{\listabbrvname}
        \begin{list}{\textbf{??}}{
                \settowidth{\labelwidth}{#1}
                \setlength{\labelsep}{1em}
                \setlength{\itemindent}{0mm}
                \setlength{\leftmargin}{\labelwidth}
                \addtolength{\leftmargin}{\labelsep}
                \setlength{\rightmargin}{0mm}
                \setlength{\itemsep}{.1\baselineskip}
                \renewcommand{\makelabel}[1]{\makebox[\labelwidth][l]{##1}}
        }
}{
        \end{list}
}
\newenvironment{listofsymbols}[1]{
        \chapter*{\listsymbolname}
        \begin{list}{\textbf{??}}{
                \settowidth{\labelwidth}{#1}
                \setlength{\labelsep}{1em}
                \setlength{\itemindent}{0mm}
                \setlength{\leftmargin}{\labelwidth}
                \addtolength{\leftmargin}{\labelsep}
                \setlength{\rightmargin}{0mm}
                \setlength{\itemsep}{.1\baselineskip}
                \renewcommand{\makelabel}[1]{\makebox[\labelwidth][l]{##1}}
        }
}{
        \end{list}
}

%==============================================================================
% Resumo (abstract) e Abstract (englishabstract)
%==============================================================================
\renewenvironment{abstract}{%
        \chapter*{\abstractname}\setlength{\parindent}{0pt}
}{%
    %\par\vfill
    \\
    \vspace{\parskip}\noindent\textbf{\keywordsname:} \@abstractkw.
}

\newenvironment{englishabstract}[2]{%
        \if@openright\cleardoublepage\else\clearpage\fi%
        \gdef\@englishkeywords{#2}%
        \iflanguage{english}{
                \begin{otherlanguage}{brazilian}
        }{
                \begin{otherlanguage}{english}
        }
        \begin{center}%
            \textbf{#1}%
            \vspace{12pt}
        \end{center}
        \samepagechapter*{\abstractname}\setlength{\parindent}{0pt}
}{%
  \vspace{12pt}

  \noindent\textbf{\keywordsname:} \@englishkeywords.
\end{otherlanguage}
}


%==============================================================================
% Formatação dos capítulos.
% Os comandos \@chapter e \@schapter são redefinidos para que a
% numeração de páginas seja correta (deve aparecer somente a partir do
% primeiro capítulo do texto, mas não nas páginas iniciais de
% capítulos).
% Os comandos \@makechapterhead e \@makeschapterhead fazem a
% formatação dos títulos propriamente ditos.
%==============================================================================
\newcounter{schapter}
\newcommand{\ii@chapterfont}{\@setfontsize\Large{12}{18}}
\def\@chapapp{}
\def\@chapappextra{}
\def\@chappositioning{\noindent}
\def\@chapter[#1]#2{%
        \xdef\Hy@chapapp{CHAPTER}%
        \gdef\theHchapter{\thechapter}%
        \refstepcounter{chapter}%
        \addcontentsline{toc}{chapter}{\@chapapp\thechapter~\@chapappextra#1}%
        \addtocontents{lof}{\protect\addvspace{10\p@}}%
        \addtocontents{lot}{\protect\addvspace{10\p@}}%
        \addtocontents{lol}{\protect\addvspace{10\p@}}%
        \pagestyle{iiufrgs}\let\ps@plain\ps@iiufrgs%
        \@makechapterhead{#2}{\@chappositioning}\@afterheading

}

\def\@makechapterhead#1#2{%
        %\vspace*{90pt}
        %\vspace{12pt}
        \reset@font{#2{\ii@chapterfont\textbf{\@chapapp\thechapter\hphantom{~}\@chapappextra\MakeUppercase{#1}}\par}}
        \addvspace{\baselineskip}
        \noindent
        %\par
}
\def\@schapter#1{%
        \xdef\Hy@chapapp{SCHAPTER}%
        \refstepcounter{schapter}%
        \if@aftertoc%
            \hyperdef{SCHAPTER}{\theschapter}{}%
            \@makeschapterhead{#1}\@afterheading%
            \addcontentsline{toc}{chapter}{\@chapapp\xspace{}\@chapappextra#1}%
        \else%
            \pdfbookmark[0]{#1}{MUTESCHAPTER.\theschapter}%
            \@makeschapterhead{#1}\@afterheading%
        \fi%
        \addtocontents{lof}{\protect\addvspace{10\p@}}%
        \addtocontents{lot}{\protect\addvspace{10\p@}}%
}
\def\@makeschapterhead#1{%
        %\vspace*{90pt}
        \reset@font\centerline{\ii@chapterfont\textbf{\MakeUppercase{\@chapapp\xspace{}\@chapappextra#1}}}
        \addvspace{18pt}
}
\renewcommand{\appendix}[1][\appendixname]{
    \setcounter{chapter}{0}%
    \renewcommand{\thechapter}{\Alph{chapter}}%
    \gdef\@chapapp{\texorpdfstring{\MakeUppercase{#1}}{#1}\space}%
    \gdef\@chapappextra{---\space}%
    \gdef\@chappositioning{\centering}
}
\newcommand{\annex}{\appendix[\annexname]}

%==============================================================================
% Formatação das seções
%==============================================================================
\setcounter{secnumdepth}{5}
\renewcommand{\@seccntformat}[1]{\csname the#1\endcsname\ }

% \renewcommand{\section}{%
%         \@startsection{section}{2}{0pt}{18pt}{18pt}{\reset@font\normalsize\bfseries}
% }
%\titleformat*{\section}{\reset@font\normalsize\bfseries}
\titleformat{\section}[hang]{\bfseries}{\thesection~}{0pt}{}
\titlespacing\section{0pt}{1.5\baselineskip}{\baselineskip}
\titleformat*{\subsection}{\reset@font\normalsize\bfseries}
\titlespacing\subsection{0pt}{1.5\baselineskip}{\baselineskip}
\titleformat*{\subsubsection}{\reset@font\normalsize\itshape}
\titlespacing\subsubsection{0pt}{1\baselineskip}{0.5\baselineskip}
\titleformat*{\paragraph}{\reset@font\normalsize}
\titlespacing\paragraph{0pt}{1\baselineskip}{0.5\baselineskip}
% \renewcommand{\subsection}{%
%         \@startsection{subsection}{3}{0pt}{18pt}{18pt}{\reset@font\bfseries}
% }
% \renewcommand{\subsubsection}{%
%         \@startsection{subsubsection}{4}{0pt}{18pt}{18pt}{\reset@font\itshape}
% }
% \renewcommand{\paragraph}{%
%         \@startsection{paragraph}{5}{0pt}{18pt}{18pt}{\reset@font}
% }

%==============================================================================
% Redefinição do formato de citações longas
%==============================================================================
\renewenvironment{quote}{%
        \setstretch{1}%
        \small%
        \begin{list}{}{\setlength{\leftmargin}{40mm}\item\relax}
        \fontsize{10bp}{12bp}\selectfont%
}{%
        \end{list}
}


%==============================================================================
% Ajuste do espaçamento entre itens em 'enumerate', 'itemize' e 'description'
%==============================================================================
\renewenvironment{enumerate}{%
  \begin{list}{\arabic{enumi}.}{\topsep=6pt\itemsep=2pt\parsep=0pt\partopsep=0pt\usecounter{enumi}}%
}{\end{list}}

\renewenvironment{itemize}{%
  \begin{list}{\bfseries\upshape $\bullet$}{\topsep=6pt\itemsep=2pt\parsep=0pt\partopsep=0pt}%
}{\end{list}}

\renewenvironment{description}{
  \begin{list}{}{\topsep=6pt\itemsep=2pt\parsep=0pt\partopsep=0pt \labelwidth\z@ \itemindent-\leftmargin \let\makelabel\descriptionlabel}
}{\end{list}}

%==============================================================================
% Ajuste das legendas das figuras e tabelas
%==============================================================================
\RequirePackage[
        format=plain,labelsep=endash,justification=centering,font=small,
        skip=0pt
]{caption}
% The command `\legend` does not exist in the `caption` package, but is the
% same as `\caption*` which does not number the caption, do not go in the list
% of figures (or tables), and will be below the figure/table if it is placed
% below it. The only thing that needs adjust is returning the font size to
% the normal size.
\newcommand{\legend}[1]{\caption*{\normalsize #1}}

%==============================================================================
% Ajuste do formato das citações e referências
%==============================================================================
%\setlength{\bibhang}{0pt}
%\let\cite\citep %Linhas desativadas pelo Valdez, faziam o layout nunca ter parenteses

%
% comandos DEPRECATED
% mantidos aqui somente para compatibilidade, nao constam mais no exemplo
% sugere-se remove-los a partir de julho/2003
% 07/dez/2002 - avila
%
\newcommand{\cip}{}
\newenvironment{dedicatoria}{%
        \clearpage%
        \mbox{}\vfill\begin{flushright}
}{
        \end{flushright}
}
\newenvironment{agradecimentos}{
	\chapter*{Agradecimentos}
}{}
