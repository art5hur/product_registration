import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Produto',
      home: const ProductFormPage(),
    );
  }
}

// Tela de Formulário de Cadastro
class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  // Simula uma ação assíncrona (salvando os dados do produto)
  Future<void> _submitForm() async {
    setState(() {
      _isSubmitting = true;
    });

    // Simula um delay para salvar os dados
    await Future.delayed(const Duration(seconds: 2));

    if (_formKey.currentState!.validate()) {
      // Após a validação, navegue para a próxima página com as informações do produto
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProductDetailPage(
            productName: _nameController.text,
            productPrice: double.parse(_priceController.text),
          ),
        ),
      );
    }

    setState(() {
      _isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Produto'),
      ),
      body: Padding(
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
                    return 'Por favor, informe o preço do produto';
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
                onPressed: _isSubmitting
                    ? null
                    : () async {
                        // Chama a função assíncrona para processar o formulário
                        await _submitForm();
                      },
                child: _isSubmitting
                    ? const CircularProgressIndicator()
                    : const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Tela que exibe os detalhes do produto após o cadastro
class ProductDetailPage extends StatelessWidget {
  final String productName;
  final double productPrice;

  const ProductDetailPage({
    Key? key,
    required this.productName,
    required this.productPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Nome do Produto: $productName',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text(
              'Preço do Produto: R\$ ${productPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Voltar para a tela de cadastro
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
