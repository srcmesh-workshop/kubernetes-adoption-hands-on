{{- define "nginx-resources" -}}
limits:
  cpu: {{ .Values.nginx.resource.limits.cpu }}
  memory: 128Mi
requests:
  cpu: 100m
  memory: {{ .Values.nginx.resource.requests.memory }}
{{- end }}
