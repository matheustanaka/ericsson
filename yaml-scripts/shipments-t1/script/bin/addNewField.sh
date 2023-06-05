#!/bin/bash

addNewField() {

helmCharts_dir="$PWD/helmCharts"

# Mapeia os diretórios que TEM deployment e salva em um array
mapfile -t files_array < <(find "$helmCharts_dir" -type f -name 'deployment*.yaml' 2>/dev/null)

# Definir a nova entrada a ser adicionada
new_entry="      # Automated Field by Matheus Tanaka - $(date)
      tolerations:
      - key: \"nodepool\"
        operator: \"Equal\"
        value: \"sfppdev\"
        effect: \"NoSchedule\"
"


counter=0
# Adicionar a nova entrada acima da tag "volumes" em cada arquivo
echo "[MAPEAMENTO]: Diretórios COM deployment.yaml"
for file in "${files_array[@]}"; do
	# Procura pela tag volumes no em cada arquivo
    if grep -q "volumes:" "$file"; then
		# Verifica se a tag "tolerations" não existe e adiciona o novo campo no arquivo.
        if ! grep -q "tolerations:" "$file"; 
		then
			echo "[PATH]: $file"
			echo "[CAMPO ADICIONADO]: $new_entry"

            awk -v n="$new_entry" '/volumes:/{print n $0;next}1' "$file" > temp && mv temp "$file"
		# Se já existir a tag, ele retorna o caminho do arquivo
		else
			echo "[PATH]: $file"
			echo "[CONTÉM]: $new_entry"
        fi
    fi
    let counter++
done

echo "[MAPEAMENTO - TOTAL]: $counter diretórios COM deployment"
}

export -f addNewField
