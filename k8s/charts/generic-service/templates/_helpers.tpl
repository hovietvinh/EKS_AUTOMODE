{{- define "generic-service.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "generic-service.labels" -}}
app.kubernetes.io/name: {{ .Values.nameOverride | default .Release.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "generic-service.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.nameOverride | default .Release.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}