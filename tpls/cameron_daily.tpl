{{- $today := .Body.Day -}}
{{ template "breadcrumb_00_header.tpl" dict "Cfg" .Cfg "Body" .Body }}
\ifdefined\myCalendarBox\else\newsavebox{\myCalendarBox}\fi
\begin{lrbox}{\myCalendarBox}
  \begin{minipage}[b]{\myLenChosenCol}
    {{- if .Cfg.CalAfterSchedule }}
    {{- template "monthTabularV2.tpl" dict "Month" .Body.Month "Today" $today -}}
    {{- end }}
  \end{minipage}
\end{lrbox}
\myUnderline{Todo\myDummyQ}
{{- if and .Cfg.WeeklyCalendarCheckTodo .Body.IsWeeklyReminderDay }}\myTodoLineFilled{Check Weekly Calendar View}{{- end }}
{{- if and .Cfg.MonthlyCalendarCheckTodo .Body.IsFirstDayOfMonth }}\myTodoLineFilled{Check Monthly Calendar View}{{- end }}
\Repeat{\myNumDailyTodos}{\myTodoLineGray}

\vskip\dimexpr5.4mm
\myUnderline{Notes\hfill{}{{ $today.LinkLeaf "More" "More" }}}
\edef\myDailyNotesHeight{\the\dimexpr\remainingHeight\relax}
\begin{minipage}[t][\myDailyNotesHeight][b]{\linewidth}
  \smash{\makebox[0pt][l]{\begin{minipage}[b][\myDailyNotesHeight][t]{\linewidth}
    \myDotFill[2]{\fill}
  \end{minipage}}}%
  \hfill\raisebox{\dp\myCalendarBox}{\colorbox{white}{\usebox{\myCalendarBox}}}
\end{minipage}%
\par\pagebreak
