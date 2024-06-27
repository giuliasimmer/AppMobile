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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost:5000/api/getcabelo?tipoCabelo=${widget.tipoCabelo}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Navegar para a página de resultados com os dados obtidos
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Resultado(result: json.encode(data), tableName: 'getcabelo'),
          ),
        );
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Tratar erros e exibir mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $e')),
      );
    } finally {
      // Indicar que o carregamento foi concluído
      setState(() {
        _isLoading = false;
      });
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
                _isLoading
                    ? CircularProgressIndicator()
                    : SizedBox
                        .shrink(), // Mostra o indicador de progresso apenas enquanto está carregando
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
