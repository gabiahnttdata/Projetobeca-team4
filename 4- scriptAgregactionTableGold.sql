--dim_UF
INSERT INTO gold.dim_UF (Estado, UF, Regiao, Populacao)
SELECT id
,Estado
,UF
,Regiao
,Populacao
FROM silver.dim_UF

--dim_Candidato 
INSERT INTO gold.dim_Candidato (
    Cargo, Genero, Municipio, Sigla_Partido, Situacao_de_totalizacao, Turno, UF, id_UF, Data
)
SELECT Cargo
,Genero
,Municipio
,Sigla_Partido
,Turno
,UF
,id_UF
FROM silver.dim_Candidato

--dim_Comparecimento_Abstencao

--dim_Detalhe_Votacao 

--dim_Fundo_Partidario 
INSERT INTO gold.dim_Fundo_Partidario (
    UF, id_UF, Cor_Raca, Esfera_Partidaria, Genero, Partido, Qtd_Candidatos, Valor_FP_Aplicado_Campanha, Recursos_Declarados, Data
)
SELECT UF
,id_UF
,Partido
,Recursos_Declarados
,SUM(Valor_FP_Aplicado_na_Campanha) as Valor_FP_Aplicado_na_Campanha
FROM silver.dim_Fundo_Partidario
GROUP BY UF
,id_UF
,Partido
,Recursos_Declarados

--dim_Pesquisas_Eleitorais 
INSERT INTO gold.dim_Pesquisas_Eleitorais (
    UF, id_UF, Municipio, Protocolo_Registro, Regiao, Codigo_Registro_CONRE, Dados_Municipes, Fim_Pesquisa, Inicio_Pesquisa, Registro, 
    Estatistico_Resp, Metodologia_Pesq, Empresa_Nome_Fantasia, Plano_Amostral, Sistema_Controle, Qtd_Pesq, Qtd_Entrevistados, Valor, Data
)
SELECT 
,UF
,id_UF
,Municipio
,Regiao
,Fim_Pesquisa
,Inicio_Pesquisa
FROM silver.dim_Pesquisas_Eleitorais

--dim_Quociente_Eleitoral 

--dim_Receita_Candidatos 

--dim_Votacao_Candidato
INSERT INTO gold.dim_Votacao_Candidato (
    Cargo, Municipio, Turno, UF, Nome_Candidato, Partido, Situacao_Totalizacao, Total_Votos, Id_UF
)
SELECT id_votacao_candidato
,Cargo
,Municipio
,Turno
,UF
,Nome_Candidato
,Partido
,Situacao_Totalizacao
,SUM(Qtd_Votos_Validos) as Total_Votos
,Id_UF
FROM silver.dim_Votacao_Candidato
GROUP BY id_votacao_candidato
,Cargo
,Municipio
,Turno
,UF
,Nome_Candidato
,Partido
,Situacao_Totalizacao
,Id_UF;