import 'package:flutter/material.dart';
import 'package:octagon_automation/database/sqflite/DAO/UsuarioDAO.dart';
import 'package:octagon_automation/database/sqflite/conexao.dart';
import 'package:octagon_automation/domain/entities/usuario.model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbConnect = Connection.instance;

  _connect() async {
    await dbConnect.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Octagon Automation'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue[800],
                  ),
                  onPressed: () async {
                    Navigator.pushNamed(context, '/add_usuario');
                  },
                  child: const Text("cadastrar usuário"),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue[800],
                  ),
                  onPressed: () async {
                    Navigator.pushNamed(context, '/ver_usuarios');
                  },
                  child: const Text("ver usuários"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue[800],
                  ),
                  onPressed: () async {
                    Navigator.pushNamed(context, '/add_instalacao');
                  },
                  child: const Text("cadastrar instalação"),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue[800],
                  ),
                  onPressed: () async {
                    Navigator.pushNamed(context, '/ver_instalacoes');
                  },
                  child: const Text("ver instalações"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
