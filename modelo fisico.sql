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

