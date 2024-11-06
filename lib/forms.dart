import 'package:flutter/material.dart';
import 'produto.dart';
import 'services.dart';

class ProdutoFormScreen extends StatefulWidget {
  final Produto? produto;

  ProdutoFormScreen({this.produto});

  @override
  _ProdutoFormScreenState createState() => _ProdutoFormScreenState();
}

class _ProdutoFormScreenState extends State<ProdutoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ProdutoService produtoService = ProdutoService();

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    _descriptionController.text = widget.produto?.description ?? '';
    _priceController.text = widget.produto?.price.toString() ?? '0.0';
    _quantityController.text = widget.produto?.quantity.toString() ?? '0';
    _date = widget.produto?.date ?? DateTime.now();
  }


  @override
  void dispose() {
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _saveProduto() async {
  if (_formKey.currentState!.validate()) {
    final Produto produto = Produto(
      id: widget.produto?.id ?? 0,
      description: _descriptionController.text,
      price: double.tryParse(_priceController.text) ?? 0.0,
      quantity: int.tryParse(_quantityController.text) ?? 0,
      date: _date,
    );

    try {
      if (widget.produto == null) {
        await produtoService.createProduto(produto);
      } else {
        await produtoService.updateProduto(context, produto);
      }
      Navigator.pop(context, true);
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erro'),
          content: Text('Ocorreu um erro ao salvar o produto: $error'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.produto == null ? 'Adicionar Produto' : 'Editar Produto'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira a descrição';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira o preço';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Insira um valor válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantidade'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira a quantidade';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Insira um valor inteiro';
                  }
                  return null;
                },
              ),
              ListTile(
                title: Text('Data'),
                subtitle: Text(_date.toLocal().toString().split(' ')[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != _date) {
                    setState(() {
                      _date = pickedDate;
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProduto,
                child: Text(widget.produto == null ? 'Adicionar' : 'Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
