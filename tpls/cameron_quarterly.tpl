{\noindent\Large\renewcommand{\arraystretch}{\myNumArrayStretch}
{{ if $.Cfg.ClearTopLeftCorner -}}\kern 5mm{{- end }}{{- .Body.Breadcrumb -}}{{ if $.Cfg.ClearTopRightCorner -}}\kern 5mm{{- end }}
}
\myLineThick\medskip
{{ template "_common_02_quarterly.tpl" dict "Cfg" .Cfg "Body" .Body }}

\pagebreak
