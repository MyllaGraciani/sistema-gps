import 'package:flutter/material.dart';
import 'package:octagon_automation/database/sqflite/DAO/UsuarioDAO.dart';
import 'package:octagon_automation/domain/entities/usuario.model.dart';

// ignore: must_be_immutable
class VerUsuariosPage extends StatelessWidget {
  VerUsuariosPage({Key? key}) : super(key: key);

  UsuarioDAO usuarioDAO = UsuarioDAO();
  final padding = const EdgeInsets.all(8.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários cadastrados'),
      ),
      body: Center(
        child: FutureBuilder<List<UsuarioModel>?>(
            future: usuarioDAO.buscarTodos(),
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
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: padding,
                                child:
                                    Text("ID: ${data.requireData![index].id}"),
                              ),
                              Padding(
                                padding: padding,
                                child: Text(
                                    "Nome: ${data.requireData![index].nome}"),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: padding,
                                child: Text(
                                    "CPF: ${data.requireData![index].cpf}"),
                              ),
                              Padding(
                                padding: padding,
                                child: Text(
                                    "Telefone: ${data.requireData![index].telefone}"),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: padding,
                                child: Text(
                                    "E-mail: ${data.requireData![index].email}"),
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
      ),
    );
  }
}
