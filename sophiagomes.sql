CREATE DATABASE hospital;

\c hospital

CREATE TABLE medicos (
    id_medico SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    area_atuacao VARCHAR(150) NOT NULL
);

INSERT INTO medicos (nome, area_atuacao) VALUES 
('Dr. Marcelo Jordao', 'Cardiologista'),
('Dr. Sophia Gomes', 'Dermatologista'),
('Dr. Anna Fiochi', 'Pedriatra'),
('Dr. Mariana Cardoso', 'Ginecologista'),
('Dr. Maria Eduarda', 'Psicologa');

SELECT * FROM medicos;

CREATE TABLE pacientes (
    id_paciente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11),
    data_nascimento DATE,
    email VARCHAR(100) UNIQUE NOT NULL
);

SELECT * FROM pacientes;

INSERT INTO pacientes (nome, cpf, data_nascimento, email) VALUES
('Adriana Ribeiro', 87654390876, '29-09-1988', 'adrianaribeiro@gmail.com'),
('Thiago Ferreira', 97654309812, '20-10-1995', 'thiagoferreira@gmail.com'),
('Julia Neves', 24598765091, '17-09-2007', 'julianves@gmail.com'),
('Amanda Mechi', 76589076523, '23-04-2008', 'amandamechi@gmail.com'),
('Rayssa Flor', 35698765901, '10-03-2003', 'rayssaflor@gmail.com');

CREATE TABLE consultas (
    id_consulta SERIAL PRIMARY KEY,
    sintomas VARCHAR(200),
    id_paciente INT,
    id_medico INT, 
    data_consulta DATE,
    CONSTRAINT fk_medico FOREIGN KEY (id_medico) REFERENCES medicos(id_medico),
    CONSTRAINT fk_paciente FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente)
);

INSERT INTO consultas (sintomas, id_paciente, id_medico, data_consulta) VALUES
('Dor de cabeça', 1, 1, '2021-10-10'),
('Dor no corpo', 2, 5, '2021-09-10'),
('Febre', 4, 4, '2021-09-12'),
('Dor no estomago', 3, 3, '2021-09-13'),
('Dor no estomago', 5, 5, '2021-09-13');

SELECT * FROM consultas;
//* nome do paciente, nome do médico, área de atuação do médico e data da consulta *//

SELECT pacientes.nome, medicos.nome, medicos.area_atuacao, consultas.data_consulta
FROM consultas
JOIN pacientes ON consultas.id_paciente = pacientes.id_paciente
JOIN medicos  ON consultas.id_medico = medicos.id_medico;

SELECT pacientes.nome, consulta.data_consulta
FROM consultas
JOIN pacientes ON consultas.id_paciente = pacientes.id_paciente
JOIN medicos  ON consultas.id_medico = medicos.id_medico;

SELECT medicos.nome,consultas.data_consulta
FROM medicos
LEFT JOIN consultas ON consultas.id_medico = medicos.id_medico WHERE data_consulta IS NULL

