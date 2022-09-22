import 'package:flutter/material.dart';
import 'package:octagon_automation/ui/pages/add_instalacao.dart';
import 'package:octagon_automation/ui/pages/add_usuarios.page.dart';
import 'package:octagon_automation/ui/pages/home.page.dart';
import 'package:octagon_automation/ui/pages/ver_instalacoes.dart';
import 'package:octagon_automation/ui/pages/ver_usuarios.page.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Octagon Automation',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/add_usuario': (context) => AddUsuarioPage(),
        '/add_instalacao': (context) => AddInstalacaoPage(),
        '/ver_usuarios': (context) => VerUsuariosPage(),
        '/ver_instalacoes': (context) => VerInstalacoesPage(),
      },
    );
  }
}
