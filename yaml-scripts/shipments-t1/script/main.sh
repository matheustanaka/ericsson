#!/bin/bash
source ./bin/addNewField.sh
source ./bin/mapDirWithoutDeploy.sh
source ./bin/listTolerationFiles.sh

main() {

cd ../

echo "Diretório de execucão: $PWD"
echo ""
echo "Selecione um número para executar uma funcão"

actions=("Adicionar nova TAG" "Mapear arquivos sem o arquivo de Deploy" "Listar arquivos com a TAG Toleration" "Sair")

local continueLoop=true

while $continueLoop; do  
    select item in "${actions[@]}"
    do
        case $REPLY in
            1) echo "Item #$REPLY selecionado - $item";
                addNewField
                break;;
            2) echo "Item #$REPLY selecionado - $item";
                dirWithoutDeploy 
                break;;
            3) echo "Item #$REPLY selecionado - $item"; 
                listTolerationFiles
                break;;
            4) echo "Item #$REPLY selecionado - $item";
                continueLoop=false
                break;; 
        esac
    done
done
}

main
