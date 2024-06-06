import 'package:flutter/material.dart';
import 'dart:convert';
import 'api_service.dart';

class Resultado extends StatefulWidget {
  final String result;

  const Resultado({Key? key, required this.result}) : super(key: key);

  @override
  _ResultadoState createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado> {
  late List<dynamic> products;

  @override
  void initState() {
    super.initState();
    products = json.decode(widget.result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado da Consulta'),
      ),
      body: Center(
        child: products.isEmpty
            ? const Text('Nenhum produto encontrado')
            : ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  var product = products[index];
                  return ListTile(
                    title: Text('Nome: ${product['NOMEPRODUTO']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Descrição: ${product['DESCRICAO']}'),
                        Text('Marca: ${product['MARCA']}'),
                        Text('Tamanho: ${product['TAMANHO_ML']} ml'),
                        Text('Valor: R\$ ${product['VALOR']}'),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
