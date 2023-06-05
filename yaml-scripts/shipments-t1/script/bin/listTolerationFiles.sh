listTolerationFiles() {
mapfile -t files_array < <(find /home/mvthexz/Dev/ericsson/yaml-scripts/shipments-t1/helmCharts -type f -name 'deployment*.yaml' 2>/dev/null)

counter=0

for file in "${files_array[@]}"; do
    echo $file
    let counter++
done

echo " "

echo "[MAPEAMENTO - TOTAL]: $counter diretórios COM deployment"
}

export -f listTolerationFiles