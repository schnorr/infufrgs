%
% iiletter.cls - modelo de carta com logotipo do II/UFRGS
% $Id: iiletter.cls,v 1.1.1.1 2005/01/18 23:54:47 avila Exp $
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
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iiletter}

\DeclareOption{variilogo}{
	\gdef\ii@variilogo{1}
}
\DeclareOption*{
	\PassOptionsToClass{\CurrentOption}{letter}
}
\ProcessOptions\relax
\LoadClass[a4paper,12pt]{letter}
\RequirePackage[brazilian]{babel}
\RequirePackage{graphicx}
    \RequirePackage{keyval}
\RequirePackage{fixltx2e}
\RequirePackage{epstopdf}
\RequirePackage{iidefs}

%
% definicoes padrao
%
\date{Porto~Alegre, \today}
\newcommand{\estilorodape}{\scriptsize\sffamily\bfseries}
\address{
	{\ii} --- {\ufrgs}\\
	Av.~Bento Gon{\c{c}}alves, 9500 Bloco~IV --- Cx.~Postal 15064 --- 91501-970 Porto~Alegre\\
	Phone: +55 51 3316-6165\hspace{2em}Fax: +55 51 3316-7308\hspace{2em}http://www.inf.ufrgs.br
}

%
% definicoes internas
%
\def\linha{\rule[1ex]{\textwidth}{2pt}}
\def\cabecalho{
	\parbox[b]{\textwidth}{\iilogo\\\linha}
}
\def\varcabecalho{
	\makebox[\textwidth]{\variilogo[1.2]}
}
\def\rodape{\parbox[b]{\textwidth}{
	\linha\\
	\estilorodape\centering\fromaddress
}}

%
% definicao do estilo de pagina (cabecalho e rodape)
%
\def\ps@iiletter{
	\let\@evenfoot\@empty
	\let\@evenhead\@empty
	\def\@oddhead{\@ifundefined{ii@variilogo}{\cabecalho}{\varcabecalho}}
	\def\@oddfoot{\rodape}
}
\pagestyle{iiletter}
\let\ps@empty\ps@iiletter
\let\ps@firstpage\ps@iiletter
\let\ps@headings\ps@iiletter

%
% margens e etc
%
\setlength{\topmargin}{20mm}			% margem superior
\settoheight{\headheight}{\cabecalho}
\setlength{\headsep}{10mm}			% dist. cabecalho ao texto
\settoheight{\footskip}{\rodape}
	\addtolength{\footskip}{10mm}		% dist. texto ao rodape
\setlength{\textheight}{\paperheight}
	\addtolength{\textheight}{-8mm}		% margem inferior
	\addtolength{\textheight}{-\topmargin}
	\addtolength{\textheight}{-\headheight}
	\addtolength{\textheight}{-\headsep}
	\addtolength{\textheight}{-\footskip}
\setlength{\oddsidemargin}{30mm}		% margem esquerda
\setlength{\evensidemargin}{30mm}		% margem direita
\setlength{\textwidth}{\paperwidth}
	\addtolength{\textwidth}{-\oddsidemargin}
	\addtolength{\textwidth}{-\evensidemargin}
\addtolength{\topmargin}{-1in}
\addtolength{\oddsidemargin}{-1in}
\addtolength{\evensidemargin}{-1in}
\setlength{\parindent}{4em}

%
% redefine o comando opening para nao colocar o endereco
% no canto superior direito
%
\renewcommand*{\opening}[1]{
	{\raggedleft\@date\par}%
	\vspace{2\parskip}%
	{\raggedright\toname \\ \toaddress \par}%
	\vspace{2\parskip}%
	\noindent#1\par\nobreak
}
