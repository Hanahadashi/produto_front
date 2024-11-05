class Produto {
  final int id;
  final String description;
  final double price;
  final int quantity;
  final DateTime date;

  Produto({required this.id, required this.description, required this.price, required this.quantity, required this.date});

  factory Produto.fromJson(Map<String, dynamic> json) {
  return Produto(
    id: json['id'] ?? 0,
    description: json['description'] ?? 'Bitato',
    price: double.tryParse(json['price']?.toString() ?? '0.0') ?? 0.0,
    quantity: json['quantity'] ?? 0,
    date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
    );
  }
}