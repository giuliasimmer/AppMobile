import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Resultado extends StatefulWidget {
  final String tableName;

  const Resultado({
    Key? key,
    required this.tableName,
    required String result,
    required String tipoCabelo,
    required String curvatura,
  }) : super(key: key);

  @override
  _ResultadoState createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado> {
  late List<dynamic> items;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:5000/api/resultadocabelo'),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          items = responseData['data'];
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Trata erros e exibe mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado da Consulta'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      var item = items[index];
                      return Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          title: Text('Marca: ${item['MARCA']}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Descrição: ${item['DESCRICAO']}'),
                              Text('Preço: ${item['PRECO']}'),
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
