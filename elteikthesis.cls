%% MIT License
%%
%% Version 2.2, 2021/09/20
%% Copyright (c) 2013-2021 Máté Cserép <mcserep@inf.elte.hu>, Bálint Bognár
%%
%% Permission is hereby granted, free of charge, to any person obtaining a copy
%% of this software and associated documentation files (the "Software"), to deal
%% in the Software without restriction, including without limitation the rights
%% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
%% copies of the Software, and to permit persons to whom the Software is
%% furnished to do so, subject to the following conditions:
%%
%% The above copyright notice and this permission notice shall be included in all
%% copies or substantial portions of the Software.
%%
%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
%% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
%% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
%% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
%% SOFTWARE.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{elteikthesis}[2021/09/20 ELTE FI bachelor and master thesis template]

% LaTeX programozói eszközök
\RequirePackage{etoolbox}
\RequirePackage{xparse}
\RequirePackage{ifthen}

% ------------------------------
% Paraméterek feldolgozása
\newtoggle{oneside}\toggletrue{oneside}
\newtoggle{hypenation}\toggletrue{hypenation}
\newtoggle{parspace}\togglefalse{parspace}
\newtoggle{indent}\toggletrue{indent}

\DeclareOption{nohyp}{\togglefalse{hypenation}}
\DeclareOption{parspace}{\toggletrue{parspace}}
\DeclareOption{noindent}{\togglefalse{indent}}
\DeclareOption{twoside}{
	\PassOptionsToClass{\CurrentOption}{report}
	\PassOptionsToClass{openright}{report}
	\togglefalse{oneside}
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions \relax

% Osztály betöltése (alapértelmezett beállítások)
\LoadClass[a4paper, 12pt, oneside]{report}
% ------------------------------

% ------------------------------
% Karakterkódolás, nyelv
\RequirePackage{iftex} % XeTex or LuaTex
\iftutex
	\RequirePackage{fontspec}
\else % other (PdfTex)
	\RequirePackage[utf8]{inputenc}
	\RequirePackage[T1]{fontenc}
\fi
\RequirePackage[english,magyar]{babel}
\RequirePackage{indentfirst}
% ------------------------------

% ------------------------------
% Metaadatok
\DeclareDocumentCommand{\author}{m}{\newcommand{\authorname}{#1}\renewcommand{\@author}{#1}}
\NewDocumentCommand{\degree}{m}{\newcommand{\degreename}{#1}}

\NewDocumentCommand{\supervisor}{m}{\newcommand{\supname}{#1}}
\NewDocumentCommand{\affiliation}{m}{\newcommand{\supaff}{#1}}

\NewDocumentCommand{\extsupervisor}{m}{\newcommand{\extsupname}{#1}}
\NewDocumentCommand{\extaffiliation}{m}{\newcommand{\extsupaff}{#1}}

\NewDocumentCommand{\university}{m}{\newcommand{\univname}{#1}}
\NewDocumentCommand{\faculty}{m}{\newcommand{\facname}{#1}}
\NewDocumentCommand{\department}{m}{\newcommand{\deptname}{#1}}
\NewDocumentCommand{\city}{m}{\newcommand{\cityname}{#1}}
\NewDocumentCommand{\logo}{m}{\newcommand{\logofilename}{#1}}

\DeclareDocumentCommand{\title}{m}{\newcommand{\thesistitle}{#1}\renewcommand{\@title}{#1}}
\DeclareDocumentCommand{\date}{m}{\newcommand{\thesisyear}{#1}\renewcommand{\@date}{#1}}
% ------------------------------

% ------------------------------
% Fordítások
\DeclareDocumentCommand{\documentlang}{m}{
	\selectlanguage{#1}

	% Magyar
	\ifthenelse{\equal{\detokenize{#1}}{\detokenize{magyar}}}
	{
		\newcommand{\authorlabel}{Szerző}
		\newcommand{\suplabel}{Témavezető}
		\newcommand{\intsuplabel}{Belső témavezető}
		\newcommand{\extsuplabel}{Külső témavezető}

		\newcommand{\deflabel}{Definíció}
		\newcommand{\theolabel}{Tétel}
		\newcommand{\remlabel}{Emlékeztető}
		\newcommand{\notelabel}{Megjegyzés}

		\newcommand{\codelabel}{forráskód}
		\newcommand{\alglabel}{Algoritmus}

		\newcommand{\biblabel}{Irodalomjegyzék}
		\newcommand{\lstalgorithmlabel}{Algoritmusjegyzék}
		\newcommand{\lstfigurelabel}{Ábrajegyzék}
		\newcommand{\lsttablelabel}{Táblázatjegyzék}
		\newcommand{\lstcodelabel}{Forráskódjegyzék}
		\newcommand{\lstnomencl}{Jelölésjegyzék}
		\newcommand{\todolabel}{Teendők listája}

		\newcommand{\declarationplaceholder}{Az eredeti szakdolgozati / diplomamunka témabejelentő helye.}
	}
	{ % Angol
		\newcommand{\authorlabel}{Author}
		\newcommand{\suplabel}{Supervisor}
		\newcommand{\intsuplabel}{Internal supervisor}
		\newcommand{\extsuplabel}{External supervisor}

		\newcommand{\deflabel}{Definition}
		\newcommand{\theolabel}{Theorem}
		\newcommand{\remlabel}{Remark}
		\newcommand{\notelabel}{Note}

		\newcommand{\codelabel}{Code}
		\newcommand{\alglabel}{Algorithm}

		\newcommand{\biblabel}{Bibliography}
		\newcommand{\lstalgorithmlabel}{List of Algorithms}
		\newcommand{\lstfigurelabel}{List of Figures}
		\newcommand{\lsttablelabel}{List of Tables}
		\newcommand{\lstcodelabel}{List of Codes}
		\newcommand{\lstnomencl}{List of Symbols}
		\newcommand{\todolabel}{Todo list}

		\newcommand{\declarationplaceholder}{This page should be the original Thesis Topic Declaration.}
	}
}
% ------------------------------

% ------------------------------
% Margók
\RequirePackage[left=35mm, right=25mm, top=25mm, bottom=25mm, headheight=16pt]{geometry}
%\setlength{\textwidth}{150mm}
%\setlength{\textheight}{247mm}
% ------------------------------

% ------------------------------
% Fejlécek és láblécek
\RequirePackage{fancyhdr}
\pagestyle{fancy}

% Chapter és section információk stílusának felüldefiniálása
\renewcommand{\chaptermark}[1]{\markboth{\thechapter.\ #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection.\ #1}{}}
% Fej- és lábléc vonalak beállítása
\renewcommand{\headrulewidth}{1pt}
\renewcommand{\footrulewidth}{0pt}

% Fejléc törlése
\fancyhead{}
% Fejléc beállítása
\iftoggle{oneside}{ % egyoldalashoz
	\fancyhead[C]{\slshape \leftmark}
}{ % kétoldalashoz
	\fancyhead[EC]{\slshape \leftmark}
	\fancyhead[OC]{\slshape \rightmark}
}

% Fejléc és lábléc távolsága a tartalomtól
\topskip = 15pt		% default: 10pt
\footskip = 40pt	% default: 30pt

% Lábléc törlése
\fancyfoot{}
% Lábléc beállítása
\fancyfoot[C]{\thepage}

% A chapter page-k mindig visszaállnak plain style-ra, ezért azt is felül kell külön definiálni.
\fancypagestyle{plain}{
	% Fejléc vonal letiltása
	\renewcommand{\headrulewidth}{0pt}
	% Teljes fejléc és lábléc törlés
	\fancyhf{}
	% Lábléc beállítása
    \fancyfoot[C]{\thepage}
}

% Üres oldalakon ne legyen fej- és lábléc
% http://www.tex.ac.uk/cgi-bin/texfaq2html?label=reallyblank
\let\origdoublepage\cleardoublepage
 \newcommand{\clearemptydoublepage}{
   \clearpage
   {\pagestyle{empty}\origdoublepage}
 }
\let\cleardoublepage\clearemptydoublepage
% ------------------------------

% ------------------------------
% Grafika
\RequirePackage{graphicx}
\RequirePackage{float}
% Maximális ill. minimális méret megadása ábráknak
\RequirePackage[export]{adjustbox}
% Több ábra egy figure-on belül
\RequirePackage{subcaption}
% Ábrák forgatása
\RequirePackage{rotating}

% Az EPS fájlok támogatása pdflatex használata esetén
\RequirePackage{epstopdf}
% Képek kiterjesztési prioritása
\DeclareGraphicsExtensions{.pdf,.eps,.png,.jpg}
% Képek tárolási helye
\graphicspath{{./images/}}
% Ábrajegyzék elnevezése
\renewcommand{\listfigurename}{\lstfigurelabel}
% ------------------------------

% ------------------------------
% Papírméret
\paperwidth 210mm
\paperheight 297mm
% ------------------------------

% ------------------------------
% Térköz bekezdések közé
\iftoggle{parspace}{
	\RequirePackage{parskip}
	% A bekezdések első soros behúzása maradjon meg
	\iftoggle{indent}{
		\setlength{\parindent}{3.5ex}
	}{}
}{
	% Nincs se térköz, se behúzás
	\nottoggle{indent}{
		\RequirePackage[skip=0pt]{parskip}
	}{
		% alapértelmezés szerint nincs térköz, de van behúzás
	}
}
% ------------------------------

% ------------------------------
% Árva- és fattyúsorok tiltása
\clubpenalty=3000
\widowpenalty=3000
% ------------------------------

% ------------------------------
% Helyközök és tördelés
% Egyszeres helyköz a mondatok végén
\frenchspacing
% Szavak jobb margón túlnyúlásának tiltása
\sloppy
% Szavak elválasztásának tiltása
\nottoggle{hypenation}{\RequirePackage[none]{hyphenat}}{}

% Beállítás alternatív módon
\RequirePackage{setspace}
% According to
% https://tex.stackexchange.com/questions/442030/setting-spaces-with-titlespacing-and-fonts
% this matches the 1.5 linespacing in MS Word
\setstretch{1.427465}

% Vektorok és mátrixok egyszeres sorközzel
% https://tex.stackexchange.com/questions/568084/problem-with-matrices-using-linespread
\everydisplay=\expandafter{\the\everydisplay\linespread{1}\selectfont}

% Azonos sorköz használata láblácben
%\RequirePackage{footmisc}
%\setlength{\footnotesep}{\baselineskip}
% ------------------------------

% ------------------------------
% Nagybetűs szavak elválasztásának mellőzése
\uchyph=0
% ------------------------------

% ------------------------------
% Szoros térközű felsorolások
\RequirePackage{paralist}
% ------------------------------

% ------------------------------
% Matematikai mód
\RequirePackage{amsthm}
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\DeclareMathAlphabet{\mathpzc}{OT1}{pzc}{m}{it}
% ------------------------------

% ------------------------------
% Tételek, definíciók
\theoremstyle{definition}
\newtheorem{definition}{\deflabel}

\theoremstyle{plain}
\newtheorem{theorem}{\theolabel}

\theoremstyle{remark}
\newtheorem*{remark}{\remlabel}
\newtheorem*{note}{\notelabel}
% ------------------------------

% ------------------------------
% Times font használata
%\RequirePackage{mathptmx}
% ------------------------------

% ------------------------------
% Színes szövegek
\RequirePackage{color}
\RequirePackage{xcolor}
% Színek
\definecolor{codebackg}{rgb}{0.95,0.95,0.95}
\definecolor{codecomment}{rgb}{0,0.6,0}
\definecolor{codestring}{rgb}{0.58,0,0.82}
\colorlet{todobackg}{orange!10}
% ------------------------------

% ------------------------------
% Hivatkozások
% dvipdfm-hez
%\newcommand{\hyperrefComp}{dvipdfm}
% pdflatex-hez
\newcommand{\hyperrefComp}{}

\RequirePackage[pdfborder={0 0 0}, unicode, pdfusetitle, \hyperrefComp]{hyperref}
\RequirePackage[all]{hypcap}
\RequirePackage{url}
\RequirePackage{bookmark}
% ------------------------------

% ------------------------------
% Multirow és multicolumn táblázathoz
\RequirePackage{multirow}
% Táblázatok tördelése több oldalra
\RequirePackage{longtable}
% Celltartalmak vertikális igazítása
\RequirePackage{array}
% Sortörés táblázat cellákban
\RequirePackage{makecell}
% Táblázatjegyzék elnevezése
\renewcommand{\listtablename}{\lsttablelabel}
% ------------------------------

% ------------------------------
% Felső és alsó indexek
% http://anthony.liekens.net/index.php/LaTeX/SubscriptAndSuperscriptInTextMode
\newcommand{\superscript}[1]{\ensuremath{^{\textrm{\scriptsize{#1}}}}}
\newcommand{\subscript}[1]{\ensuremath{_{\textrm{\scriptsize{#1}}}}}
% ------------------------------

% ------------------------------
% Számozott elemek kezelése
\RequirePackage{chngcntr}
% Lábjegyzet folytonos számozása fejezetek között
% Continuous counting of footnotes among chapters
\counterwithout{footnote}{chapter}
% Lábjegyzet oldalak közti eltörésének tiltása
\interfootnotelinepenalty=10000
% ------------------------------

% ------------------------------
% Lábjegyzet teljes körűbb támogatása (savenotes)
%\RequirePackage{footnote}
% Lábjegyzet kezelése minipage-ekben
% http://www.cs.brown.edu/system/software/latex/doc/mpfnmark.pdf
%\RequirePackage{mpfnmark}
% ------------------------------

% ------------------------------
% Függelék
\RequirePackage{appendix}
% ------------------------------

% ------------------------------
% Irodalomjegyzék
\RequirePackage[style=english]{csquotes}
\RequirePackage[
	backend=bibtex,
	style=numeric, % irodalomjegyzék stílusa
	sorting=none   % idézések rendezettségee
]{biblatex}
% ------------------------------

% ------------------------------
% Feliratok, tartalomjegyzék, ábrajegyzék, táblázatjegyzék
\RequirePackage[justification=centering]{caption}
\RequirePackage{tocloft}

% ------------------------------

% ------------------------------
% Tárgymutató
\RequirePackage{makeidx}
\makeindex
% ------------------------------

% ------------------------------
% Jelölésjegyzék
\RequirePackage[intoc,noprefix,refpage]{nomencl}
% Elemek közötti bigskip kihagyása
\setlength{\nomitemsep}{-\parsep}
% Jobbra igazítás
\renewcommand{\nomlabel}[1]{\hfil \hfil #1}
% Oldalhivatkozás megjelenése
\renewcommand{\pagedeclaration}[1]{, #1}
% Jelölésjegyzék elnevezése
\renewcommand{\nomname}{\lstnomencl}
% Jelölésjegyzék elkészítése (még nem szúrja be)
\makenomenclature
% ------------------------------

% ------------------------------
% Algoritmusok és kódblokkok írása
\RequirePackage{algorithm}
\RequirePackage{algpseudocode}
\RequirePackage{listingsutf8}
\lstset{
	basicstyle=\footnotesize\ttfamily,
	numbers=left,
    numberstyle=\tiny,
    backgroundcolor=\color{codebackg},
	keywordstyle=\color{blue},
	commentstyle=\color{codecomment},
	stringstyle=\color{codestring},
	stepnumber=1,
	firstnumber=1,
	numbersep=5pt,
	showspaces=false,
	showstringspaces=false,
	showtabs=false,
	tabsize=2,
	breaklines=true,
	breakatwhitespace=false,
	float,
	frame=lines,
	captionpos=b
}
%JavaScript
\usepackage{color}
\definecolor{lightgray}{rgb}{.9,.9,.9}
\definecolor{darkgray}{rgb}{.4,.4,.4}
\definecolor{purple}{rgb}{0.65, 0.12, 0.82}
\lstdefinelanguage{JavaScript}{
	keywords={break, case, catch, continue, debugger, default, delete, do, else, false, finally, for, function, if, in, instanceof, new, null, return, switch, this, throw, true, try, typeof, const, void, while, with, this},
	morecomment=[l]{//},
	morecomment=[s]{/*}{*/},
	morestring=[b]',
	morestring=[b]",
	ndkeywords={class, export, boolean, throw, implements, import, save, exports, post, put, delete, then, status, json},
	keywordstyle=\color{blue}\bfseries,
	ndkeywordstyle=\color{darkgray}\bfseries,
	identifierstyle=\color{black},
	commentstyle=\color{purple}\ttfamily,
	stringstyle=\color{red}\ttfamily,
	sensitive=true
}
\lstset{
	language=JavaScript,
	backgroundcolor=\color{lightgray},
	extendedchars=true,
	basicstyle=\footnotesize\ttfamily,
	showstringspaces=false,
	showspaces=false,
	numbers=left,
	numberstyle=\footnotesize,
	numbersep=9pt,
	tabsize=2,
	breaklines=true,
	showtabs=false,
	captionpos=b
}
%json fájl formázás
\lstdefinelanguage{JSON}{
	string=[s]{"}{"},
	stringstyle=\color{blue},
	comment=[l]{:},
	commentstyle=\color{red}\ttfamily,
	identifierstyle=\color{black},
	sensitive=true
}
\lstset{
	language=JSON,
	backgroundcolor=\color{lightgray},
	extendedchars=true,
	basicstyle=\footnotesize\ttfamily,
	showstringspaces=false,
	showspaces=false,
	numbers=left,
	numberstyle=\footnotesize,
	numbersep=9pt,
	tabsize=2,
	breaklines=true,
	showtabs=false,
	captionpos=b
}
% Forráskód elnevezése
\renewcommand{\lstlistingname}{\codelabel}
% Forráskódjegyzék elnevezése
\renewcommand{\lstlistlistingname}{\lstcodelabel}
% Algoritmus elnevezése
\floatname{algorithm}{\alglabel}
\renewcommand{\listalgorithmname}{\lstalgorithmlabel}
% ------------------------------

% ------------------------------
% Teendőlista
% http://www.tex.ac.uk/tex-archive/help/Catalogue/entries/todonotes.html
\RequirePackage[textwidth=30mm, textsize=small, color=todobackg, linecolor=orange, colorinlistoftodos, shadow, obeyFinal]{todonotes}
\RequirePackage[displaymath, tightpage]{preview}
% A bal margóra kerüljenek a TODO-k
\reversemarginpar
\setlength{\marginparwidth}{30mm}
% ------------------------------

% ------------------------------
% Címlap
\renewcommand{\maketitle}{
	\begin{titlepage}

		\begin{center}

			\begin{tabular}{ c c }
				\multirow{4}{*}{\hspace{-1.0cm}\includegraphics[width=0.25\textwidth]{\logofilename}}

				& {\sc \Large \makecell{\univname}} \vspace{0.3cm}\\
				& {\sc \Large \makecell{\facname}} \vspace{0.5cm}\\
				& {\sc \large \makecell{\deptname}}
			\end{tabular}

			\vspace{5.0cm}
			{\bf \LARGE \thesistitle}
			\vspace{4.0cm}

			\ifdefined\extsupaff
				{\it \large \authorlabel:}\\
				{\large \authorname}\\
				\degreename\\
				\vspace{2.0cm}

				\begin{tabular}{ l c l }
					{\it \large \intsuplabel:} &
					\hspace{4.0cm} &
					{\it \large \extsuplabel:}\\

					{\large \supname} &
					\hspace{4.0cm} &
					{\large \extsupname}\\

					\supaff &
					\hspace{4.0cm} &
					\extsupaff\\
				\end{tabular}
			\else
				\vspace{1.0cm}
				\begin{tabular}{ l c l }
					{\it \large \suplabel:} &
					\hspace{4.0cm} &
					{\it \large \authorlabel:}\\

					{\large \supname} &
					\hspace{4.0cm} &
					{\large \authorname}\\

					\supaff &
					\hspace{4.0cm} &
					\degreename\\
				\end{tabular}
			\fi

			\vfill

			{\it \cityname, \thesisyear}

		\end{center}

	\end{titlepage}
}
% ------------------------------

% ------------------------------
% Témabejelentő
\newcommand{\topicdeclaration}{
	\thispagestyle{empty}
	\begin{center}
		\vspace*{\fill}

		{\large \declarationplaceholder}

		\vspace*{\fill}
	\end{center}


	\cleardoublepage
	\setcounter{page}{1}
}
% ------------------------------

\AtBeginDocument{
	% If the minted package is loaded, then provide a default for the formatting,
	% and set the labels for the listings 
	\@ifpackageloaded{minted}{
		\setminted{
			style=tango,
			numbers=left,
			stepnumber=1,
			firstnumber=1,
			numbersep=5pt,
			showspaces=false,
			showtabs=false,
			tabsize=2,
			breaklines=true,
			frame=lines,
			bgcolor=codebackg,
		}
		\SetupFloatingEnvironment{listing}{
			name=\codelabel,        % Forráskód elnevezése
			listname=\lstcodelabel, % Forráskódjegyzék elnevezése
		}
	}

	% Az oldalszámozás a tartalomjegyzékkel kezdődik, de ott nem látható
	\let\oldtableofcontents\tableofcontents
	\renewcommand{\tableofcontents}{
		\pagenumbering{gobble}
		\oldtableofcontents
		\cleardoublepage
		% Oldalszám mentése és betöltésem mert a \pagenumbering visszállítja
		\newcounter{conpageno}
		\defcounter{conpageno}{\value{page}}
		\pagenumbering{arabic}
		\setcounter{page}{\value{conpageno}}
	}
}
