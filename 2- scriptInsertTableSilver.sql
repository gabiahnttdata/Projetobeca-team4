--dim_UF
INSERT INTO silver.dim_UF (Estado, UF, Regiao, Populacao)
SELECT Estado
,CASE 
    WHEN Estado = 'Rondônia' THEN 'RO'
    WHEN Estado = 'Acre' THEN 'AC'
    WHEN Estado = 'Amazonas' THEN 'AM'
    WHEN Estado = 'Roraima' THEN 'RR'
    WHEN Estado = 'Pará' THEN 'PA'
    WHEN Estado = 'Amapá' THEN 'AP'
    WHEN Estado = 'Tocantins' THEN 'TO'
    WHEN Estado = 'Maranhão' THEN 'MA'
    WHEN Estado = 'Piauí' THEN 'PI'
    WHEN Estado = 'Ceará' THEN 'CE'
    WHEN Estado = 'Rio Grande do Norte' THEN 'RN'
    WHEN Estado = 'Paraíba' THEN 'PB'
    WHEN Estado = 'Pernambuco' THEN 'PE'
    WHEN Estado = 'Alagoas' THEN 'AL'
    WHEN Estado = 'Sergipe' THEN 'SE'
    WHEN Estado = 'Bahia' THEN 'BA'
    WHEN Estado = 'Minas Gerais' THEN 'MG'
    WHEN Estado = 'Espírito Santo' THEN 'ES'
    WHEN Estado = 'Rio de Janeiro' THEN 'RJ'
    WHEN Estado = 'São Paulo' THEN 'SP'
    WHEN Estado = 'Paraná' THEN 'PR'
    WHEN Estado = 'Santa Catarina' THEN 'SC'
    WHEN Estado = 'Rio Grande do Sul' THEN 'RS'
    WHEN Estado = 'Mato Grosso do Sul' THEN 'MS'
    WHEN Estado = 'Mato Grosso' THEN 'MT'
    WHEN Estado = 'Goiás' THEN 'GO'
    WHEN Estado = 'Distrito Federal' THEN 'DF'
    WHEN Estado = 'Exterior' THEN 'ZZ'
    WHEN Estado = 'S/ Estado' THEN 'S/E'
    ELSE 'S/ Estado'
END AS UF
,Regiao
,População
FROM bronze.censo_2022_população_calculada

INSERT INTO silver.dim_UF (Estado, UF, Regiao, Populacao)
VALUES ('Exterior', 'ZZ', 'Exterior', 0),
('S/ Estado', 'S/E', 'Desconhecida', 0);

--dim_Candidato 
INSERT INTO silver.dim_Candidato (
    Cargo, Coligacao, Cor_Raca, Situacao_Candidato, Estado_civil, Faixa_Etaria, Federacao, 
    Genero, Escolaridade, Municipio, Nacionalidade, Ocupação, Reeleicao, Sigla_Partido, Cadastramento, 
    Candidatura, Situacao_de_totalizacao, Turno, UF, id_UF, Data
)
SELECT 
    b.Cargo, b.Coligação, b.Cor/raça, b.[Detalhe da situação de candidatura], b.[Estado civil], 
    b.[Etnia indígena], b.[Faixa etária], b.Federação, b.Gênero, b.[Grau de instrução], b.[Identidade de gênero], 
    b.Município, b.Nacionalidade, b.[Nome social], b.Ocupação, b.[Orientação sexual], b.Quilombola, 
    b.Reeleição, b.Região, b.[Sigla partido], b.[Situação de cadastramento], b.[Situação de candidatura], 
    b.[Situação de cassação], b.[Situação de desconstituição], b.[Situação de julgamento], b.[Situação de totalização], 
    b.[Tipo eleição], b.Turno, b.UF, ref.id_UF, b.[Data de carga]
FROM bronze.Candidatos b
JOIN silver.dim_UF ref ON b.UF = ref.UF;

