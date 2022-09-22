const String createTableUsuarios = '''
  CREATE TABLE IF NOT EXISTS usuarios(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(200) NOT NULL,
    cpf VARCHAR(200) NOT NULL,
    telefone VARCHAR(200) NOT NULL,
    email TEXT NOT NULL,
    senha TEXT NOT NULL
  )
''';

const String createTableInstalacoes = '''
  CREATE TABLE IF NOT EXISTS instalacoes(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tipo VARCHAR(150) NOT NULL,
    endereco TEXT NOT NULL,
    idAdmin INT,
    FOREIGN KEY(idAdmin) REFERENCES usuarios(id)
  )
''';
