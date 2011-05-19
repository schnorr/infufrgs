%==============================================================================
% classe para o artigo do seminario de andamento - PPGC/II/UFRGS
% $Id: sa.cls,v 1.1.1.1 2005/01/18 23:54:48 avila Exp $
%
% UFRGS TeX Users Group
% Institute of Informatics --- UFRGS
% Porto Alegre, Brazil
% http://www.inf.ufrgs.br/utug
% Discussion list: utug-l@inf.ufrgs.br
%
% Copyright (C) 2001 UFRGS TeX Users Group
% This is free software, distributed under the GNU GPL; please take
% a look in `iiufrgs.cls' to see complete information on using, copying
% and redistributing these files
%==============================================================================

%==============================================================================
% Identification
%==============================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sa}[2001/05/04 v1.0 Artigo para o Seminario de Andamento]

%==============================================================================
% Optional parameters handling
%==============================================================================
\DeclareOption*{
	\PassOptionsToClass{\CurrentOption}{article}
}

%==============================================================================
% Preliminary declarations
%==============================================================================
\ProcessOptions
\LoadClass[a4paper,11pt]{article}
\RequirePackage{times}
\RequirePackage[english,brazilian]{babel}
\AtBeginDocument{
	\renewcommand{\refname}{REFER{\^E}NCIAS}
}

%==============================================================================
% Document layout
%==============================================================================
% vertical measures
\setlength{\textheight}{247mm}
\setlength{\topmargin}{\paperheight}
	\addtolength{\topmargin}{-\textheight}
	\setlength{\topmargin}{.5\topmargin}
        \addtolength{\topmargin}{.5cm}
\setlength{\headheight}{0mm}
\setlength{\headsep}{0mm}

% horizontal measures
\setlength{\textwidth}{170mm}
\setlength{\oddsidemargin}{\paperwidth}
	\addtolength{\oddsidemargin}{-\textwidth}
	\setlength{\oddsidemargin}{.5\oddsidemargin}
\setlength{\evensidemargin}{\oddsidemargin}

% LaTeX demands that margin parameters be subtracted by 1in
\addtolength{\topmargin}{-1in}	
\addtolength{\oddsidemargin}{-1in}
\addtolength{\evensidemargin}{-1in}

% misc
\setlength{\parindent}{0em}
\addtolength{\parskip}{.8\baselineskip}

%==============================================================================
% No page numbering
%==============================================================================
\pagestyle{empty}

% must redefine this because of \maketitle...
\def\ps@plain{
	\def\@oddhead{}
	\def\@evenhead{}
	\def\@oddfoot{}
	\def\@evenfoot{}
}

%==============================================================================
% Title information
%==============================================================================
\def\@maketitle{%
	\begin{center}
		{\Large\textbf{\@title}\par}
		\vspace{2ex}
		\textbf{\@author}
	\end{center}%
}

%==============================================================================
% Abstract
%==============================================================================
\renewenvironment{abstract}{%
	\noindent\textbf{\abstractname}\\[2ex]
	\itshape
}{
	\par
}

%==============================================================================
% Section headers
%==============================================================================
\def\@seccntformat#1{\csname the#1\endcsname.\enskip}
\DeclareRobustCommand{\section}{
	\@startsection{section}{1}{0pt}{2ex}{.01ex}{\normalsize\textbf}
}

%==============================================================================
% Redefinição da bibliografia
%==============================================================================
\renewenvironment{thebibliography}[1]{
	\section*{\MakeUppercase{\refname}}
	\newcounter{sabibcounter}
	\begin{list}{\@biblabel{\arabic{sabibcounter}}}{
		\usecounter{sabibcounter}
		\settowidth{\labelwidth}{\@biblabel{#1}}
		\setlength{\leftmargin}{\labelwidth}
		\addtolength{\leftmargin}{\labelsep}
		\setlength{\rightmargin}{0mm}
		\setlength{\itemsep}{0ex}
		}
		\sloppy
		\clubpenalty4000
		\@clubpenalty\clubpenalty
		\widowpenalty4000
		\sfcode`\.\@m
}{
		\def\@noitemerr{\@latex@warning{Sem refer{\^e}ncias?}}
	\end{list}
}
