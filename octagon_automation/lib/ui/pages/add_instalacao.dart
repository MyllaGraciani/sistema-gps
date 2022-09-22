import 'package:flutter/material.dart';
import 'package:octagon_automation/database/sqflite/DAO/instalacao_dao.dart';
import 'package:octagon_automation/database/sqflite/DAO/usuario_dao.dart';
import 'package:octagon_automation/domain/entities/usuario.model.dart';

// ignore: must_be_immutable
class AddInstalacaoPage extends StatelessWidget {
  AddInstalacaoPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  InstalacaoDAO instalacaoDAO = InstalacaoDAO();
  UsuarioDAO usuarioDAO = UsuarioDAO();
  final _tipoInstalacao = TextEditingController();
  final _enderecoInstalacao = TextEditingController();
  final _idAdminInstalacao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Instalações'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: 'Tipo de Instalação',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Residencial',
                        child: Text('Residencial'),
                      ),
                      DropdownMenuItem(
                        value: 'Comercial',
                        child: Text('Comercial'),
                      ),
                      DropdownMenuItem(
                        value: 'Outros',
                        child: Text('Outros imóveis'),
                      ),
                    ],
                    onChanged: (value) {
                      _tipoInstalacao.text = value.toString();
                    },
                    validator: (value) => value == null
                        ? 'Por favor, selecione um tipo de instalação'
                        : null,
                  ),
                  TextFormField(
                    controller: _enderecoInstalacao,
                    decoration: const InputDecoration(
                      labelText: 'Endereço',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um endereço';
                      }
                      return null;
                    },
                  ),
                  FutureBuilder<List<UsuarioModel>>(
                      future: usuarioDAO.buscarTodos(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DropdownButtonFormField(
                            validator: (value) => value == null
                                ? 'Por favor, selecione um administrador'
                                : null,
                            decoration: const InputDecoration(
                              labelText: 'Administrador',
                            ),
                            items: snapshot.requireData
                                .map<DropdownMenuItem<String>>(
                                    (e) => DropdownMenuItem(
                                          value: e.id.toString(),
                                          child: Text(e.nome),
                                        ))
                                .toList(),
                            onChanged: (value) {
                              _idAdminInstalacao.text = value.toString();
                            },
                          );
                        } else {
                          return const Text('Carregando...');
                        }
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blue[800],
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        instalacaoDAO.inserir(
                          _tipoInstalacao.text,
                          _enderecoInstalacao.text,
                          int.parse(_idAdminInstalacao.text),
                        );
                        Navigator.pushReplacementNamed(context, '/');
                      }
                    },
                    child: const Text("CADASTRAR"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
