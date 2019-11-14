# Wyss Institute Letterhead

## Installation
Install locally, e.g. to `$TEXMFHOME`:

```
$ make inst
```

Install system-wide, e.g. to `$TEXMFLOCAL`:

```
$ make install
```

## Usage

### LaTeX
Currently, you need to symlink the `branding/` directory from this repository into the directory with your document.  The `branding/` directory contains the Wyss Institute logo that will go in the top-left corner of the document.  I'd like for this step to be unnecessary, but I don't know how to do that at the moment:

```
$ ln -s /path/to/wyssletterhead/branding .
```

Example TeX document:

```tex
documentclass{wyssletter}

\usepackage{lipsum}
\usepackage{graphicx}
\usepackage[colorlinks=true,allcolors=blue]{hyperref}

\newcommand{\mailto}[1]{\href{mailto:\detokenize{#1}}{\detokenize{#1}}}

\name{River Tam}
\desk{528/1C}
\date{\today}
\signature{\includegraphics[height=1in]{signature}}
\email{\mailto{river_tam@wyss.harvard.edu}}
\phone{(555) 867-5309}
\opening{To whom it may concern,}
\closing{Sincerely,}

\begin{document}

\lipsum[1-3]

\end{document}
```

Use LaTeX to compile the document as usual.  Note that to compile this example, you will need an image of your signature, e.g. `signature.pdf`, in the directory with your document:

```
$ pdflatex my_letter
```

### Lyx
The `wyssletterhead` document class can also be used in LyX.  Simply start LyX, then select "Wyss Institute" from Document > Settings > Document Class.  Use the Name, Desk, Email, Phone, Date, etc. paragraph types to specify all the relevant information, and be sure to symlink the `branding/` directory as above.
