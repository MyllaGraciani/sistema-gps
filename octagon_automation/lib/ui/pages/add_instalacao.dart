import 'package:flutter/material.dart';
import 'package:octagon_automation/database/sqflite/DAO/instalacao_dao.dart';
import 'package:octagon_automation/database/sqflite/DAO/usuario_dao.dart';
import 'package:octagon_automation/domain/entities/instalacao.model.dart';
import 'package:octagon_automation/domain/entities/usuario.model.dart';

class AddInstalacaoPage extends StatefulWidget {
  final int isEditingInstalacao;
  const AddInstalacaoPage({Key? key, required this.isEditingInstalacao})
      : super(key: key);

  @override
  State<AddInstalacaoPage> createState() => _AddInstalacaoPageState();
}

class _AddInstalacaoPageState extends State<AddInstalacaoPage> {
  final _formKey = GlobalKey<FormState>();

  InstalacaoDAO instalacaoDAO = InstalacaoDAO();

  UsuarioDAO usuarioDAO = UsuarioDAO();

  final _tipoInstalacao = TextEditingController();

  final _enderecoInstalacao = TextEditingController();

  final _idAdminInstalacao = TextEditingController();

  isEditing() {
    Future<InstalacaoModel> instalacaoModel =
        instalacaoDAO.buscarInstalacaoPorId(widget.isEditingInstalacao);
    if (widget.isEditingInstalacao != 0) {
      instalacaoModel.then((value) => {
            print(
                "id ${value.id} tipo ${value.tipo} end ${value.endereco} id ${value.idAdmin}"),
            _tipoInstalacao.text = value.tipo,
            _enderecoInstalacao.text = value.endereco,
            _idAdminInstalacao.text = value.idAdmin.toString(),
          });
    }
    if (widget.isEditingInstalacao == 0) {
      _tipoInstalacao.text = "";
      _enderecoInstalacao.text = "";
      _idAdminInstalacao.text = "";
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
                  FutureBuilder<List<UsuarioModel>>(
                      future: usuarioDAO.buscarTodos(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          isEditing();
                          return Column(
                            children: [
                              DropdownButtonFormField(
                                value: widget.isEditingInstalacao == 0
                                    ? null
                                    : _tipoInstalacao.text,
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
                                    value: 'Outros imóveis',
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
                              DropdownButtonFormField(
                                value: widget.isEditingInstalacao == 0
                                    ? null
                                    : _idAdminInstalacao.text,
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
                              ),
                            ],
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
                        if (widget.isEditingInstalacao != 0) {
                          Map<String, dynamic> instalacao = {
                            'id': widget.isEditingInstalacao,
                            'tipo': _tipoInstalacao.text,
                            'endereco': _enderecoInstalacao.text,
                            'idAdmin': int.parse(_idAdminInstalacao.text)
                          };
                          instalacaoDAO.atualizar(instalacao).then((value) =>
                              _showDialog(
                                  context, 'Instalação editada com sucesso!'));
                        } else {
                          instalacaoDAO
                              .inserir(
                                  _tipoInstalacao.text,
                                  _enderecoInstalacao.text,
                                  int.parse(_idAdminInstalacao.text))
                              .then((value) => _showDialog(context,
                                  'Instalação cadastrada com sucesso!'));
                        }
                      }
                    },
                    child: Text(widget.isEditingInstalacao == 0
                        ? 'CADASTRAR'
                        : 'EDITAR'),
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
                Navigator.pushReplacementNamed(context, '/ver_instalacoes');
              },
            ),
          ],
        );
      },
    );
  }
}
