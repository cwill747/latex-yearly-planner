\documentclass[9pt]{extarticle}

% Core packages (load early)
\usepackage{expl3}
\usepackage{xparse}  % Required for \NewDocumentCommand in TeXLive 2023
\usepackage{calc}
\usepackage{geometry}

% Font and encoding
\usepackage{fontspec}
\defaultfontfeatures{Ligatures=TeX,Scale=MatchLowercase}
\setmainfont{Fira Sans}

% Color and graphics
\usepackage[table]{xcolor}
\usepackage{graphicx}
\usepackage{tikz}
\usepackage{adjustbox}

% Table and array packages
\usepackage{array}
\usepackage{tabularx}
\usepackage{multirow}
\usepackage{makecell}

% Layout and spacing
\usepackage{setspace}
\usepackage{leading}
\usepackage{dashrule}
\usepackage{varwidth}
\usepackage{wrapfig}
\usepackage{marginnote}
\usepackage{fancyhdr}

% Math and symbols
\usepackage{mathtools}
\usepackage{amssymb}

% Special features
\usepackage{multido}
\usepackage{pgffor}
\usepackage[most]{tcolorbox}
\usepackage{blindtext}

% Debug packages (conditional)
{{if $.Cfg.Debug.ShowFrame}}\usepackage{showframe}{{end}}

% Hyperref (load last)
\usepackage{hyperref}

\hypersetup{
    {{- if not .Cfg.Debug.ShowLinks}}hidelinks=true{{end -}}
}


\geometry{
  paperwidth={{.Cfg.Layout.Paper.Width}},
  paperheight={{.Cfg.Layout.Paper.Height}},
  top={{.Cfg.Layout.Paper.Margin.Top}},
  bottom={{.Cfg.Layout.Paper.Margin.Bottom}},
  left={{.Cfg.Layout.Paper.Margin.Left}},
  right={{.Cfg.Layout.Paper.Margin.Right}},
  marginparwidth={{.Cfg.Layout.Paper.MarginParWidth}},
  marginparsep={{.Cfg.Layout.Paper.MarginParSep}}
}

\pagestyle{empty}
{{if $.Cfg.Layout.Paper.ReverseMargins}}\reversemarginpar{{end}}
\newcolumntype{Y}{>{\centering\arraybackslash}X}
\setlength{\parindent}{0pt}
\setlength{\fboxsep}{0pt}

\begin{document}
\itshape
{{template "macro.tpl" .}}

  {{range .Pages -}}
    \include{ {{- .Name -}} }
  {{end}}
\end{document}
