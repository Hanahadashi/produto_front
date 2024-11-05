import 'package:flutter/material.dart';
import 'list.dart'; // Certifique-se de que o caminho e o nome estão corretos

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD de Produtos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProdutoListScreen(), // Tela inicial
      debugShowCheckedModeBanner: false,
    );
  }
}
