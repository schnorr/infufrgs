# infufrgs — LaTeX Class for INF/UFRGS Documents

**infufrgs** is a LaTeX document class that formats theses, dissertations,
monographs and research reports following the typographic and bibliographic
standards required by the **Institute of Informatics (INF)** of the
**Universidade Federal do Rio Grande do Sul (UFRGS)**, Porto Alegre, Brazil.

## Supported document types

| Option | Description |
|---|---|
| `cic` | Ciência da Computação (undergraduate) |
| `ecp` | Engenharia de Computação (undergraduate) |
| `ppgc` | Programa de Pós-Graduação em Computação |
| `pgmicro` | Programa de Pós-Graduação em Microeletrônica |
| `ppgl` | Programa de Pós-Graduação em Letras |
| `dipl` / `tc` | Trabalho de Conclusão (bachelor's monograph) |
| `diss` / `mestrado` | Dissertação de Mestrado |
| `tese` / `doutorado` | Tese de Doutorado |
| `espec` | Monografia de Especialização |
| `ti` | Trabalho Individual |
| `rp` | Relatório de Pesquisa |
| `pep` | Plano de Estudos e Pesquisa |
| `prop-tese` | Proposta de Tese |
| `plano-doutorado` | Plano de Doutorado |
| `formais` | Extra theorem/definition environments |
| `unibral` | UNIBRAL double-degree (UFRGS + TU Berlin) |

Other options:

| Option | Description |
|---|---|
| `english` | Typeset document in English |
| `oneside` | Single-sided layout (default is two-sided) |
| `noabntcite` | Omit automatic loading of `abntex2cite` |
| `nominatalocal` | Read nominata data from `nominatalocal.def` |

## Requirements

This class requires a modern TeX installation (TeX Live 2021 or later is
recommended).  The following packages must be available:

* Standard packages shipped with every TeX distribution:
  `xspace`, `keyval`, `iftex`, `babel` (with `brazilian` and `english`
  language support), `lastpage`, `indentfirst`, `setspace`, `titlesec`,
  `tocloft`, `fancyhdr`, `xcolor`, `graphicx`, `caption`, `hyperref`,
  `hypcap`, `geometry`
* Font packages: `newtxtext` and `newtxmath` (for pdfLaTeX) **or**
  `fontspec` with the *TeX Gyre Termes* font (for XeLaTeX/LuaLaTeX)
* Bibliography: `abntex2cite` (part of the `abntex2` bundle, shipped with
  TeX Live and MiKTeX)

## Quick start

```latex
\documentclass[ppgc,diss]{infufrgs}

\usepackage[utf8]{inputenc}  % for pdfLaTeX; not needed with XeLaTeX/LuaLaTeX
\usepackage{graphicx}

\title{Title of the Document}
\translatedtitle{Translated Title}
\author{Surname}{First Name}
\advisor[Prof.~Dr.]{AdvisorSurname}{AdvisorFirstName}
\date{month}{year}

\keyword{First keyword}
\keyword{Second keyword}
\translatedkeyword{First keyword in other language}
\translatedkeyword{Second keyword in other language}

\begin{document}
\maketitle
\begin{abstract} ... \end{abstract}
\begin{translatedabstract} ... \end{translatedabstract}
\tableofcontents
\listoffigures
\listoftables
\chapter{Introduction} ...
\bibliographystyle{abntex2-alf}
\bibliography{references}
\end{document}
```

See `example.tex` for a complete, compilable example.

## Files

```
infufrgs/
  README.md              — this file
  infufrgs.cls           — the document class (single self-contained file)
  documentation.tex      — user manual (LaTeX source)
  example.tex            — complete compilable usage example
  example.bib            — bibliography database for the example
```

## Compiling the example

```sh
pdflatex example
bibtex   example
pdflatex example
pdflatex example
```

## Changes from previous versions

Version 5.0.0 (2025-03-15) is a major modernisation:

* **Single file**: all auxiliary files (`iidefs.sty`, `*.def`, `*.babel`)
  have been consolidated into `infufrgs.cls`.
* **Replaced `tocstyle`** (deprecated alpha package) with `tocloft`.
* **Replaced `times`** (obsolete font package) with `newtxtext`/`newtxmath`
  for pdfLaTeX and `fontspec`/TeX Gyre Termes for XeLaTeX/LuaLaTeX.
* **Added `iftex`** for robust TeX engine detection.
* **License changed** from GPL-2 to LPPL 1.3c (standard for CTAN packages).
* TOC uppercase chapter titles are now applied cleanly via
  `\texorpdfstring`, so PDF bookmarks keep the normal-case title.

## Maintainer

* Lucas Mello Schnorr (@schnorr)

## License

This work may be distributed and/or modified under the conditions of the
**LaTeX Project Public License**, either version 1.3c of this license or
(at any option) any later version.  The latest version of this license is
in <https://www.latex-project.org/lppl.txt> and version 1.3c or later is
part of all distributions of LaTeX version 2005/12/01 or later.

This work has the LPPL maintenance status *maintained*.

Copyright (C) 2001–2025 UFRGS TeX Users Group  
Institute of Informatics — UFRGS  
Porto Alegre, Brazil  
<https://www.inf.ufrgs.br/utug>
