{{- define "blue-green-demo.name" -}}
blue-green-demo
{{- end }}

{{- define "blue-green-demo.fullname" -}}
{{ .Release.Name }}-{{ include "blue-green-demo.name" . }}
{{- end }}

{{- define "blue-green-demo.labels" -}}
app.kubernetes.io/name: {{ include "blue-green-demo.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
