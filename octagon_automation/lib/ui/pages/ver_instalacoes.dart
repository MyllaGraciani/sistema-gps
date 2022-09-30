import 'package:flutter/material.dart';
import 'package:octagon_automation/database/sqflite/DAO/instalacao_dao.dart';
import 'package:octagon_automation/database/sqflite/DAO/usuario_dao.dart';
import 'package:octagon_automation/domain/entities/instalacao.model.dart';
import 'package:octagon_automation/ui/pages/add_instalacao.dart';

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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black54,
                        width: 1,
                      ),
                      color: Colors.white10,
                    ),
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
                        Padding(
                          padding: padding,
                          child: Text(
                              "ENDEREÇO: ${data.requireData![index].endereco}"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddInstalacaoPage(
                                          isEditingInstalacao:
                                              data.requireData![index].id),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit),
                                label: const Text("Editar"),
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.blue,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton.icon(
                                onPressed: () {
                                  instalacaoDAO
                                      .remover(data.requireData![index].id);
                                  _showDialog(context,
                                      "Instalação removida com sucesso!");
                                },
                                icon: const Icon(Icons.delete),
                                label: const Text("Remover"),
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.red,
                                )),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("Não há instalações cadastradas!"),
              );
            }
          }),
    );
  }

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/ver_instalacoes');
              },
            ),
          ],
        );
      },
    );
  }
}
