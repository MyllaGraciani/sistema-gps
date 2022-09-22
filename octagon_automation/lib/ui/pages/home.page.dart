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
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Octagon Automation'),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(10),
              color: Colors.blue[100],
              child: Column(
                children: [
                  const Icon(
                    Icons.person_pin,
                    size: 100,
                    color: Colors.blue,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () async {
                          Navigator.pushNamed(context, '/add_usuario');
                        },
                        child: const Text("cadastrar usuário",
                            style: TextStyle(fontSize: 16)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () async {
                          Navigator.pushNamed(context, '/ver_usuarios');
                        },
                        child: const Text("ver usuários",
                            style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.all(10),
              color: Colors.black12,
              child: Column(
                children: [
                  const Icon(
                    Icons.home_work,
                    size: 100,
                    color: Colors.black54,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.black54,
                        ),
                        onPressed: () async {
                          Navigator.pushNamed(context, '/add_instalacao');
                        },
                        child: const Text("cadastrar instalação",
                            style: TextStyle(fontSize: 16)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.black54,
                        ),
                        onPressed: () async {
                          Navigator.pushNamed(context, '/ver_instalacoes');
                        },
                        child: const Text("ver instalações",
                            style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
