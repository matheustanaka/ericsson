# Requisitos

- Entrar em helmcharts
  - Cada diretório dentro de helm é "N" aplicações
  - Entrar nos diretórios das aplicações e dentro do deploy, alterar arquivo chamado "deployment-nome_da_app"
    - Verificar quais tem deployment e os que não tiverem tratar como excessão.
  - Excessões serão tratadas a parte.
  - Listar quais são excessões.

# Regra

- Encontrar dentro de "deployment-nome_da_app" a tag "volumes"
  - Verificar quais possuem mais de 1 volumes e tratar como excessão.
  - Os que tiverem somente 1 volume, adicionar as tags solicitadas.
  - Seguir a identação do YAML.
- Validar se não existe o tolerations no arquivo (caso alguém já tenha adiciona, para evitar duplicidade)

# Texto para adicionar

```yaml
tolerations:
  - key: "nodepool"
    operator: "Equal"
    value: "sfppdev"
    effect: "NoSchedule"
```

# Para fazer

- Criar um shell script para entrar na pasta helmCharts [x]
  - Entrar em cada pasta que estiver dentro []
    - Entrar na pasta charts []
      - Entrar em cada pasta e entrar em templates []
        - Procurar pelo arquivo deployment []
- Acessar a pasta charts
  - Mapear os todos os filhos que possuem o arquivo deployment
  - Mapear somente as pastas que tiverem o deployment
