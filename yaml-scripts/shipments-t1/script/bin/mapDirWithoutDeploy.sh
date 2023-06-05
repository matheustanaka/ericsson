dirWithoutDeploy() {
echo "[MAPEAMENTO]: Diretórios SEM Deployment.yaml na Pasta 'TEMPLATES'"

# Mapeia os diretórios que NÃO tem deployment e salva em um array
mapfile -t dirs_without_deployment < <(find /home/mvthexz/Dev/ericsson/yaml-scripts/shipments-t1/helmCharts/*/charts/*/templates -type d -exec bash -c 'shopt -s nullglob; files=("$1"/deploy*.yaml); [[ ${#files[@]} -eq 0 ]]' _ {} \; -print)

# Mapeia os diretórios dentro da pasta templates, alguns diretórios não possuem a pasta charts.
mapfile -t template_dirs_without_deployment < <(find /home/mvthexz/Dev/ericsson/yaml-scripts/shipments-t1/helmCharts/*/templates -type d -exec bash -c 'shopt -s nullglob; files=("$1"/deploy*.yaml); [[ ${#files[@]} -eq 0 ]]' _ {} \; -print)

# Consulta diretórios que não possuem deployment na pasta template
temp_count=0
for file in "${template_dirs_without_deployment[@]}"; do 
    let temp_count++
    echo "[PATH - $temp_count]: $file - Não encontrou o arquivo [Deployment.yaml]"
done

echo "[MAPEAMENTO]: Diretórios SEM Deployment.yaml na Pasta 'CHARTS'"

count=0
# Consulta diretórios que não possuem deployment
for file in "${dirs_without_deployment[@]}"; do 
    let count++
    echo "[PATH - $count]: $file - Não encontrou o arquivo [Deployment.yaml]"
done

sum=$(( $count + $temp_count ))

echo " "

echo "[MAPEAMENTO - TOTAL]: $sum diretórios SEM deployment"
}

export -f dirWithoutDeploy