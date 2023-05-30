#!/bin/bash

mapFolder() {

cd ../

cd helmCharts

# Mapeia os diretórios que NÃO tem deployment
mapfile -t dirs_without_deployment < <(find /home/mvthexz/Dev/ericsson/yaml-scripts/shipments-t1/helmCharts/*/charts/*/templates -type d ! -exec test -e '{}/deployment*.yaml' \; -print)

# Mapeia os diretórios que TEM deployment
mapfile -t files_array < <(find /home/mvthexz/Dev/ericsson/yaml-scripts/shipments-t1/helmCharts -type f -name 'deployment*.yaml' 2>/dev/null)

# Definir a nova entrada a ser adicionada
new_entry='      # Teste Matheus Tanaka
      tolerations:
      - key: "nodepool"
          operator: "Equal"
          value: "sfppdev"
          effect: "NoSchedule"
'

counter=0
# Adicionar a nova entrada acima da tag "volumes" em cada arquivo
echo "[MAPEAMENTO]: Diretórios com Deployment.yaml"
for file in "${files_array[@]}"; do
    if grep -q "volumes:" "$file"; then
        if ! grep -q "tolerations:" "$file"; then
            awk -v n="$new_entry" '/volumes:/{print n $0;next}1' "$file" > temp && mv temp "$file"
        fi
    fi
    let counter++

    echo "$counter -> $file"
done
echo "[MAPEAMENTO - TOTAL]: $counter diretórios com deployment"

echo " "
echo "========================================================="
echo " "

count=0
echo "[MAPEAMENTO]: Diretórios SEM Deployment.yaml"
# Consulta diretórios que não possuem deployment
for file in "${dirs_without_deployment[@]}"; do 
    let count++
    echo "$count -> $file"
done

echo "[MAPEAMENTO - TOTAL]: $count diretórios sem deployment"

}

export -f mapFolder