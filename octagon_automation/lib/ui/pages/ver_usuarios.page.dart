import 'package:flutter/material.dart';
import 'package:octagon_automation/database/sqflite/DAO/usuario_dao.dart';
import 'package:octagon_automation/domain/entities/usuario.model.dart';
import 'package:octagon_automation/ui/pages/add_usuarios.page.dart';

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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.black54,
                          width: 1,
                        ),
                        color: Colors.white10,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: padding,
                            child: Text("ID: ${data.requireData![index].id}"),
                          ),
                          Padding(
                            padding: padding,
                            child:
                                Text("Nome: ${data.requireData![index].nome}"),
                          ),
                          Padding(
                            padding: padding,
                            child: Text("CPF: ${data.requireData![index].cpf}"),
                          ),
                          Padding(
                            padding: padding,
                            child: Text(
                                "Telefone: ${data.requireData![index].telefone}"),
                          ),
                          Padding(
                            padding: padding,
                            child: Text(
                                "E-mail: ${data.requireData![index].email}"),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddUsuarioPage(
                                            isEditingUser:
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
                                    usuarioDAO
                                        .remover(data.requireData![index].id);
                                    _showDialog(context,
                                        "Usuário removido com sucesso!");
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
                  child: Text("Não há usuários cadastrados"),
                );
              }
            }),
      ),
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
                Navigator.pushReplacementNamed(context, '/ver_usuarios');
              },
            ),
          ],
        );
      },
    );
  }
}
