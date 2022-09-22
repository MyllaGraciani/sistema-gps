import 'package:flutter/material.dart';
import 'package:octagon_automation/database/sqflite/DAO/instalacao_dao.dart';
import 'package:octagon_automation/database/sqflite/DAO/usuario_dao.dart';
import 'package:octagon_automation/domain/entities/instalacao.model.dart';

// ignore: must_be_immutable
class VerInstalacoesPage extends StatelessWidget {
  VerInstalacoesPage({Key? key}) : super(key: key);

  InstalacaoDAO instalacaoDAO = InstalacaoDAO();
  UsuarioDAO usuarioDAO = UsuarioDAO();
  final padding = const EdgeInsets.all(8.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instalações cadastrados'),
      ),
      body: FutureBuilder<List<InstalacaoModel>?>(
          future: instalacaoDAO.buscarTodos(),
          builder: (context, data) {
            if (data.connectionState == ConnectionState.done &&
                data.requireData!.isNotEmpty) {
              return ListView.builder(
                padding: padding,
                shrinkWrap: true,
                itemCount: data.requireData!.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    color: Colors.blue[200],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: padding,
                              child: Text("ID: ${data.requireData![index].id}"),
                            ),
                            Padding(
                              padding: padding,
                              child: Text(
                                  "TIPO: ${data.requireData![index].tipo}"),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: padding,
                              child: Text(
                                  "ENDEREÇO: ${data.requireData![index].endereco}"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("Não foi possível carregar.."),
              );
            }
          }),
    );
  }
}
