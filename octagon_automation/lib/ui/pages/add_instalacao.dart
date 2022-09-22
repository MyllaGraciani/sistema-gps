import 'package:flutter/material.dart';
import 'package:octagon_automation/database/sqflite/DAO/InstalacaoDAO.dart';

class AddInstalacaoPage extends StatelessWidget {
  AddInstalacaoPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  InstalacaoDAO instalacaoDAO = InstalacaoDAO();
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
                  TextFormField(
                    controller: _tipoInstalacao,
                    decoration: const InputDecoration(
                      labelText: 'Tipo',
                    ),
                  ),
                  TextFormField(
                    controller: _enderecoInstalacao,
                    decoration: const InputDecoration(
                      labelText: 'Endereço',
                    ),
                  ),
                  TextFormField(
                    controller: _idAdminInstalacao,
                    decoration: const InputDecoration(
                      labelText: 'ID Administrador',
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blue[800],
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
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