--dim_Comparecimento_Abstencao
INSERT INTO silver.dim_Comparecimento_Abstencao (
    Estado_civil, Faixa_Etaria, Genero, Escolaridade, Municipio, Pais, Regiao, Turno, UF, id_UF, Zona, 
    QtdEleitorDeficienteAbstencao, QtdEleitorComparecimentoTTE, QtdEleitorAbstencaoTTE, QtdEleitores_Aptos, 
    QtdEleitorAbstencao, QtdEleitorComparecimento, Data
)
SELECT 
    b.[Estado civil], b.[Faixa etária], b.Gênero, b.[Grau de instrução], b.Município, b.País, b.Região, b.Turno, 
    b.UF, ref.id_UF, b.Zona, b.[Quantidade de eleitores deficientes abstenção], b.[Quantidade de eleitores comparecimento TTE], 
    b.[Quantidade de eleitores abstenção TTE], b.[Quantidade de eleitores aptos], b.[Quantidade de eleitores abstenção], 
    b.[Quantidade de eleitores comparecimento], b.[Data de carga]
FROM bronze.ComparecimentoAbstencao b
JOIN silver.dim_UF ref ON b.UF = ref.UF;

--dim_Detalhe_Votacao 
INSERT INTO silver.dim_Detalhe_Votacao (
    Regiao, Zona, Cargo, Codigo_Municipio, Municipio, Turno, UF, id_UF, QtdVotosBrancos, Qtd_Votos_Validos_Legendas, 
    Qtd_Comparecimento, Qtd_Votos_Anulados, Qtd_Votos_Validos_Nominais, Qtd_Secoes_Agregadas, Qtd_Votos_Validos, 
    Qtd_Aptos_Totalizados, Qtd_Total_Secoes, Votos_Nulos, Votos_Totais, Qtd_Aptos, Qtd_Secoes_Principais, Abstencoes, 
    Votos_Legendas_Validos, Qtd_Votos_Nulos_Tecnico, Votos_Anulados_Subjudice, Votos_Concorrentes, Votos_Nominais_Anulados, 
    Secoes_Instaladas, Data
)
SELECT 
    b.Região, b.Zona, b.Cargo, b.[Código município], b.Município, b.Turno, b.UF, ref.id_UF, b.[Quantidade de votos brancos], 
    b.[Quantidade de votos de legenda válidos], b.[Quantidade de comparecimento], b.[Quantidade de votos anulados], 
    b.[Quantidade de votos nominais válidos], b.[Quantidade de seções agregadas], b.[Quantidade de votos válidos], 
    b.[Quantidade de aptos totalizados], b.[Quantidade total de seções], b.[Quantidade de votos nulos], b.[Quantidade de votos totais], 
    b.[Quantidade de aptos], b.[Quantidade de seções principais], b.[Quantidade de abstenções], 
    b.[Quantidade total de votos de legenda válidos], b.[Quantidade de votos anulados apurados em separado], 
    b.[Quantidade de votos nulos técnico], b.[Quantidade total de votos anulados subjudice], b.[Quantidade de votos concorrentes], 
    b.[Quantidade total de votos nulos], b.[Quantidade de votos de legenda anulados], b.[Quantidade de seções não instaladas], 
    b.[Quantidade de seções instaladas], b.[Data de carga]
FROM bronze.detalhe_votacao b
JOIN silver.dim_UF ref ON b.UF = ref.UF;

--dim_Fundo_Partidario 
INSERT INTO silver.dim_Fundo_Partidario (
    UF, id_UF, Cor_Raca, Esfera_Partidaria, Genero, Partido, Qtd_Candidatos, Valor_FP_Aplicado_Campanha, 
    Recursos_Declarados, Data
)
SELECT 
    b.UF, ref.id_UF, b.[Cor/raça], b.[Esfera partidária], b.Gênero, b.Partido, b.[Quantidade de candidatos], 
    b.[Valor FP aplicado na campanha], b.[Recursos declarados], b.[Data de carga]
FROM bronze.FundoPartidario b
JOIN silver.dim_UF ref ON b.UF = ref.UF;

