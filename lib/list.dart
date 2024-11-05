import 'package:flutter/material.dart';
import 'produto.dart';
import 'services.dart';
import 'forms.dart'; // Importando a tela de criação/edição

class ProdutoListScreen extends StatefulWidget {
  @override
  _ProdutoListScreenState createState() => _ProdutoListScreenState();
}

class _ProdutoListScreenState extends State<ProdutoListScreen> {
  final ProdutoService produtoService = ProdutoService();
  late Future<List<Produto>> produtos;

  @override
  void initState() {
    super.initState();
    produtos = produtoService.fetchProdutos();
  }

  void _refreshProdutos() {
    setState(() {
      produtos = produtoService.fetchProdutos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Produtos"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              // Navega para a tela de criação de produto
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProdutoFormScreen(),
                ),
              );
              if (result == true) {
                _refreshProdutos(); // Atualiza a lista após a criação
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Produto>>(
        future: produtos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Nenhum produto encontrado"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final produto = snapshot.data![index];
                return ListTile(
                  title: Text(produto.description),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await produtoService.deleteProduto(produto.id);
                      _refreshProdutos();
                    },
                  ),
                  onTap: () async {
                    // Navega para a tela de edição de produto com o produto selecionado
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProdutoFormScreen(produto: produto),
                      ),
                    );
                    if (result == true) {
                      _refreshProdutos(); // Atualiza a lista após a edição
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
