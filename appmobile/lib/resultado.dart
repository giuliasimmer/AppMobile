import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Resultado extends StatefulWidget {
  final String tableName;
  final String result;
  final String tipoCabelo;
  final String curvatura;

  const Resultado({
    Key? key,
    required this.tableName,
    required this.result,
    required this.tipoCabelo,
    required this.curvatura,
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
        Uri.parse('http://localhost:5000/resultadocabelo'),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          items = responseData[widget.tableName];
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
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
        title: const Text(''),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : items.isEmpty
              ? Center(child: Text('Nenhum dado encontrado'))
              : Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          'assets/logo.png',
                          width: 350,
                          height: 350,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          var item = items[index];
                          return Card(
                            color: Colors.brown[200],
                            margin: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: Image.asset(
                                    'assets/produto.png',
                                    width: 50,
                                    height: 50,
                                  ),
                                  title: Text(
                                    'MARCA: ${item['MARCA']}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'DESCRIÇÃO: ${item['DESCRICAO']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'PREÇO: ${item['PRECO']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            '*Para efetuar sua compra você deverá copiar o nome do produto na barra de pesquisa*',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              const url = 'https://www.belezanaweb.com.br/';
                              launchURL(url);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30),
                              backgroundColor:
                                  Color.fromARGB(255, 204, 171, 123),
                            ),
                            child: Text(
                              'REALIZAR COMPRA',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
