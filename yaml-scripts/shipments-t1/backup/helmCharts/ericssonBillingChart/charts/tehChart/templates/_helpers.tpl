{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "eric-bss-eb-teh.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "eric-bss-eb-teh.fullname" -}}
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
{{- define "eric-bss-eb-teh.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create Ericsson product app.kubernetes.io info
*/}}
{{- define "eric-bss-eb-teh.kubernetesIoInfo" -}}
app.kubernetes.io/name: {{ .Chart.Name | quote }}
app.kubernetes.io/version: {{ .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end -}}

{{/*
Create Ericsson product specific annotations
*/}}
{{- define "eric-bss-eb-teh.productInfo" }}
ericsson.com/product-name: "Ericsson Billing"
ericsson.com/product-number: "FAM 901 588"
ericsson.com/product-revision: "R26A"
{{- end -}}

{{/*
Create image repo path
*/}}
{{- define "eric-bss-eb-teh.repoPath" -}}
    {{- $repoPath := "" -}}

    {{- if index .Values "global" "imageCredentials" -}}
        {{- if index .Values "global" "imageCredentials" "repoPath" -}}
            {{- $repoPath = index .Values "global" "imageCredentials" "repoPath" -}}
        {{- end -}}
    {{- end -}}

    {{- if index .Values "imageCredentials" -}}
        {{- if index .Values "imageCredentials" .containerKey -}}
            {{- if index .Values "imageCredentials" .containerKey "repoPath" -}}
                {{- $repoPath = index .Values "imageCredentials" .containerKey "repoPath" -}}
            {{- end -}}
        {{- end -}}
    {{- end -}}

    {{- if $repoPath -}}
        {{- print $repoPath "/" -}}
    {{- end -}}
{{- end -}}

{{/*
Create image pull policy
*/}}
{{- define "eric-bss-eb-teh.pullPolicy" -}}
    {{- $pullPolicy := "IfNotPresent" -}}

    {{- if index .Values "global" "imageCredentials" -}}
        {{- if index .Values "global" "imageCredentials" "pullPolicy" -}}
            {{- $pullPolicy = index .Values "global" "imageCredentials" "pullPolicy" -}}
        {{- end -}}
    {{- end -}}

    {{- if index .Values "imageCredentials" -}}
        {{- if index .Values "imageCredentials" .containerKey -}}
            {{- if index .Values "imageCredentials" .containerKey "pullPolicy" -}}
                {{- $pullPolicy = index .Values "imageCredentials" .containerKey "pullPolicy" -}}
            {{- end -}}
        {{- end -}}
    {{- end -}}

    {{- print $pullPolicy -}}
{{- end -}}

{{/*
Create image registry url
*/}}
{{- define "eric-bss-eb-teh.registryUrl" -}}
    {{- $registryUrl := "" -}}

    {{- if index .Values "global" "imageCredentials" -}}
        {{- if index .Values "global" "imageCredentials" "registry" -}}
            {{- if index .Values "global" "imageCredentials" "registry" "url" -}}
                {{- $registryUrl = index .Values "global" "imageCredentials" "registry" "url" -}}
            {{- end -}}
        {{- end -}}
    {{- end -}}

    {{- if index .Values "imageCredentials" -}}
        {{- if index .Values "imageCredentials" .containerKey -}}
            {{- if index .Values "imageCredentials" .containerKey "registry" -}}
                {{- if index .Values "imageCredentials" .containerKey "registry" "url" -}}
                    {{- $registryUrl = index .Values "imageCredentials" .containerKey "registry" "url" -}}
                {{- end -}}
            {{- end -}}
        {{- end -}}
    {{- end -}}

    {{- print $registryUrl -}}
{{- end -}}

{{/*
Check mandatory user login data to run this pod
*/}}
{{- define "eric-bss-eb-teh.checkPodUserLoginData" -}}
runAsUser: {{ required "A valid .Values.global.runAsUser entry is required!" .Values.global.runAsUser }}
runAsGroup: {{ required "A valid .Values.global.runAsGroup entry is required!" .Values.global.runAsGroup }}
fsGroup: {{ required "A valid .Values.global.fsGroup entry is required!" .Values.global.fsGroup }}
{{- end -}}
