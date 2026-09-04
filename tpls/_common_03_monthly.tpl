{{- template "monthTabularV2.tpl" dict "Month" .Body.Month "Large" true -}}
\medskip

{{ if $.Cfg.Dotted -}}
\myUnderline{Notes}
\myDotFill{\remainingHeight}
{{- else -}}
\parbox{\myLenTwoCol}{
  \myUnderline{Notes}
  \myLineFill{\remainingHeight}
}%
\hspace{\myLenTwoColSep}%
\parbox{\myLenTwoCol}{
  \myUnderline{Notes}
  \myLineFill{\remainingHeight}
}
{{- end}}
