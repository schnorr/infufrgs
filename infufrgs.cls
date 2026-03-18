%==============================================================================
% infufrgs.cls - LaTeX document class for INF/UFRGS
%
% This is a consolidated, modernised version of the infufrgs class.
% All auxiliary files (iidefs.sty, *.def, *.babel) have been inlined so
% that this single file is sufficient to compile documents.
%
% Copyright (C) 2001-2026 UFRGS TeX Users Group
%
% This work may be distributed and/or modified under the conditions of
% the LaTeX Project Public License, either version 1.3c of this license
% or (at your option) any later version.
% The latest version of this license is in
%   https://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% UFRGS TeX Users Group
% Institute of Informatics --- UFRGS
% Porto Alegre, Brazil
% https://www.inf.ufrgs.br/utug
%==============================================================================

%==============================================================================
% Identification
%==============================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{infufrgs}%
  [2026-03-15 v5.0.0 Document formatting for INF/UFRGS]

%==============================================================================
% Option declarations
%==============================================================================

% --- Programs (set \@course, \nominataCoord, \nomeDoProgramaPG, etc.) ---
\newif\if@optcic       \@optcicfalse
\newif\if@optecp       \@optecpfalse
\newif\if@optppgc      \@optppgcfalse
\newif\if@optpgmicro   \@optpgmicrofalse
\newif\if@optppgl      \@optppglfalse
\newif\if@optunibral   \@optunibralfalse

\DeclareOption{cic}{\@optcictrue}
\DeclareOption{ecp}{\@optecptrue}
\DeclareOption{ppgc}{\@optppgctrue}
\DeclareOption{pgmicro}{\@optpgmicrotrue}
\DeclareOption{ppgl}{\@optppgltrue}
\DeclareOption{unibral}{\@optunibraltrue}

% --- Document kinds ---
\newif\if@optdipl      \@optdiplfalse
\newif\if@optti        \@opttifalse
\newif\if@optrp        \@optrpfalse
\newif\if@optpep       \@optpepfalse
\newif\if@optproptese  \@optproptesefalse
\newif\if@optplanodout \@optplanodoutfalse
\newif\if@optdiss      \@optdissfalse
\newif\if@opttese      \@opttesefalse
\newif\if@optespec     \@optespecfalse
\newif\if@optformais   \@optformaisfalse

\DeclareOption{dipl}{\@optdipltrue}
\DeclareOption{tc}{\@optdipltrue}          % alias
\DeclareOption{ti}{\@opttitrue}
\DeclareOption{rp}{\@optrptrue}
\DeclareOption{pep}{\@optpeptrue}
\DeclareOption{prop-tese}{\@optproptesetrue}
\DeclareOption{plano-doutorado}{\@optplanodouttrue}
\DeclareOption{diss}{\@optdisstrue}
\DeclareOption{mestrado}{\@optdisstrue}    % alias
\DeclareOption{tese}{\@opttesetrue}
\DeclareOption{doutorado}{\@opttesetrue}   % alias
\DeclareOption{espec}{\@optespectrue}
\DeclareOption{formais}{\@optformaistrue}

% --- Language ---
\newif\if@english  \@englishfalse
\DeclareOption{english}{\@englishtrue}

% --- Citations ---
\newif\if@noabntcite  \@noabntcitefalse
\DeclareOption{noabntcite}{\@noabntcitetrue}

% --- Nominata ---
\newif\if@nominatalocal  \@nominatalocalfalse
\DeclareOption{nominatalocal}{\@nominatalocaltrue}

% --- One-side ---
\DeclareOption{oneside}{\AtEndOfClass{\@twosidefalse}\OptionNotUsed}

% --- Pass everything else to report ---
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\ProcessOptions\relax

%==============================================================================
% Base class and essential packages
%==============================================================================
\LoadClass[12pt,a4paper,twoside]{report}

\RequirePackage{xspace}
\RequirePackage{keyval}
\RequirePackage{iftex}              % modern engine detection (\ifpdftex, \ifxetex, \ifluatex)
\RequirePackage[english,brazilian]{babel}
\RequirePackage{lastpage}
\RequirePackage{indentfirst}
\RequirePackage{setspace}
\RequirePackage{titlesec}
\RequirePackage{tocloft}            % TOC/LOF/LOT formatting (replaces deprecated tocstyle)
\RequirePackage{fancyhdr}
\RequirePackage[dvipsnames,svgnames,table]{xcolor}
\RequirePackage{graphicx}

% Fonts: newtxtext/newtxmath for pdfLaTeX; fontspec for XeLaTeX/LuaLaTeX
\ifpdftex
  \RequirePackage[T1]{fontenc}
  \RequirePackage{newtxtext}        % Times-based text font (replaces obsolete `times`)
  \RequirePackage{newtxmath}        % Times-based math font
\else
  \RequirePackage{fontspec}
  \setmainfont{TeX Gyre Termes}     % Times-compatible OpenType font
\fi

% Hyperref (load after fonts)
\RequirePackage[%
  bookmarksnumbered=true,
  breaklinks=true,
  unicode=true,
  colorlinks=true,
  anchorcolor=black,
  citecolor=black,
  filecolor=black,
  linkcolor=black,
  urlcolor=black
]{hyperref}
\RequirePackage[all]{hypcap}

% Captions
\RequirePackage[%
  format=plain,
  labelsep=endash,
  justification=centering,
  font=small,
  skip=0pt
]{caption}

% ABNT citations (optional, can be loaded by user with \RequirePackage directly)
\if@noabntcite\else
  \RequirePackage[alf,abnt-emphasize=bf,bibjustif]{abntex2cite}
\fi

% Geometry
\RequirePackage[top=30mm,bottom=20mm,left=30mm,right=30mm,headsep=10mm]{geometry}

