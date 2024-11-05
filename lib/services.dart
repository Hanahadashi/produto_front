import 'dart:convert';
import 'package:http/http.dart' as http;
import 'produto.dart';

class ProdutoService {
  final String baseUrl = "http://localhost:3000/produtos";

  Future<List<Produto>> fetchProdutos() async {
    final response = await http.get(Uri.parse(baseUrl));
    print(response.body); // Adiciona um print para depurar a resposta
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((produto) => Produto.fromJson(produto)).toList();
    } else {
      throw Exception('Erro ao carregar produtos');
    }
  }


  Future<Produto> createProduto(Produto produto) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "description": produto.description,
        "price": produto.price,
        "quantity": produto.quantity,
        "date": produto.date.toIso8601String(),
      }),
    );

    if (response.statusCode == 201) {
      return Produto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao criar produto');
    }
  }

  Future<void> updateProduto(Produto produto) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${produto.id}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "description": produto.description,
        "price": produto.price,
        "quantity": produto.quantity,
        "date": produto.date.toIso8601String(),
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao atualizar produto');
    }
  }

  Future<void> deleteProduto(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar produto');
    }
  }
}
