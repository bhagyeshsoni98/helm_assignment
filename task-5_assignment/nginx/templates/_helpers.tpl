{{- define "resource.name" }}
  name: {{ .Release.Name }}-helm-module
{{- end }}

{{- define "nginx.labels" }}
    app.kubernetes.io/name: nginx-app
    app.kubernetes.io/instance: nginx
{{- end }}