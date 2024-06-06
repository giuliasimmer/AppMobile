import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'resultado.dart';

class GerarConsulta extends StatefulWidget {
  final String tipoCabelo;

  const GerarConsulta({Key? key, required this.tipoCabelo}) : super(key: key);

  @override
  _GerarConsultaState createState() => _GerarConsultaState();
}

class _GerarConsultaState extends State<GerarConsulta> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost:5000/api/products?tipoCabelo=${widget.tipoCabelo}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Navegar para a página de resultados com os dados obtidos
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Resultado(result: json.encode(data)),
          ),
        );
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      // Tratar erros e exibir mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerando Consulta'),
      ),
      body: Stack(
        children: [
          // Imagem de fundo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/telaespera.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Conteúdo da página
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                Text(
                    'Gerando consulta para tipo de cabelo: ${widget.tipoCabelo}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
