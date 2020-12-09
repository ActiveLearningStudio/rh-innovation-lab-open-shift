{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "curriki-tsugi.name" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "curriki-tsugi.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}



{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "curriki-tsugi.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "curriki-tsugi.labels" -}}
helm.sh/chart: {{ include "curriki-tsugi.chart" . }}
{{ include "curriki-tsugi.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "curriki-tsugi.selectorLabels" -}}
app.kubernetes.io/name: {{ include "curriki-tsugi.name" . }}
app.kubernetes.io/component: {{ include "curriki-tsugi.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
deploymentconfig: {{ include "curriki-tsugi.fullname" . }}
{{- end -}}
