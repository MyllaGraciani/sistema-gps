import 'package:octagon_automation/domain/entities/usuario.model.dart';
import 'package:sqflite/sqflite.dart';

import '../conexao.dart';

class UsuarioDAO {
  late Database _db;

  Future<List<UsuarioModel>> buscarTodos() async {
    _db = (await Connection.instance.get())!;

    List<Map<String, dynamic>> resultado = await _db.query('usuarios');

    List<UsuarioModel> lista = List.generate(resultado.length, (i) {
      var linha = resultado[i];

      return UsuarioModel(
        linha['id'],
        linha['nome'],
        linha['cpf'],
        linha['telefone'],
        linha['email'],
        linha['senha'],
      );
    });
    return lista;
  }

  buscarUsuarioPorId(int id) async {
    _db = (await Connection.instance.get())!;

    List<Map<String, dynamic>> resultado =
        await _db.query('usuarios', where: 'id = ?', whereArgs: [id]);

    return UsuarioModel(
      resultado[0]['id'],
      resultado[0]['nome'],
      resultado[0]['cpf'],
      resultado[0]['telefone'],
      resultado[0]['email'],
      resultado[0]['senha'],
    );
  }

  inserir(
    String nome,
    String cpf,
    String telefone,
    String email,
    String senha,
  ) async {
    _db = (await Connection.instance.get())!;

    Map<String, dynamic> row = {
      "nome": nome,
      "cpf": cpf,
      "telefone": telefone,
      "email": email,
      "senha": senha
    };

    await _db.insert('usuarios', row);
  }

  atualizar(Map<String, dynamic> row) async {
    _db = (await Connection.instance.get())!;

    await _db.update('usuarios', row, where: 'id = ?', whereArgs: [row['id']]);
  }

  remover(int id) async {
    _db = (await Connection.instance.get())!;

    await _db.delete('usuarios', where: 'id = ?', whereArgs: [id]);
  }
}
