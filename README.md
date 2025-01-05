<div align="center">
<img alt="logounifecaf" title="logo" src="https://github.com/user-attachments/assets/90ed2ae5-f4eb-4d6f-8824-3128a91c6141 " width="200vw"/>

Database Modeling & SQL

[Vídeo Explicando a Atividade](https://youtu.be/cgNcPJadb4M)

</div>

# Estudo de Caso: Sistema Faculdade
## Descrição do Problema:

Um sistema acadêmico para uma faculdade que precisa gerenciar informações sobre alunos, cursos, matérias e professores. 
O sistema permitirá registrar dados detalhados das matrículas realizadas, armazenando informações dos alunos matriculados, professores e suas respectivas disciplinas, além de controlar as turmas e notas dos alunos.

## Objetivos de Aprendizagem: 
Com este estudo de caso, os alunos deverão ser capazes de:

1. **Analisar Requisitos:** Trabalhar em conjunto para levantar os requisitos necessários para o sistema.
2. **Modelar Banco de Dados:** Criar um modelo *conceitual, lógico e físico* para armazenar todas as informações necessárias para o sistema.

## 1 - Levantamento de Requisitos:
1. Principais necessidades dos clientes:
- Armazenar informações de alunos, professores, cursos e matérias
- Realizar controles básicos, como montar turmas e armazenar notas dos alunos
2. Informações a serem armazenadas:
- Dados pessoais de alunos e professores
- Informações sobre cursos, matérias e turmas
- Notas e desempenho dos alunos em cada matéria
3. Utilização dos dados:
- Consultar informações acadêmicas
- Gerenciar a matrícula de alunos em turmas
- Registrar e consultar notas

## 2 - Modelo Conceitual
![Estudo de caso Faculdade - Conceitual](https://github.com/user-attachments/assets/5adb07b2-5a68-4686-8a6c-9239a87582e7)

## 3 - Modelo Lógico
![Estudo de caso Faculdade -Logico](https://github.com/user-attachments/assets/30821b83-f956-4eed-a48d-8fc1281f38e1)

## 4 - Modelo Físico
- Criação do banco e tabelas:
~~~SQL
-- Criar e usar o banco de dados
CREATE DATABASE sistema_academico;
USE sistema_academico;

-- Criar tabela de Cargo
CREATE TABLE Cargo (
    idCargo INT AUTO_INCREMENT PRIMARY KEY,
    nome_cargo VARCHAR(50)
);

-- Criar tabela de Professor
CREATE TABLE Professor (
    idProfessor INT AUTO_INCREMENT PRIMARY KEY,
    idCargo INT,
    cod_professor VARCHAR(20),
    nome_completo VARCHAR(100),
    CPF VARCHAR(11),
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco VARCHAR(200),
    FOREIGN KEY (idCargo) REFERENCES Cargo(idCargo)
);

-- Criar tabela de Curso
CREATE TABLE Curso (
    idCurso INT AUTO_INCREMENT PRIMARY KEY,
    cod_curso VARCHAR(20),
    nome_curso VARCHAR(100),
    semestre_duracao INT
);

-- Criar tabela de Disciplina
CREATE TABLE Disciplina (
    idDisciplina INT AUTO_INCREMENT PRIMARY KEY,
    idCurso INT,
    cod_disciplina VARCHAR(20),
    nome_disciplina VARCHAR(100),
    carga_horaria INT,
    FOREIGN KEY (idCurso) REFERENCES Curso(idCurso)
);

-- Criar tabela de Turma
CREATE TABLE Turma (
    idTurma INT AUTO_INCREMENT PRIMARY KEY,
    idDisciplina INT,
    cod_turma VARCHAR(20),
    semestre INT,
    ano INT,
    horario VARCHAR(50),
    vagas INT,
    FOREIGN KEY (idDisciplina) REFERENCES Disciplina(idDisciplina)
);

-- Criar tabela de Aluno
CREATE TABLE Aluno (
    idAluno INT AUTO_INCREMENT PRIMARY KEY,
    RA VARCHAR(20),
    nome_completo VARCHAR(100),
    CPF VARCHAR(11),
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco VARCHAR(200),
    data_nascimento DATE
);

-- Criar tabela de Matricula
CREATE TABLE Matricula (
    idMatricula INT AUTO_INCREMENT PRIMARY KEY,
    idAluno INT,
    idTurma INT,
    data_matricula DATE,
    status VARCHAR(20),
    FOREIGN KEY (idAluno) REFERENCES Aluno(idAluno),
    FOREIGN KEY (idTurma) REFERENCES Turma(idTurma)
);

-- Criar tabela de Notas
CREATE TABLE Notas (
    idNota INT AUTO_INCREMENT PRIMARY KEY,
    idMatricula INT,
    nota DECIMAL(4,2),
    frequencia DECIMAL(5,2),
    situacao VARCHAR(20),
    FOREIGN KEY (idMatricula) REFERENCES Matricula(idMatricula)
);

-- Criar tabela de Pré-Requisitos
CREATE TABLE Pre_Requisitos (
    idPreRequisitos INT AUTO_INCREMENT PRIMARY KEY,
    disciplina_id INT,
    prerequisito_id INT,
    FOREIGN KEY (disciplina_id) REFERENCES Disciplina(idDisciplina),
    FOREIGN KEY (prerequisito_id) REFERENCES Disciplina(idDisciplina)
);

-- Criar tabela de Professor_Turma
CREATE TABLE Professor_Turma (
    idProfessorTurma INT AUTO_INCREMENT PRIMARY KEY,
    idProfessor INT,
    idTurma INT,
    FOREIGN KEY (idProfessor) REFERENCES Professor(idProfessor),
    FOREIGN KEY (idTurma) REFERENCES Turma(idTurma)
);

-- Criar tabela de Professor_Disciplina
CREATE TABLE Professor_Disciplina (
    idProfessorDisciplina INT AUTO_INCREMENT PRIMARY KEY,
    idProfessor INT,
    idDisciplina INT,
    FOREIGN KEY (idProfessor) REFERENCES Professor(idProfessor),
    FOREIGN KEY (idDisciplina) REFERENCES Disciplina(idDisciplina)
);

-- Ver todas as tabelas
SHOW TABLES;

-- Ver estrutura de uma tabela específica
DESCRIBE Professor;
~~~

- Inserção de Dados:
~~~SQL
-- Inserir cargos
INSERT INTO Cargo (nome_cargo) VALUES 
('Docente'),
('Coordenador'),
('Tutor');

-- Inserir professores
INSERT INTO Professor (idCargo, cod_professor, nome_completo, CPF, telefone, email, endereco) VALUES 
(1, 'PROF001', 'João Silva', '12345678901', '11999999991', 'joao@email.com', 'Rua A, 123'),
(2, 'PROF002', 'Maria Santos', '23456789012', '11999999992', 'maria@email.com', 'Rua B, 456'),
(1, 'PROF003', 'Pedro Souza', '34567890123', '11999999993', 'pedro@email.com', 'Rua C, 789');

-- Inserir cursos
INSERT INTO Curso (cod_curso, nome_curso, semestre_duracao) VALUES
('SI', 'Sistemas de Informação', 8),
('CC', 'Ciência da Computação', 8),
('ADS', 'Análise e Desenvolvimento de Sistemas', 6);

-- Inserir disciplinas
INSERT INTO Disciplina (idCurso, cod_disciplina, nome_disciplina, carga_horaria) VALUES
(1, 'BD001', 'Banco de Dados', 80),
(1, 'PROG001', 'Programação I', 60),
(2, 'ALG001', 'Algoritmos', 60);

-- Inserir turmas
INSERT INTO Turma (idDisciplina, cod_turma, semestre, ano, horario, vagas) VALUES
(1, 'BD2024A', 1, 2024, 'Segunda 19h-22h', 40),
(2, 'PROG2024A', 1, 2024, 'Terça 19h-22h', 35),
(3, 'ALG2024A', 1, 2024, 'Quarta 19h-22h', 45);

-- Inserir alunos
INSERT INTO Aluno (RA, nome_completo, CPF, telefone, email, endereco, data_nascimento) VALUES
('RA001', 'Ana Oliveira', '45678901234', '11988888881', 'ana@email.com', 'Rua X, 100', '2000-03-15'),
('RA002', 'Carlos Lima', '56789012345', '11988888882', 'carlos@email.com', 'Rua Y, 200', '2001-06-20'),
('RA003', 'Julia Costa', '67890123456', '11988888883', 'julia@email.com', 'Rua Z, 300', '2002-09-10');

-- Inserir matrículas
INSERT INTO Matricula (idAluno, idTurma, data_matricula, status) VALUES
(1, 1, '2024-01-15', 'Ativa'),
(2, 2, '2024-01-15', 'Ativa'),
(3, 3, '2024-01-15', 'Ativa');

-- Inserir notas
INSERT INTO Notas (idMatricula, nota, frequencia, situacao) VALUES
(1, 8.5, 90.0, 'Aprovado'),
(2, 7.0, 85.0, 'Aprovado'),
(3, 9.0, 95.0, 'Aprovado');

-- Inserir pré-requisitos
INSERT INTO Pre_Requisitos (disciplina_id, prerequisito_id) VALUES
(2, 1),
(3, 2);

-- Inserir professor_turma
INSERT INTO Professor_Turma (idProfessor, idTurma) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Inserir professor_disciplina
INSERT INTO Professor_Disciplina (idProfessor, idDisciplina) VALUES
(1, 1),
(2, 2),
(3, 3);
~~~

- Consulta Simples:
~~~SQL
-- Ver todos os professores
SELECT * FROM Professor;
-- Ver todas as disciplinas
SELECT * FROM Disciplina;
-- Ver todos os alunos
SELECT * FROM Aluno;
~~~

- Consultas Relacionadas:
~~~SQL
-- Ver alunos e suas notas
SELECT a.nome_completo, d.nome_disciplina, n.nota, n.frequencia
FROM Aluno a
JOIN Matricula m ON a.idAluno = m.idAluno
JOIN Notas n ON m.idMatricula = n.idMatricula
JOIN Turma t ON m.idTurma = t.idTurma
JOIN Disciplina d ON t.idDisciplina = d.idDisciplina;

-- Ver professores e suas disciplinas
SELECT p.nome_completo, d.nome_disciplina
FROM Professor p
JOIN Professor_Disciplina pd ON p.idProfessor = pd.idProfessor
JOIN Disciplina d ON pd.idDisciplina = d.idDisciplina;
~~~

- Atualizações:
~~~SQL
-- Atualizar telefone de um professor
UPDATE Professor 
SET telefone = '11999997777' 
WHERE idProfessor = 1;

-- Atualizar status de uma matrícula
UPDATE Matricula 
SET status = 'Trancada' 
WHERE idAluno = 1;

-- Atualizar nota de um aluno
UPDATE Notas 
SET nota = 9.5 
WHERE idMatricula = 1;
~~~

- Exclusões:
~~~SQL
-- Deletar nota: 
DELETE FROM Notas WHERE idNota = 1;

-- Podemos deletar um vínculo de professor com turma 
DELETE FROM Professor_Turma 
WHERE idProfessorTurma = 1; 

-- Ou um vínculo de professor com disciplina 
DELETE FROM Professor_Disciplina 
WHERE idProfessorDisciplina = 1;

-- Quando tem relacionamento entre tabelas, exemplo:
-- 1º Deletar as notas deste aluno 
DELETE FROM Notas 
WHERE idMatricula IN (SELECT idMatricula FROM Matricula WHERE idAluno = 3); 

-- 2º Deletar as matrículas do aluno 
DELETE FROM Matricula
 WHERE idAluno = 3; 
-- 3º Finalmente, deletar o aluno 
DELETE FROM Aluno 
WHERE idAluno = 3;
~~~

## Conclusão e Autoavaliação: 
Avaliando o projeto desenvolvido, posso dizer que o banco de dados atende completamente às necessidades da faculdade porque:
- Permite armazenar todos os dados necessários
- Mantém os relacionamentos corretos entre as informações
- Possibilita fazer todas as operações requisitadas
- É flexível para futuras expansões e melhorias
- Pode ser facilmente integrado com uma interface de usuário no futuro
O banco de dados foi construído seguindo as boas práticas de modelagem e está pronto para ser utilizado em um sistema completo de gestão acadêmica.






