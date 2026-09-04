{{- $today := .Body.Day -}}
{{- if .Cfg.ShowDailySchedule -}}
\begin{minipage}[t][\remainingHeight]{\myLenChosenColLargeContent+\myLenChosenColSep}
  \myUnderline{Todo\myDummyQ}
  {{- if and .Cfg.WeeklyCalendarCheckTodo .Body.IsWeeklyReminderDay -}}\myTodoLineFilled{Check Weekly Calendar View}{{- end -}}
  {{- if and .Cfg.MonthlyCalendarCheckTodo .Body.IsFirstDayOfMonth -}}\myTodoLineFilled{Check Monthly Calendar View}{{- end -}}
  \Repeat{\myNumDailyTodos}{\myTodoLineGray}
  \vskip\dimexpr5.4mm
  \myUnderline{Notes \textcolor{\myColorGray}{$\vert$ {{ $today.LinkLeaf "More" "More" }}\hfill{}{{ $today.LinkLeaf "Reflect" "Reflect" }}\hfill{}\hyperlink{Notes Index}{Notes} $\vert$ \hyperlink{Meetings Index}{Meetings}}}
  \myDotFill{\fill}
\end{minipage}%
\hspace{\myLenChosenColSep}%
\begin{minipage}[t]{\myLenChosenCol}
{{template "schedule.tpl" dict "Cfg" .Cfg "Day" .Body.Day}}
  \vspace{\dimexpr4mm+.3pt}

{{- if .Cfg.CalAfterSchedule -}}
{{- template "monthTabularV2.tpl" dict "Month" .Body.Month "Today" $today -}}
{{- end -}}
\end{minipage}%
{{- else -}}
\begin{minipage}[t]{\myLenChosenColLargeContent+\myLenChosenColSep}
  \myUnderline{Todo\myDummyQ}
  {{- if and .Cfg.WeeklyCalendarCheckTodo .Body.IsWeeklyReminderDay -}}\myTodoLineFilled{Check Weekly Calendar View}{{- end -}}
  {{- if and .Cfg.MonthlyCalendarCheckTodo .Body.IsFirstDayOfMonth -}}\myTodoLineFilled{Check Monthly Calendar View}{{- end -}}
  \Repeat{\myNumDailyTodos}{\myTodoLineGray}
\end{minipage}%
\hspace{\myLenChosenColSep}%
\begin{minipage}[t]{\myLenChosenCol}
{{- if .Cfg.CalAfterSchedule }}
  {{- template "monthTabularV2.tpl" dict "Month" .Body.Month "Today" $today -}}
{{- end }}
\end{minipage}%

\vskip\dimexpr5.4mm
\begin{minipage}[t][\remainingHeight]{\myLenChosenColLargeContent+\myLenChosenColSep}
  \myUnderline{Notes \textcolor{\myColorGray}{$\vert$ {{ $today.LinkLeaf "More" "More" }}\hfill{}{{ $today.LinkLeaf "Reflect" "Reflect" }}\hfill{}\hyperlink{Notes Index}{Notes} $\vert$ \hyperlink{Meetings Index}{Meetings}}}
  \myDotFill{\fill}
\end{minipage}%
\hspace{\myLenChosenColSep}%
\begin{minipage}[t][\remainingHeight]{\myLenChosenCol}
  \phantom{Notes\myDummyQ}\vskip1mm\vbox to \myLenLineThicknessThick{}\par
  \myDotFill{\fill}
\end{minipage}%
{{- end -}}
\par\pagebreak
