import 'package:flutter/material.dart';
import 'package:octagon_automation/database/sqflite/DAO/usuario_dao.dart';

class AddUsuarioPage extends StatefulWidget {
  final int isEditingUser;
  const AddUsuarioPage({Key? key, required this.isEditingUser})
      : super(key: key);

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

  void isEditing() {
    if (widget.isEditingUser != 0) {
      usuarioDAO.buscarUsuarioPorId(widget.isEditingUser).then((value) {
        _nomeUsuario.text = value.nome;
        _cpfUsuario.text = value.cpf;
        _telefoneUsuario.text = value.telefone;
        _emailUsuario.text = value.email;
        _senhaUsuario.text = value.senha;
      });
    }
  }

  @override
  void initState() {
    isEditing();
    super.initState();
  }

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
                        if (widget.isEditingUser != 0) {
                          Map<String, dynamic> usuario = {
                            'id': widget.isEditingUser,
                            'nome': _nomeUsuario.text,
                            'cpf': _cpfUsuario.text,
                            'telefone': _telefoneUsuario.text,
                            'email': _emailUsuario.text,
                            'senha': _senhaUsuario.text,
                          };
                          usuarioDAO.atualizar(usuario);

                          _showDialog(
                              context, 'Usuário atualizado com sucesso!');
                        } else {
                          usuarioDAO.inserir(
                              _nomeUsuario.text,
                              _cpfUsuario.text,
                              _telefoneUsuario.text,
                              _emailUsuario.text,
                              _senhaUsuario.text);

                          _showDialog(
                              context, 'Usuário cadastrado com sucesso!');
                        }
                      }
                    },
                    child: Text(
                        widget.isEditingUser == 0 ? 'CADASTRAR' : 'EDITAR'),
                  ),
                ],
              ),
            ),
          ),
        ),
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
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        );
      },
    );
  }
}
