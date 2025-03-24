--dim_UF
CREATE TABLE gold.dim_UF (
    id INT IDENTITY(1, 1) PRIMARY KEY,
    Estado VARCHAR(25),
    UF VARCHAR(20),
    Regiao VARCHAR(25),
    Populacao INT
);

--dim_Candidato 
CREATE TABLE gold.dim_Candidato (
    id_candidato INT IDENTITY(1, 1) PRIMARY KEY,
    Cargo VARCHAR(100),
    Genero VARCHAR(10),
    Municipio VARCHAR(50),
    Sigla_Partido VARCHAR(10),
    Situacao_de_totalizacao VARCHAR(25),
    Turno INT,
    UF VARCHAR(20),
    id_UF INT,
    FOREIGN KEY (id_UF) REFERENCES dim_UF(id)
);

--dim_Comparecimento_Abstencao

--dim_Detalhe_Votacao 

--dim_Fundo_Partidario 
CREATE TABLE gold.dim_Fundo_Partidario (
    UF VARCHAR(20),
    id_UF INT,
    Partido VARCHAR(25),
    Valor_FP_Aplicado_Campanha DECIMAL(10,2),
    Recursos_Declarados DECIMAL(10,2),
    FOREIGN KEY (id_UF) REFERENCES dim_UF(id)
);

--dim_Pesquisas_Eleitorais 
CREATE TABLE gold.dim_Pesquisas_Eleitorais (
    UF VARCHAR(20),
    id_UF INT,
    Municipio VARCHAR(50),
    Regiao VARCHAR(25),
    Fim_Pesquisa DATETIME,
    Inicio_Pesquisa DATETIME,
    Valor DECIMAL(10,2),
    FOREIGN KEY (id_UF) REFERENCES dim_UF(id)
);
--dim_Quociente_Eleitoral 

--dim_Receita_Candidatos 

--dim_Votacao_Candidato
CREATE TABLE gold.dim_Votacao_Candidato (
    id_votacao_candidato INT IDENTITY(1, 1) PRIMARY KEY,
    Cargo VARCHAR(50),
    Municipio VARCHAR(50),
    Turno INT,
    UF VARCHAR(20),
    Nome_Candidato VARCHAR(50),
    Partido VARCHAR(25),
    Situacao_Totalizacao VARCHAR(25),
    Total_Votos INT,
    id_UF INT,
    FOREIGN KEY (id_UF) REFERENCES dim_UF(id)
);