--dim_Pesquisas_Eleitorais 
INSERT INTO silver.dim_Pesquisas_Eleitorais (
    UF, id_UF, Municipio, Protocolo_Registro, Regiao, Codigo_Registro_CONRE, Dados_Municipes, Fim_Pesquisa,
    Inicio_Pesquisa, Registro, Estatistico_Resp, Metodologia_Pesq, Empresa_Nome_Fantasia, Plano_Amostral,
    Sistema_Controle, Qtd_Pesq, Qtd_Entrevistados, Valor, Data
)
SELECT 
    b.UF, ref.id_UF, b.Município, b.[Protocolo de registro], b.Região, b.[Código do registro no CONRE],
    b.[Dados municípios], b.[Data de fim da pesquisa], b.[Data de início da pesquisa], b.[Data de registro],
    b.[Estatístico responsável], b.[Metodologia da pesquisa], b.[Nome fantasia da empresa], b.[Plano amostral],
    b.[Sistema de controle], b.[Quantidade de pesquisa], b.[Quantidade de entrevistados], b.[Valor da pesquisa],
    b.[Data de carga]
FROM bronze.PesquisasEleitorais b
JOIN silver.dim_UF ref ON b.UF = ref.UF;

--dim_Quociente_Eleitoral 
INSERT INTO silver.dim_Quociente_Eleitoral (
    Cargo, Municipio, Turno, UF, Coligacao, Qtd_Vagas_QE, Qtd_Votos_Legenda_QE, Qtd_Votos_Nominais_QE, 
    Qtd_Votos_Validos_QE, Valor_Quociente_Eleitoral, Qtd_Votos_Legenda_QP, Qtd_Votos_Nominais_QP, 
    Qtd_Vagas_Preenchidas_QP, Qtd_Vagas_Media_QP, Qtd_Vagas_Obtidas_QP, Qtd_Votos_Coligacao_QP, Data, Id_UF
)
SELECT 
    b.Cargo, b.Município, b.Turno, b.UF, b.Coligação, b.[Quantidade de vagas QE], b.[Quantidade de votos de legenda QE], 
    b.[Quantidade de votos nominais QE], b.[Quantidade de votos válidos QE], b.[Valor do quociente eleitoral], 
    b.[Quantidade de votos de legenda QP], b.[Quantidade de votos nominais QP], b.[Quantidade de vagas média QP], 
    b.[Data de carga], ref.id_UF
FROM bronze.quociente-eleitoral b
JOIN silver.dim_UF ref ON b.UF = ref.UF;

--dim_Receita_Candidatos 
INSERT INTO silver.dim_Receita_Candidatos (
    UF, Esfera_Partidaria, Partido, Cargo, Esfera, Especie_Receita, Fonte_Receita, Municipio, Nome_Candidato, 
    Nome_Doador, Origem_Receita, Quilombola, Situacao_Candidatura, Situacao_Julgamento, Situacao_Totalizacao, 
    Valor_Receita, Data, Id_UF
)
SELECT 
    b.UF, b.[Esfera partidária], b.Partido, b.Cargo, b.Esfera, b.[Espécie receita], b.[Fonte de receita], b.Município, 
    b.[Nome candidato], b.[Nome doador], b.[Origem da receita], b.Quilombola, b.Região, b.[Situação de candidatura], 
    b.[Situação de julgamento], b.[Situação de totalização], b.[Valor de receita], b.[Data de carga], ref.id_UF
FROM bronze.ReceitasCandidatos b
JOIN silver.dim_UF ref ON b.UF = ref.UF;

--dim_Votacao_Candidato
INSERT INTO silver.dim_Votacao_Candidato (
    Cargo, Municipio, Turno, UF, Codigo_Municipio, Cor_Raca, Estado_Civil, Faixa_Etaria, Genero, Grau_Instrucao, 
    Nome_Candidato, Numero_Candidato, Ocupacao, Partido, Situacao_Totalizacao, Zona, Qtd_Votos_Validos, 
    Qtd_Votos_Nominais, Data, Id_UF
)
SELECT 
    b.Cargo, b.Município, b.Turno, b.UF, b.[Código município], b.[Cor/raça], b.[Estado civil], b.[Faixa etária], 
    b.Gênero, b.[Grau de instrução], b.[Nome candidato], b.[Número candidato], b.Ocupação, b.Partido, 
    b.[Situação totalização], b.Zona, b.[Votos válidos], b.[Votos nominais], b.[Data de carga], ref.id_UF
FROM bronze.votacao_candidato b
JOIN silver.dim_UF ref ON b.UF = ref.UF;
