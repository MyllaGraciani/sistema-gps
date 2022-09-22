import 'package:flutter/material.dart';
import 'package:octagon_automation/database/sqflite/DAO/usuario_dao.dart';

class AddUsuarioPage extends StatefulWidget {
  const AddUsuarioPage({Key? key}) : super(key: key);

  @override
  State<AddUsuarioPage> createState() => _AddUsuarioPageState();
}

class _AddUsuarioPageState extends State<AddUsuarioPage> {
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um nome';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _cpfUsuario,
                    decoration: const InputDecoration(
                      labelText: 'CPF',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um CPF';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _telefoneUsuario,
                    decoration: const InputDecoration(
                      labelText: 'Telefone',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um telefone';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailUsuario,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _senhaUsuario,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira uma senha';
                      }
                      return null;
                    },
                  ),
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
                        usuarioDAO.inserir(
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
