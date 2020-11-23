{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "curriki-api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "curriki-api.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "curriki-api.labels" -}}
helm.sh/chart: {{ include "curriki-api.chart" . }}
{{ include "curriki-api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Name }}
{{- end -}}