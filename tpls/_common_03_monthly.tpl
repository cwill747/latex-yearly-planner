{{- template "monthTabularV2.tpl" dict "Month" .Body.Month "Large" true -}}
\medskip

{{ if $.Cfg.Dotted -}}
\myUnderline{Notes}
\myLineHeightButLine
\vbox to 0pt{\myMash{20}{30}}
{{- else -}}
\parbox{\myLenTwoCol}{
  \myUnderline{Notes}
  \vbox to \dimexpr\textheight-\pagetotal-\myLenLineHeightButLine\relax {%
    \leaders\hbox to \linewidth{\textcolor{\myColorGray}{\rule{0pt}{\myLenLineHeightButLine}\hrulefill}}\vfil
  }%
}%
\hspace{\myLenTwoColSep}%
\parbox{\myLenTwoCol}{
  \myUnderline{Notes}
  \vbox to \dimexpr\textheight-\pagetotal-\myLenLineHeightButLine\relax {%
    \leaders\hbox to \linewidth{\textcolor{\myColorGray}{\rule{0pt}{\myLenLineHeightButLine}\hrulefill}}\vfil
  }%
}
{{- end}}
