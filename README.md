## HBSIS

![Arquitetura PaaS](./AzureHBSIS.png)

## Serviços Provisionados

Os arquivos Terraform provisionam:

- Web App com o Service Plan
- Banco de Dados do Azure para MySQL (MySQL e Database)
- Cache do Azure para Redis
- VNET (Network e Subnet)

## Explicação

Utilizei o Web App Services pois ele já poderia prover a plataforma para uso do PHP e escalonamento automático definido por Terraform, defini então o tamanho de máquina que utilizaria. Como o ambiente é de produção utilizei um Azure MySQL que é o recomendado e pode ser configurado também para uso em minha aplicação, não utilizando assim o recurso de MySQL do próprio App Services que é recomendado apenas para desenvolvimento e pequenos usos. Para resolver o problema de sessão utilizei um cache do Redis que posso configurar em meu PHP para guardar as sessões.
