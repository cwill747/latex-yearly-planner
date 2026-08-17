\ExplSyntaxOn
\cs_new_eq:NN \Repeat \prg_replicate:nn
\ExplSyntaxOff

\NewDocumentCommand{\myMinLineHeight}{m}{\parbox{0pt}{\vskip#1}}
\NewDocumentCommand{\myDummyQ}{}{\textcolor{white}{Q}}

{{- $numbers := .Cfg.Layout.Numbers -}}
\newcommand{\myNumArrayStretch}{ {{- $numbers.ArrayStretch -}} }
\newcommand{\myNumWeeklyLines}{ {{- $numbers.WeeklyLines -}} }
\newcommand{\myNumDailyTodos}{ {{- $numbers.DailyTodos -}} }
\newcommand{\myNumDailyBottomHour}{ {{- $numbers.DailyBottomHour -}} }
\newcommand{\myNumDailyTopHour}{ {{- $numbers.DailyTopHour -}} }
\newcommand{\myNumDailyDiaryGrateful}{ {{- $numbers.DailyDiaryGrateful -}} }
\newcommand{\myNumDailyDiaryBest}{ {{- $numbers.DailyDiaryBest -}} }
\newcommand{\myNumDailyDiaryLog}{ {{- $numbers.DailyDiaryLog -}} }
\newcommand{\myNumColsForDay}{ {{- $numbers.ColumnsForDay -}} }

\newlength{\myLenTabColSep}
\newlength{\myLenLineThicknessDefault}
\newlength{\myLenLineThicknessThick}
\newlength{\myLenLineHeightButLine}
\newlength{\myLenTwoColSep}
\newlength{\myLenTwoCol}
\newlength{\myLenTriColSep}
\newlength{\myLenTriCol}
\newlength{\myLenQuadColSep}
\newlength{\myLenQuadCol}
\newlength{\myLenFiveColSep}
\newlength{\myLenFiveCol}
\newlength{\myLenMonthlyCellHeight}
\newlength{\myLenNotesIndexCellHeight}
\newlength{\myLenHeaderResizeBox}
\newlength{\myLenHeaderSideQuartersWidth}
\newlength{\myLenHeaderSideMonthsWidth}
\newlength{\myLenChosenCol}
\newlength{\myLenChosenColSep}
\newlength{\myLenChosenColLargeContent}
\newlength{\myLenDotDiameter}

{{- $lengths := .Cfg.Layout.Lengths -}}
\setlength{\myLenTabColSep}{ {{- $lengths.TabColSep -}} }
\setlength{\myLenLineThicknessDefault}{ {{- $lengths.LineThicknessDefault -}} }
\setlength{\myLenLineThicknessThick}{ {{- $lengths.LineThicknessThick -}} }
\setlength{\myLenLineHeightButLine}{ {{- $lengths.LineHeightButLine -}} }
\setlength{\myLenTwoColSep}{ {{- $lengths.TwoColSep -}} }
\setlength{\myLenTwoCol}{\dimexpr.5\linewidth-.5\myLenTwoColSep}
\setlength{\myLenQuadColSep}{ {{- $lengths.QuadColSep -}} }
\setlength{\myLenQuadCol}{\dimexpr.25\linewidth-.25\myLenQuadColSep}
\setlength{\myLenFiveColSep}{ {{- $lengths.FiveColSep -}} }
\setlength{\myLenFiveCol}{\dimexpr.2\linewidth-\myLenFiveColSep}
\setlength{\myLenMonthlyCellHeight}{ {{- $lengths.MonthlyCellHeight -}} }
\setlength{\myLenTriColSep}{ {{- $lengths.TriColSep -}} }
\setlength{\myLenTriCol}{\dimexpr.333\linewidth-.667\myLenTriColSep}
\setlength{\myLenNotesIndexCellHeight}{ {{- $lengths.NotesIndexCellHeight -}} }
\setlength{\myLenHeaderResizeBox}{ {{- $lengths.HeaderResizeBox -}} }
\setlength{\myLenHeaderSideQuartersWidth}{ {{- $lengths.HeaderSideQuartersWidth -}} }
\setlength{\myLenHeaderSideMonthsWidth}{ {{- $lengths.HeaderSideMonthsWidth -}} }
\setlength{\myLenDotDiameter}{ {{- $lengths.DotDiameter -}} }

{{- if eq .Cfg.Layout.Numbers.ColumnsForDay 2 -}}
\setlength{\myLenChosenCol}{\myLenTwoCol}
\setlength{\myLenChosenColSep}{\myLenTwoColSep}
\setlength{\myLenChosenColLargeContent}{\dimexpr1\myLenChosenCol}
{{- else if eq .Cfg.Layout.Numbers.ColumnsForDay 3 -}}
\setlength{\myLenChosenCol}{\myLenTriCol}
\setlength{\myLenChosenColSep}{\myLenTriColSep}
\setlength{\myLenChosenColLargeContent}{\dimexpr2\myLenChosenCol}
{{- else if eq .Cfg.Layout.Numbers.ColumnsForDay 4 -}}
\setlength{\myLenChosenCol}{\myLenQuadCol}
\setlength{\myLenChosenColSep}{\myLenQuadColSep}
\setlength{\myLenChosenColLargeContent}{\dimexpr3\myLenChosenCol}
{{- else -}}
\setlength{\myLenChosenCol}{\myLenFiveCol}
\setlength{\myLenChosenColSep}{\myLenFiveColSep}
\setlength{\myLenChosenColLargeContent}{\dimexpr4\myLenChosenCol}
{{- end -}}

\newcommand{\myColorGray}{ {{- .Cfg.Layout.Colors.Gray -}} }
\newcommand{\myColorLightGray}{ {{- .Cfg.Layout.Colors.LightGray -}} }
\newcommand{\myColorDots}{ {{- .Cfg.Layout.Colors.Dots -}} }
\newcommand{\myColorBackgroundShading}{ {{- .Cfg.Layout.Colors.BackgroundShading -}} }

\newcommand{\myLinePlain}{\hrule width \linewidth height \myLenLineThicknessDefault}
\newcommand{\myLineThick}{\hrule width \linewidth height \myLenLineThicknessThick}

\newcommand{\myLineHeightButLine}{\myMinLineHeight{\myLenLineHeightButLine}}
\NewDocumentCommand{\myUnderline}{m}{#1\vskip1mm\myLineThick\par}
\NewDocumentCommand{\myLineColor}{m}{\textcolor{#1}{\myLinePlain}}
\NewDocumentCommand{\myLineGray}{}{\myLineColor{\myColorGray}}
\NewDocumentCommand{\myLineLightGray}{}{\myLineColor{\myColorLightGray}}
\NewDocumentCommand{\myLineGrayVskipBottom}{}{\myLineGray\vskip\myLenLineHeightButLine}
\NewDocumentCommand{\myLineGrayVskipTop}{}{\vskip\myLenLineHeightButLine\myLineGray}

\NewDocumentCommand{\myTodo}{}{\myLineHeightButLine$\square$\myLinePlain}
\NewDocumentCommand{\myTodoLineGray}{}{\myLineHeightButLine$\square$\myLineGray}
\NewDocumentCommand{\myTodoLineFilled}{m}{\myLineHeightButLine$\square$ #1\myLineGray}

% \myDotFill{<height>} fills <height> with a dot grid. The dot pitch is
% \myLenLineHeightButLine in both directions, so the dots align with the
% ruled areas. The grid spans the current \hsize. <height> takes a rigid
% length or stretch glue such as \fill. \cleaders emits whole rows only,
% so a partial row never overflows the given space.
\NewDocumentCommand{\myDotFill}{m}{%
  \begingroup
  \ifhmode\par\fi
  \hrule height 0pt
  \nobreak
  % One cell: a dot on the bottom edge of a square with the dot pitch as side.
  \setbox0=\hbox to \myLenLineHeightButLine{%
    \hss
    \textcolor{\myColorDots}{\vrule width \myLenDotDiameter height .5\myLenDotDiameter depth .5\myLenDotDiameter}%
    \hss
  }%
  \ht0=\myLenLineHeightButLine
  \dp0=0pt
  \setbox1=\hbox to \hsize{\leaders\copy0\hfil}%
  \ht1=\myLenLineHeightButLine
  \dp1=0pt
  \cleaders\copy1\vskip #1 \hbox{}%
  \endgroup
}

% \myLineFill{<height>} fills <height> with gray ruled lines at the same
% pitch. <height> takes a rigid length or stretch glue such as \fill.
\NewDocumentCommand{\myLineFill}{m}{%
  \begingroup
  \ifhmode\par\fi
  \hrule height 0pt
  \nobreak
  \setbox1=\hbox to \hsize{\textcolor{\myColorGray}{\leaders\hrule height \myLenLineThicknessDefault\hfill}}%
  \ht1=\myLenLineHeightButLine
  \dp1=0pt
  \cleaders\copy1\vskip #1 \hbox{}%
  \endgroup
}

\NewDocumentCommand{\remainingHeight}{}{%
  \ifdim\pagegoal=\maxdimen
    \dimexpr\textheight-9.4pt\relax
  \else
    \dimexpr\pagegoal-\pagetotal-\lineskip-9.4pt\relax
  \fi%
}
