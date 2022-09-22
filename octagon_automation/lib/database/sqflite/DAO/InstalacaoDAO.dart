import 'package:octagon_automation/domain/entities/instalacao.model.dart';
import 'package:sqflite/sqflite.dart';

import '../conexao.dart';

class InstalacaoDAO {
  late Database _db;

  Future<List<InstalacaoModel>> buscarTodos() async {
    _db = (await Connection.instance.get())!;

    List<Map<String, dynamic>> resultado = await _db.query('instalacoes');

    List<InstalacaoModel> lista = List.generate(resultado.length, (i) {
      var linha = resultado[i];

      return InstalacaoModel(
        linha['id'],
        linha['tipo'],
        linha['endereco'],
        linha['idAdmin'],
      );
    });
    return lista;
  }

  inserir(
    String tipo,
    String endereco,
    int idAdmin,
  ) async {
    _db = (await Connection.instance.get())!;

    Map<String, dynamic> row = {
      "tipo": tipo,
      "endereco": endereco,
      "idAdmin": idAdmin,
    };

    await _db.insert('instalacoes', row);
  }

  atualizar(Map<String, dynamic> row) async {
    _db = (await Connection.instance.get())!;

    await _db.update('instalacoes', row);
  }

  remover(int id) async {
    _db = (await Connection.instance.get())!;

    await _db.delete('instalacoes', where: 'id = ?', whereArgs: [id]);
  }
}
