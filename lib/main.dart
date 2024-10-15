import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastrar Produto',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar Produto'),
        ),
        body: const ProductForm(),
      ),
    );
  }
}

class ProductForm extends StatefulWidget {
  const ProductForm({Key? key}) : super(key: key);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            // Campo de Nome do Produto
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome do Produto',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, preencha o nome do produto';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Campo de Preço do Produto
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Preço do Produto',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the product price';
                }
                final price = double.tryParse(value);
                if (price == null || price <= 0) {
                  return 'O preço do produto deve ser maior que 0';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Botão de Enviar
            ElevatedButton(
              onPressed: () {
                // Validação do formulário
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Produto registrado com sucesso!')),
                  );
                  _nameController.clear();
                  _priceController.clear();
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
