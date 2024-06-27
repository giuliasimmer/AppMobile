import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class Resultado extends StatefulWidget {
  final String result;
  final String tableName;

  const Resultado({Key? key, required this.result, required this.tableName})
      : super(key: key);

  @override
  _ResultadoState createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado> {
  late List<dynamic> products;

  @override
  void initState() {
    super.initState();
    try {
      // Decodifica o resultado JSON retornado pela procedure
      products = json.decode(widget.result);
    } catch (e) {
      // Trata qualquer erro de decodificação
      print('Erro ao decodificar JSON: $e');
      products = []; // Define uma lista vazia em caso de erro
    }
  }

  // Função para lançar URL
  void launchURL() async {
    String baseUrl = 'http://localhost:5000/api/';
    String url = baseUrl + '${widget.tableName}'; // URL completa
    if (await canLaunch(url)) {
      await launch(url); // Use await aqui para esperar o lançamento do URL
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado da Consulta'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                launchURL();
              },
              child: Text('Abrir ${widget.tableName}'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                var product = products[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text('Marca: ${product['MARCA']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Descrição: ${product['DESCRICAO']}'),
                        Text('Preço: ${product['PRECO']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
