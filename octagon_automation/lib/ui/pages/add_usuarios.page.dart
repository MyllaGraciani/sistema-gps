import 'package:flutter/material.dart';
import 'package:octagon_automation/database/sqflite/DAO/UsuarioDAO.dart';

class AddUsuarioPage extends StatelessWidget {
  AddUsuarioPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  UsuarioDAO usuarioDAO = UsuarioDAO();
  final _nomeUsuario = TextEditingController();
  final _cpfUsuario = TextEditingController();
  final _telefoneUsuario = TextEditingController();
  final _emailUsuario = TextEditingController();
  final _senhaUsuario = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
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
                    controller: _nomeUsuario,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                    ),
                  ),
                  TextFormField(
                    controller: _cpfUsuario,
                    decoration: const InputDecoration(
                      labelText: 'CPF',
                    ),
                  ),
                  TextFormField(
                    controller: _telefoneUsuario,
                    decoration: const InputDecoration(
                      labelText: 'Telefone',
                    ),
                  ),
                  TextFormField(
                    controller: _emailUsuario,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  TextFormField(
                    controller: _senhaUsuario,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
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
                        await usuarioDAO.inserir(
                            _nomeUsuario.text,
                            _cpfUsuario.text,
                            _telefoneUsuario.text,
                            _emailUsuario.text,
                            _senhaUsuario.text);
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