%==============================================================================
% Language definitions (inlined from brazilian.babel and english.babel)
%==============================================================================
\@namedef{captionsbrazilian}{%
  \def\bibname{Refer{\^e}ncias}%
  \def\abstractname{Resumo}%
  \def\appendixname{Ap{\^e}ndice}%
  \def\contentsname{Sum{\'a}rio}%
  \def\listfigurename{Lista de Figuras}%
  \def\listtablename{Lista de Tabelas}%
  \def\listdefname{Lista de Defini\c{c}\~{o}es}%
  \def\listtheoremsname{Lista de Teoremas}%
  \def\corollaryname{Corol\'{a}rio}%
  \def\propositionname{Proposi\c{c}\~{a}o}%
  \def\definitionname{Defini\c{c}\~{a}o}%
  \def\conjecturename{Conjectura}%
  \def\examplename{Exemplo}%
  \def\exercisename{Exerc\'{\i}cio}%
  \def\propertyname{Propriedade}%
  \def\remarkname{Observa\c{c}\~{a}o}%
  \def\lemmaname{Lema}%
  \def\theoremname{Teorema}%
  \def\proofname{Prova}%
  \def\figurename{Figura}%
  \def\tablename{Tabela}%
  \def\advisorname{Orientador}%
  \def\coadvisorname{Co-orientador}%
  \def\listabbrvname{Lista de Abreviaturas e Siglas}%
  \def\listsymbolname{Lista de S{\'\i}mbolos}%
  \def\annexname{Anexo}%
  \def\keywordsname{Palavras-chave}%
  \def\cipcaption{CIP --- CATALOGA{\c{C}}{\~A}O NA PUBLICA{\c{C}}{\~A}O}%
  \def\byname{por}%
  \def\dissname{Disserta{\c{c}}{\~a}o (mestrado)}%
  \def\pgmicroTitulacaoEm{Microeletr{\^o}nica}%
  \def\ppgcTitulacaoEm{Ci{\^e}ncia da Computa{\c{c}}{\~a}o}%
  \def\dissspecificinfo{%
    Disserta{\c{c}}{\~a}o apresentada como requisito parcial
    para a obten{\c{c}}{\~a}o do grau de
    Mestre em \titulacaoEm
  }%
  \def\tesename{Tese (doutorado)}%
  \def\tesespecificinfo{%
    Tese apresentada como requisito parcial
    para a obten{\c{c}}{\~a}o do grau de
    Doutor em \titulacaoEm
  }%
  \def\planodoutoradospecificinfo{Plano de Curso para Doutorado}%
  \def\proptesespecificinfo{Proposta de Tese de Doutorado}%
  \def\tcname{Trabalho de Conclus\~{a}o}%
  \def\cicTitulacaoEm{Ci{\^e}ncia da Computa{\c{c}}{\~a}o}%
  \def\ecpTitulacaoEm{Engenharia da Computa{\c{c}}{\~a}o}%
  \def\tcspecificinfo{%
    Monografia apresentada como requisito
    parcial para a obten{\c{c}}{\~a}o do grau de Bacharel
    em \titulacaoEm
  }%
  \def\rpname{Relat{\'o}rio de Pesquisa}%
  \def\financname{{\'O}rg{\~a}os Financiadores}%
  \def\especname{Monografia (especializa{\c{c}}{\~a}o)}%
  \def\especspecificinfo{%
    Monografia de Conclus{\~a}o de Curso apresentada como
    requisito parcial para a obten{\c{c}}{\~a}o do grau de Especialista
    em \titulacaoEm
  }%
  \def\coordname{Coordenador do Curso}%
}

\@namedef{datebrazilian}{%
  \def\monthname{%
    \ifcase\month\or
      janeiro\or fevereiro\or mar{\c{c}}o\or abril\or
      maio\or junho\or julho\or agosto\or setembro\or
      outubro\or novembro\or dezembro
    \fi
  }%
  \def\ii@date{\@publyear}%
}

\@namedef{captionsenglish}{%
  \def\bibname{References}%
  \def\abstractname{Abstract}%
  \def\appendixname{Appendix}%
  \def\contentsname{Contents}%
  \def\listfigurename{List of Figures}%
  \def\listtablename{List of Tables}%
  \def\listdefname{List of Definitions}%
  \def\listtheoremsname{List of Theorems}%
  \def\corollaryname{Corollary}%
  \def\propositionname{Proposition}%
  \def\definitionname{Definition}%
  \def\conjecturename{Conjecture}%
  \def\examplename{Example}%
  \def\exercisename{Exercise}%
  \def\propertyname{Property}%
  \def\remarkname{Remark}%
  \def\lemmaname{Lemma}%
  \def\theoremname{Theorem}%
  \def\proofname{Proof}%
  \def\figurename{Figure}%
  \def\tablename{Table}%
  \def\advisorname{Advisor}%
  \def\coadvisorname{Co-advisor}%
  \def\listabbrvname{List of Abbreviations and Acronyms}%
  \def\listsymbolname{List of Symbols}%
  \def\annexname{Annex}%
  \def\keywordsname{Keywords}%
  \def\cipcaption{CIP --- CATALOGING-IN-PUBLICATION}%
  \def\byname{by}%
  \def\dissname{Thesis (Master)}%
  \def\pgmicroTitulacaoEm{Microelectronics}%
  \def\ppgcTitulacaoEm{Computer Science}%
  \def\dissspecificinfo{%
    Thesis presented in partial fulfillment
    of the requirements for the degree of
    Master of \titulacaoEm
  }%
  \def\tesename{Thesis (Ph.D.)}%
  \def\tesespecificinfo{%
    Thesis presented in partial fulfillment
    of the requirements for the degree of
    Doctor of \titulacaoEm
  }%
  \def\planodoutoradospecificinfo{PhD Work Plan}%
  \def\proptesespecificinfo{Ph.D.\ Thesis Proposal}%
  \def\tcname{Trabalho de Conclus\~{a}o}%
  \def\cicTitulacaoEm{Computer Science}%
  \def\ecpTitulacaoEm{Computer Engineering}%
  \def\tcspecificinfo{%
    Work presented in partial fulfillment
    of the requirements for the degree of
    Bachelor in \titulacaoEm
  }%
  \def\rpname{Research Report}%
  \def\financname{Supporting Agencies}%
  \def\especname{Monography (specialization)}%
  \def\especspecificinfo{%
    Monography presented in partial fulfillment
    of the requirements for the degree of Especialista
  }%
  \def\coordname{Course Coordinator}%
}

\@namedef{dateenglish}{%
  \def\monthname{%
    \ifcase\month\or
      January\or February\or March\or April\or
      May\or June\or July\or August\or September\or
      October\or November\or December
    \fi
  }%
  \def\ii@date{\@publmonth~\@publyear}%
}

% Activate language captions
\if@english
  \selectlanguage{english}
  \AtBeginDocument{\selectlanguage{english}}
\fi

%==============================================================================
% Institutional name definitions (from iidefs.sty)
%==============================================================================
\def\ufrgs{Universidade Federal do Rio Grande do Sul}
\def\ii{Instituto de Inform{\'a}tica}
\def\ppgc{Programa de P{\'o}s-Gradua{\c{c}}{\~a}o em Computa{\c{c}}{\~a}o}
\def\pgmicro{Programa de P{\'o}s-Gradua{\c{c}}{\~a}o em Microeletr{\^o}nica}
\def\cgcc{Curso de Ci{\^e}ncia da Computa{\c{c}}{\~a}o}
\def\cgec{Curso de Engenharia de Computa{\c{c}}{\~a}o}
\def\deptINA{Departamento de Inform{\'a}tica Aplicada}
\def\deptINT{Departamento de Inform{\'a}tica Te{\'o}rica}

%==============================================================================
% Program definitions (from cic.def, ecp.def, ppgc.def, pgmicro.def, ppgl.def)
%==============================================================================
\if@optcic
  \providecommand{\nominataCoord}{\nominataCoordCIC}
  \providecommand{\nominataCoordname}{\nominataCoordCICname}
  \providecommand{\nomeDoProgramaPG}{CIC}
  \providecommand{\titulacaoEm}{\cicTitulacaoEm}
  \providecommand{\nominataPRAPG}{\nominataPRAG}
  \providecommand{\nominataPRAPGname}{\nominataPRAGname}
  \AtEndOfClass{\course{\cgcc}}
\fi

\if@optecp
  \providecommand{\nominataCoord}{\nominataCoordECP}
  \providecommand{\nominataCoordname}{\nominataCoordECPname}
  \providecommand{\nomeDoProgramaPG}{ECP}
  \providecommand{\titulacaoEm}{\ecpTitulacaoEm}
  \providecommand{\nominataPRAPG}{\nominataPRAG}
  \providecommand{\nominataPRAPGname}{\nominataPRAGname}
  \AtEndOfClass{\course{\cgec}}
\fi

\if@optppgc
  \providecommand{\nominataCoord}{\nominataCoordPPGC}
  \providecommand{\nominataCoordname}{\nominataCoordnamePPGC}
  \providecommand{\nomeDoProgramaPG}{PPGC}
  \providecommand{\titulacaoEm}{\ppgcTitulacaoEm}
  \AtEndOfClass{\course{\ppgc}}
\fi

\if@optpgmicro
  \providecommand{\nominataCoord}{\nominataCoordPGMICRO}
  \providecommand{\nominataCoordname}{\nominataCoordnamePGMICRO}
  \providecommand{\nomeDoProgramaPG}{PGMICRO}
  \providecommand{\titulacaoEm}{\pgmicroTitulacaoEm}
  \AtEndOfClass{\course{\pgmicro}}
\fi

\if@optppgl
  \providecommand{\nominataCoord}{Prof\textsuperscript{a}.~Elaine Barros Indrusiak}
  \providecommand{\nominataCoordname}{Coordenadora do PPG Letras}
  \providecommand{\nomeDoProgramaPG}{PPG Letras}
  \providecommand{\titulacaoEm}{Letras}
  \AtEndOfClass{\course{Programa de P{\'o}s-Gradua{\c{c}}{\~a}o em Letras}}
\fi

%==============================================================================
% Document kind definitions (from dipl.def, ti.def, rp.def, pep.def, etc.)
%==============================================================================

% dipl / tc
\if@optdipl
  \AtEndOfClass{%
    \newcommand{\titlepagespecificinfo}{\tcspecificinfo}%
  }
\fi

% ti
\if@optti
  \AtEndOfClass{%
    \newcommand{\ti}[2][I]{%
      \gdef\@tinumber{#2}%
      \gdef\@tirelease{#1}%
    }%
    \newcommand{\titlepagespecificinfo}{%
      Trabalho Individual~\@tirelease\\
      TI-\@tinumber
    }%
  }
\fi

% rp
\if@optrp
  \AtEndOfClass{%
    \newcommand{\rp}[1]{\gdef\ii@rp{#1}}%
    \newcommand{\financ}[1]{\gdef\ii@financ{#1}}%
    \newcommand{\titlepagespecificinfo}{%
      \rpname\\
      RP-\ii@rp\\
      \@ifundefined{ii@financ}{}{%
        \vspace{4ex}%
        \financname: \ii@financ
      }%
    }%
  }
\fi

% pep
\if@optpep
  \AtEndOfClass{%
    \newcommand{\titlepagespecificinfo}{Plano de Estudos e Pesquisa}%
  }
\fi

% prop-tese
\if@optproptese
  \AtEndOfClass{%
    \newcommand{\titlepagespecificinfo}{\proptesespecificinfo}%
  }
\fi

% plano-doutorado
\if@optplanodout
  \AtEndOfClass{%
    \newcommand{\titlepagespecificinfo}{\planodoutoradospecificinfo}%
  }
\fi

% diss / mestrado
\if@optdiss
  \AtEndOfClass{%
    \newcommand{\titlepagespecificinfo}{\dissspecificinfo}%
    \def\@cipspecificinfo{\dissname}%
  }
\fi

% tese / doutorado
\if@opttese
  \AtEndOfClass{%
    \newcommand{\titlepagespecificinfo}{\tesespecificinfo}%
    \def\@cipspecificinfo{\tesename}%
  }
\fi

% espec
\if@optespec
  \AtEndOfClass{%
    \newcommand{\titlepagespecificinfo}{\especspecificinfo}%
    \def\@cipspecificinfo{\especname}%
    \renewcommand{\titulacaoEm}{\ii@espec}%
    \newcommand{\espec}[1]{\gdef\ii@espec{#1}}%
    \DeclareRobustCommand{\coord}[3][]{%
      \gdef\@coordlast{#2}%
      \gdef\@coordfirst{#3}%
      \gdef\@coord{#1~#3 #2}%
    }%
    \newcommand{\nominataCEname}{%
      \coordname\ de Especializa{\c{c}}{\~a}o em \ii@espec
    }%
  }
\fi

% formais
\if@optformais
  \AtEndOfClass{%
    \DeclareRobustCommand{\listofdefinitions}{%
      \chapter*{\listdefname}\@starttoc{lod}%
    }%
    \DeclareRobustCommand{\listoftheorems}{%
      \chapter*{\listtheoremsname}\@starttoc{loth}%
    }%
    \newtheorem{envtheorem}{\theoremname}[chapter]
    \newtheorem{lemma}{\lemmaname}[chapter]
    \newtheorem{corollary}{\corollaryname}[chapter]
    \newtheorem{proposition}{\propositionname}[chapter]
    \newtheorem{envdefinition}{\definitionname}[chapter]
    \newtheorem{conjecture}{\conjecturename}[chapter]
    \newtheorem{envexample}{\examplename}[chapter]
    \newtheorem{exercise}{\exercisename}[chapter]
    \newtheorem{property}{\propertyname}[chapter]
    \newtheorem{remark}{\remarkname}[chapter]
    \def\squareforqed{\hbox{\rlap{$\sqcap$}$\sqcup$}}
    \def\qed{%
      \ifmmode\squareforqed
      \else{\unskip\nobreak\hfil\penalty50\hskip1em\null\nobreak\hfil
            \squareforqed\parfillskip=0pt\finalhyphendemerits=0\endgraf}%
      \fi
    }%
    \newenvironment{proof}%
      {\emph{\proofname:}\begin{small}}{\end{small}\qed\vskip12pt}
    \newenvironment{example}[1]%
      {\begin{envexample}[#1]\begin{slshape}}{\end{slshape}\end{envexample}}
    \newcounter{defcounter}[chapter]
    \newenvironment{definition}[1]{%
      \begin{envdefinition}[#1]%
        \stepcounter{defcounter}%
        \addcontentsline{lod}{subsection}{%
          \protect{\normalfont\definitionname\nobreakspace
                   \thechapter.\arabic{defcounter}: #1}}%
    }{\end{envdefinition}}%
    \newcounter{thcounter}[chapter]
    \newenvironment{theorem}[1]{%
      \begin{envtheorem}[#1]%
        \stepcounter{thcounter}%
        \addcontentsline{loth}{subsection}{%
          \protect{\normalfont\theoremname\nobreakspace
                   \thechapter.\arabic{thcounter}: #1}}%
    }{\end{envtheorem}}%
  }
\fi

% unibral
\if@optunibral
  \AtEndOfClass{%
    \renewcommand{\titlepageadvisorinfo}{%
      \@ifundefined{@advisor}{}{\advisorname:~\@advisor\\}%
      \@ifundefined{@coadvisor}{}{\coadvisorname:~\@coadvisor\\}%
      \@ifundefined{@advisorDE}{}{\advisornameDE:~\@advisorDE\\}%
      \@ifundefined{@coadvisorDE}{}{\coadvisornameDE:~\@coadvisorDE\\}%
    }%
    \DeclareRobustCommand{\advisorDE}[3][]{%
      \gdef\@advisorDElast{#2}\gdef\@advisorDEfirst{#3}%
      \gdef\@advisorDE{#1~#3 #2}%
    }%
    \DeclareRobustCommand{\coadvisorDE}[3][]{%
      \gdef\@coadvisorDElast{#2}\gdef\@coadvisorDEfirst{#3}%
      \gdef\@coadvisorDE{#1~#3 #2}%
    }%
    \renewcommand{\advisorname}{Orientador brasileiro}%
    \renewcommand{\coadvisorname}{Co-orientador brasileiro}%
    \newcommand{\advisornameDE}{Orientador alem\~{a}o}%
    \newcommand{\coadvisornameDE}{Co-orientador alem\~{a}o}%
    \newcommand{\titlepagespecificinfo}{%
      \tcspecificinfo \\ \\
      \unibralspecificinfo
    }%
    \newcommand{\unibralspecificinfo}{%
      Trabalho realizado na Technische Universit\"at Berlin dentro do
      acordo de dupla diploma\c c\~ao UFRGS -- TU~Berlin.%
    }%
    \DeclareRobustCommand{\extendedsummary}[1][ingl\^es]{%
      \chapter*{\extendedsummaryname}\setlength{\parindent}{0pt}%
      \extendedsummarydescr
    }%
    \newcommand{\extendedsummaryname}{Resumo Estendido}%
    \newcommand{\extendedsummarylang}{ingl\^es}%
    \newcommand{\extendedsummarydescr}{%
      Este \'e um resumo estendido em portugu\^es para a Universidade
      Federal do Rio Grande do Sul do original que segue. O trabalho de
      conclus\~ao original, em \extendedsummarylang, foi apresentado na
      Technische Universit\"at Berlin atrav\'es do programa de dupla
      diploma\c c\~ao UNIBRAL II entre as duas universidades.%
    }%
  }
\fi

%==============================================================================
% Nominata (administrative data — from nominata.def)
%==============================================================================
\if@nominatalocal
  \AtEndOfClass{\InputIfFileExists{nominatalocal.def}{}{%
    \ClassWarning{infufrgs}{nominatalocal.def not found}}}
\else
  % Reitoria
  \providecommand{\nominataReit}{Prof\textsuperscript{a}.~Marcia Cristina Bernardes Barbosa}
  \providecommand{\nominataReitname}{Reitora}
  \providecommand{\nominataPRCA}{Prof.~Pedro de Almeida Costa}
  \providecommand{\nominataPRCAname}{Vice-Reitor}
  % PROPG
  \providecommand{\nominataPRAPG}{Prof\textsuperscript{a}.~Claudia Wasserman}
  \providecommand{\nominataPRAPGname}{Pr{\'o}-Reitora de P{\'o}s-Gradua{\c{c}}{\~a}o}
  % Graduação
  \providecommand{\nominataPRAG}{Prof\textsuperscript{a}.~N{\'a}dya Pesce da Silveira}
  \providecommand{\nominataPRAGname}{Pr{\'o}-Reitora de Gradua{\c{c}}{\~a}o}
  % Instituto de Informática
  \providecommand{\nominataDir}{Prof.~Luciano Paschoal Gaspary}
  \providecommand{\nominataDirname}{Diretor do Instituto de Inform{\'a}tica}
  % PPGC
  \providecommand{\nominataCoordPPGC}{Prof.~Gabriel Luca Nazar}
  \providecommand{\nominataCoordnamePPGC}{Coordenador do PPGC}
  % PGMicro
  \providecommand{\nominataCoordPGMICRO}{Prof.~Jos{\'e} Rodrigo Furlanetto de Azambuja}
  \providecommand{\nominataCoordnamePGMICRO}{Coordenador do PGMICRO}
  % Biblioteca
  \providecommand{\nominataBibchefe}{Alexsander Borges Ribeiro}
  \providecommand{\nominataBibchefename}{Bibliotec{\'a}rio-chefe do Instituto de Inform{\'a}tica}
  % INA
  \providecommand{\nominataChefeINA}{Prof.~Leandro Krug Wives}
  \providecommand{\nominataChefeINAname}{Chefe do \deptINA}
  % INT
  \providecommand{\nominataChefeINT}{Prof\textsuperscript{a}.~Mariana Luderitz Kolberg Fernandes}
  \providecommand{\nominataChefeINTname}{Chefe do \deptINT}
  % CIC
  \providecommand{\nominataCoordCIC}{Prof.~{\'A}lvaro Freitas Moreira}
  \providecommand{\nominataCoordCICname}{Coordenador do Curso de Ci{\^e}ncia de Computa{\c{c}}{\~a}o}
  % ECP
  \providecommand{\nominataCoordECP}{Prof.~Paulo Francisco Butzen}
  \providecommand{\nominataCoordECPname}{Coordenador do Curso de Engenharia de Computa{\c{c}}{\~a}o}
\fi

%==============================================================================
% Line spacing and paragraph formatting
%==============================================================================
\newcommand{\setlinespacing}{\setstretch{1.415}}
\setlinespacing

\vfuzz=30pt

\setlength{\parindent}{3em}
\AtBeginDocument{\setlength{\parskip}{0mm}}

%==============================================================================
% Page numbering
%==============================================================================
\def\ps@infufrgs{%
  \let\@oddfoot\@empty
  \let\@evenfoot\@empty
  \def\@evenhead{{\small\thepage}}%
  \def\@oddhead{\hspace*{\fill}{\small\thepage}}%
}
\pagestyle{empty}
\let\ps@plain\ps@empty

%==============================================================================
% Author, advisor and co-advisor
%==============================================================================
\newcounter{ii@authorcount}
\renewcommand{\author}[2]{%
  \addtocounter{ii@authorcount}{1}%
  \expandafter\gdef\csname @author\alph{ii@authorcount}last\endcsname{#1}%
  \expandafter\gdef\csname @author\alph{ii@authorcount}first\endcsname{#2}%
  \expandafter\gdef\csname @author\alph{ii@authorcount}\endcsname{#2 #1}%
}
\DeclareRobustCommand{\advisor}[3][]{%
  \gdef\@advisorlast{#2}%
  \gdef\@advisorfirst{#3}%
  \gdef\@advisor{#1~#3 #2}%
}
\DeclareRobustCommand{\coadvisor}[3][]{%
  \gdef\@coadvisorlast{#2}%
  \gdef\@coadvisorfirst{#3}%
  \gdef\@coadvisor{#1~#3 #2}%
}

%==============================================================================
% Department
%==============================================================================
\newcommand{\dept}[1]{\gdef\@dept{#1}}

%==============================================================================
% Keywords (up to 10)
%==============================================================================
\newcounter{kwcounter}
\newcommand{\keyword}[1]{%
  \addtocounter{kwcounter}{1}%
  \expandafter\gdef\csname keyw\alph{kwcounter}\endcsname{#1}%
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
  \@ifundefined{keywa}{}{\keywa.}%
  \@ifundefined{keywb}{}{ \keywb.}%
  \@ifundefined{keywc}{}{ \keywc.}%
  \@ifundefined{keywd}{}{ \keywd.}%
  \@ifundefined{keywe}{}{ \keywe.}%
  \@ifundefined{keywf}{}{ \keywf.}%
  \@ifundefined{keywg}{}{ \keywg.}%
  \@ifundefined{keywh}{}{ \keywh.}%
  \@ifundefined{keywi}{}{ \keywi.}%
  \@ifundefined{keywj}{}{ \keywj.}%
}

%==============================================================================
% Keywords in second language (up to 10)
%==============================================================================
\newcounter{translatedkwcounter}
\newcommand{\translatedkeyword}[1]{%
  \addtocounter{translatedkwcounter}{1}%
  \expandafter\gdef\csname translatedkeyw\alph{translatedkwcounter}\endcsname{#1}%
}
\newcommand{\@translatedabstractkw}{%
  \@ifundefined{translatedkeywa}{}{\translatedkeywa.}%
  \@ifundefined{translatedkeywb}{}{ \translatedkeywb.}%
  \@ifundefined{translatedkeywc}{}{ \translatedkeywc.}%
  \@ifundefined{translatedkeywd}{}{ \translatedkeywd.}%
  \@ifundefined{translatedkeywe}{}{ \translatedkeywe.}%
  \@ifundefined{translatedkeywf}{}{ \translatedkeywf.}%
  \@ifundefined{translatedkeywg}{}{ \translatedkeywg.}%
  \@ifundefined{translatedkeywh}{}{ \translatedkeywh.}%
  \@ifundefined{translatedkeywi}{}{ \translatedkeywi.}%
  \@ifundefined{translatedkeywj}{}{ \translatedkeywj.}%
}

%==============================================================================
% Date
%==============================================================================
\renewcommand{\date}[2]{%
  \gdef\@publmonth{#1}%
  \gdef\@publyear{#2}%
}
\date{\monthname}{\number\year}

%==============================================================================
% Title page
%==============================================================================
\newlength{\titlepagewinwidth}\setlength{\titlepagewinwidth}{95mm}
\newlength{\titlepagewinheight}\setlength{\titlepagewinheight}{64mm}
\newlength{\titlepagewinvoffset}\setlength{\titlepagewinvoffset}{112mm}

\newcommand{\location}[2]{%
  \gdef\@city{#1}%
  \gdef\@state{#2}%
}
\location{Porto~Alegre}{RS}

\renewcommand{\maketitle}{%
  \setstretch{0.92}%
  \hypersetup{%
    pdftitle={\@title},%
    pdfauthor={%
      \@authora
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
  \@ifundefined{@cipspecificinfo}{\@makenominatapage}{\@makecippage}%
  \setlinespacing
}

\newcommand{\thetitlepage}{%
  \noindent\@topbox\\
  \vspace{5.9ex}\\
  \setstretch{0.95}%
  \@ifundefined{titlepagespecificinfo}{}{%
    \hspace*{\fill}\makebox[.56\textwidth][l]{%
      \parbox[b]{0.56\textwidth}{\lefthyphenmin=64\titlepagespecificinfo}%
    }%
    \vspace{5.5ex}\\
  }%
  \@ifundefined{@advisor}{}{%
    \hspace*{\fill}\makebox[.56\textwidth][l]{%
      \parbox[b]{0.56\textwidth}{\raggedright\lefthyphenmin=64\titlepageadvisorinfo}%
    }%
    \vfill
  }%
  \centerline{\@city}%
  \centerline{\ii@date}%
  \vspace{8mm}%
}

\def\@topbox{%
  \parbox[t]{\textwidth}{%
    \centering
    \vbox to \titlepagewinvoffset{%
      \titlepagetopinfo\vfill\@winbox
    }%
  }%
}

\def\@winbox{%
  \parbox[b]{\titlepagewinwidth}{%
    \centering\vbox to \titlepagewinheight{%
      \vspace*{3ex}%
      \MakeUppercase{\@authora}\\
      \@ifundefined{@authorb}{}{\MakeUppercase{\@authorb}\\}%
      \@ifundefined{@authorc}{}{\MakeUppercase{\@authorc}\\}%
      \@ifundefined{@authord}{}{\MakeUppercase{\@authord}\\}%
      \vspace{12.65ex}%
      {\large\textbf{\@title}\par}%
      \vfill
    }%
  }%
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
% CIP (Catalogação na Publicação) page and nominata
%==============================================================================
\newcommand{\@makecippage}{%
  \clearpage
  \begin{center}
    \textbf{\cipcaption}\\[2ex]
    \iiu@cipwindow
  \end{center}
  \vfill
  \nominata
}

\newcommand{\@makenominatapage}{%
  \clearpage
  ~\vfill
  \nominata
}

\def\iiu@cipwindow{%
  \framebox[120mm]{%
    \begin{minipage}{110mm}%
      \vspace*{0.2ex}%
      \setlength{\parindent}{1.5em}%
      \setlength{\parskip}{1.3ex}%
      \noindent\@authoralast, \@authorafirst\par
      \@title\ / \@authora.\ -- \@city: \nomeDoProgramaPG~da~UFRGS, \@publyear.\par
      \pageref{LastPage}~f.: il.\par
      \@cipspecificinfo\ -- \ufrgs. \@course, \@city,
        BR--\@state, \@publyear. \advisorname: \@advisorfirst\ \@advisorlast
        \@ifundefined{@coadvisor}{}{; \coadvisorname:
          \@coadvisorfirst\ \@coadvisorlast}.\par
      \@cipkw I.~\@advisorlast, \@advisorfirst.
        \@ifundefined{@coadvisorfirst}{II.~T\'{\i}tulo.}{%
          II.~\@coadvisorlast, \@coadvisorfirst. III.~T\'{\i}tulo.}\\
      \vspace{0.2ex}%
    \end{minipage}%
  }%
}

\newcommand{\nominata}{%
  \setstretch{0.95}%
  \noindent\MakeUppercase{\ufrgs}

  \noindent\nominataReitname: \nominataReit

  \noindent\nominataPRCAname: \nominataPRCA

  \noindent\nominataPRAPGname: \nominataPRAPG

  \noindent\nominataDirname: \nominataDir

  \noindent\nominataCoordname: \nominataCoord

  \noindent\nominataBibchefename: \nominataBibchefe

  \setlinespacing
  \vspace{18.25mm}%
}

%==============================================================================
% Table of contents formatting
% Replaces the deprecated tocstyle package with tocloft-based settings.
% - Chapter entries: bold + uppercase (uppercase applied at \addcontentsline)
% - Section entries: bold
% - LOF/LOT entries prefixed with figure/table name
%==============================================================================

% No indentation (flat style, equivalent to tocfullflat)
\setlength{\cftchapindent}{0pt}
\setlength{\cftsecindent}{0pt}
\setlength{\cftsubsecindent}{0pt}
\setlength{\cftsubsubsecindent}{0pt}
\setlength{\cftparaindent}{0pt}

% Chapter: bold font + bold page number, no dot leader (like section headings)
\renewcommand{\cftchapfont}{\bfseries}
\renewcommand{\cftchappagefont}{\bfseries}
\renewcommand{\cftchapleader}{\cftdotfill{\cftnodots}}
\renewcommand{\cftnodots}{0}          % no dots for chapters (style preference)

% Section: bold font + bold page number
\renewcommand{\cftsecfont}{\bfseries}
\renewcommand{\cftsecpagefont}{\bfseries}

% Number widths
\setlength{\cftchapnumwidth}{0pt}
\setlength{\cftsecnumwidth}{2.5em}
\setlength{\cftsubsecnumwidth}{3.3em}
\setlength{\cftsubsubsecnumwidth}{4.1em}

% LOF: prefix each entry with the figure name (e.g. "Figura 1.1 ...")
\renewcommand{\cftfigpresnum}{\figurename\hspace{0.2em}}
\AtBeginDocument{\settowidth{\cftfignumwidth}{\cftfigpresnum 99.99\quad}}

% LOT: prefix each entry with the table name (e.g. "Tabela 1.1 ...")
\renewcommand{\cfttabpresnum}{\tablename\hspace{0.2em}}
\AtBeginDocument{\settowidth{\cfttabnumwidth}{\cfttabpresnum 99.99\quad}}

% Suppress tocloft's default spacing between chapters in TOC
\renewcommand{\cftbeforechapskip}{1.0em \@plus\p@}

\renewcommand{\@dotsep}{0}

\newlength{\dottedspace}

\setcounter{tocdepth}{3}

\newif\if@aftertoc
\@aftertocfalse

\renewcommand{\tableofcontents}{%
  \chapter*{\contentsname}%
  \vspace{0.4\baselineskip}%
  \setstretch{0.95}%
  \@starttoc{toc}\@aftertoctrue
  \setlinespacing
}

\renewcommand{\listoffigures}{%
  \chapter*{\listfigurename}%
  \setstretch{0.95}%
  \@starttoc{lof}%
  \setlinespacing
}

\renewcommand{\listoftables}{%
  \chapter*{\listtablename}%
  \setstretch{0.95}%
  \@starttoc{lot}%
  \setlinespacing
}

%==============================================================================
% Lists of abbreviations and symbols
%==============================================================================
\newenvironment{listofabbrv}[1]{%
  \chapter*{\listabbrvname}%
  \begin{list}{\textbf{??}}{%
    \settowidth{\labelwidth}{#1}%
    \setlength{\labelsep}{1em}%
    \setlength{\itemindent}{0mm}%
    \setlength{\leftmargin}{\labelwidth}%
    \addtolength{\leftmargin}{\labelsep}%
    \setlength{\rightmargin}{0mm}%
    \setlength{\itemsep}{.1\baselineskip}%
    \renewcommand{\makelabel}[1]{\makebox[\labelwidth][l]{##1}}%
  }%
}{%
  \end{list}%
}

\newenvironment{listofsymbols}[1]{%
  \chapter*{\listsymbolname}%
  \begin{list}{\textbf{??}}{%
    \settowidth{\labelwidth}{#1}%
    \setlength{\labelsep}{1em}%
    \setlength{\itemindent}{0mm}%
    \setlength{\leftmargin}{\labelwidth}%
    \addtolength{\leftmargin}{\labelsep}%
    \setlength{\rightmargin}{0mm}%
    \setlength{\itemsep}{.1\baselineskip}%
    \renewcommand{\makelabel}[1]{\makebox[\labelwidth][l]{##1}}%
  }%
}{%
  \end{list}%
}

%==============================================================================
% Abstract and translated abstract
%==============================================================================
\renewenvironment{abstract}{%
  \chapter*{\abstractname}\setlength{\parindent}{0pt}%
}{%
  \ifnum\value{kwcounter}>0
    \\
    \vspace{\parskip}\noindent\textbf{\keywordsname:} \@abstractkw
  \fi
}

\newenvironment{translatedabstract}{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \iflanguage{english}{%
    \begin{otherlanguage}{brazilian}%
  }{%
    \begin{otherlanguage}{english}%
  }%
  \@ifundefined{@translatedtitle}{%
    \ClassWarningNoLine{infufrgs}{Translated title not defined.
      Use \protect\translatedtitle to define it}%
  }{%
    \begin{center}%
      \textbf{\@translatedtitle}%
      \vspace{12pt}%
    \end{center}%
  }%
  \samepagechapter*{\abstractname}\setlength{\parindent}{0pt}%
}{%
  \ifnum\value{kwcounter}>0
    \ifnum\value{translatedkwcounter}>0
      \vspace{12pt}
      \noindent\textbf{\keywordsname:} \@translatedabstractkw
    \else
      \ClassWarningNoLine{infufrgs}{No translated keywords defined.
        Use \protect\translatedkeyword to define them.}%
    \fi
  \fi
  \end{otherlanguage}%
}

\newcommand{\translatedtitle}[1]{\gdef\@translatedtitle{#1}}

% Deprecated environment kept for backwards compatibility
\newenvironment{englishabstract}[2]{%
  \ClassWarning{infufrgs}{The 'englishabstract' environment is deprecated;
    use 'translatedabstract' instead}%
  \if@openright\cleardoublepage\else\clearpage\fi
  \gdef\@englishkeywords{#2}%
  \iflanguage{english}{%
    \begin{otherlanguage}{brazilian}%
  }{%
    \begin{otherlanguage}{english}%
  }%
  \begin{center}%
    \textbf{#1}%
    \vspace{12pt}%
  \end{center}%
  \samepagechapter*{\abstractname}\setlength{\parindent}{0pt}%
}{%
  \vspace{12pt}

  \noindent\textbf{\keywordsname:} \@englishkeywords.
  \end{otherlanguage}%
}

%==============================================================================
% Chapter formatting
%==============================================================================
\newcounter{schapter}
\newcommand{\ii@chapterfont}{\@setfontsize\Large{12}{18}}
\def\@chapapp{}
\def\@chapappextra{}
\def\@chappositioning{\noindent}
\gdef\iiu@hyprefix{CHAPTER}   % changes to APPENDIX / ANNEX as needed

\def\@chapter[#1]#2{%
  \xdef\Hy@chapapp{\iiu@hyprefix}%
  \gdef\theHchapter{\iiu@hyprefix.\thechapter}%
  \refstepcounter{chapter}%
  \addcontentsline{toc}{chapter}{%
    \@chapapp\thechapter~\@chapappextra
    \texorpdfstring{\MakeUppercase{#1}}{#1}}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \addtocontents{lol}{\protect\addvspace{10\p@}}%
  \pagestyle{infufrgs}\let\ps@plain\ps@infufrgs
  \@makechapterhead{#2}{\@chappositioning}\@afterheading
}

\def\@makechapterhead#1#2{%
  \reset@font{#2{\ii@chapterfont\textbf{%
    \@chapapp\thechapter\hphantom{~}\@chapappextra\MakeUppercase{#1}}\par}}%
  \addvspace{\baselineskip}%
  \noindent
}

\newcommand\samepagechapter{%
  \global\@topnum\z@
  \@afterindentfalse
  \secdef\@chapter\@schapter}

\def\@schapter#1{%
  \xdef\Hy@chapapp{SCHAPTER}%
  \refstepcounter{schapter}%
  \if@aftertoc
    \hyperdef{SCHAPTER}{\theschapter}{}%
    \@makeschapterhead{#1}\@afterheading
    \addcontentsline{toc}{chapter}{%
      \@chapapp\xspace{}\@chapappextra
      \texorpdfstring{\MakeUppercase{#1}}{#1}}%
  \else
    \pdfbookmark[0]{#1}{MUTESCHAPTER.\theschapter}%
    \@makeschapterhead{#1}\@afterheading
  \fi
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
}

\def\@makeschapterhead#1{%
  \reset@font\centerline{%
    \ii@chapterfont\textbf{\MakeUppercase{\@chapapp\xspace{}\@chapappextra#1}}}%
  \addvspace{18pt}%
}

\renewcommand{\appendix}[1][\appendixname]{%
  \setcounter{chapter}{0}%
  \renewcommand{\thechapter}{\Alph{chapter}}%
  \gdef\@chapapp{\texorpdfstring{\MakeUppercase{#1}}{#1}\space}%
  \gdef\@chapappextra{---\space}%
  \gdef\@chappositioning{\centering}%
  \gdef\iiu@hyprefix{APPENDIX}%
}

\newcommand{\annex}{%
  \setcounter{chapter}{0}%
  \renewcommand{\thechapter}{\Alph{chapter}}%
  \gdef\@chapapp{\texorpdfstring{\MakeUppercase{\annexname}}{\annexname}\space}%
  \gdef\@chapappextra{---\space}%
  \gdef\@chappositioning{\centering}%
  \gdef\iiu@hyprefix{ANNEX}%
}

%==============================================================================
% Section formatting
%==============================================================================
\setcounter{secnumdepth}{5}
\renewcommand{\@seccntformat}[1]{\csname the#1\endcsname\ }

\titleformat{\section}[hang]{\bfseries}{\thesection~}{0pt}{}
\titlespacing\section{0pt}{1.5\baselineskip}{\baselineskip}
\titleformat*{\subsection}{\reset@font\normalsize\bfseries}
\titlespacing\subsection{0pt}{1.5\baselineskip}{\baselineskip}
\titleformat*{\subsubsection}{\reset@font\normalsize\itshape}
\titlespacing\subsubsection{0pt}{1\baselineskip}{0.5\baselineskip}
\titleformat*{\paragraph}{\reset@font\normalsize}
\titlespacing\paragraph{0pt}{1\baselineskip}{0.5\baselineskip}

%==============================================================================
% Long quotations
%==============================================================================
\renewenvironment{quote}{%
  \setstretch{1}%
  \small
  \begin{list}{}{\setlength{\leftmargin}{40mm}\item\relax}%
  \fontsize{10bp}{12bp}\selectfont
}{%
  \end{list}%
}

%==============================================================================
% List environments
%==============================================================================
\renewenvironment{enumerate}{%
  \begin{list}{\arabic{enumi}.}{%
    \topsep=6pt\itemsep=2pt\parsep=0pt\partopsep=0pt\usecounter{enumi}}%
}{\end{list}}

\renewenvironment{itemize}{%
  \begin{list}{\bfseries\upshape $\bullet$}{%
    \topsep=6pt\itemsep=2pt\parsep=0pt\partopsep=0pt}%
}{\end{list}}

\renewenvironment{description}{%
  \begin{list}{}{%
    \topsep=6pt\itemsep=2pt\parsep=0pt\partopsep=0pt
    \labelwidth\z@\itemindent-\leftmargin
    \let\makelabel\descriptionlabel}%
}{\end{list}}

%==============================================================================
% Figure / table captions
%==============================================================================
% \legend{text} — unnumbered caption (same as \caption* but restores normal size)
\newcommand{\legend}[1]{\caption*{\normalsize #1}}

%==============================================================================
% Convenience environments
%==============================================================================
\newcommand{\cip}{}   % no-op kept for backwards compatibility

\newenvironment{dedicatoria}{%
  \clearpage\mbox{}\vfill\begin{flushright}%
}{%
  \end{flushright}%
}

\newenvironment{agradecimentos}{%
  \chapter*{Agradecimentos}%
}{}

%==============================================================================
% End of infufrgs.cls
%==============================================================================
