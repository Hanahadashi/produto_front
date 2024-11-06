import 'package:flutter/material.dart';
import 'list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD de Produtos',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ProdutoListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
