import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'escolhatipo.dart'; // Certifique-se de que o caminho está correto

class EscolhaCurvatura extends StatefulWidget {
  @override
  _EscolhaCurvaturaState createState() => _EscolhaCurvaturaState();
}

class _EscolhaCurvaturaState extends State<EscolhaCurvatura> {
  String? selectedOption;
  final GlobalKey<FormState> _dropdownFormKey = GlobalKey<FormState>();
  final Map<String, String> options = {
    'LISO': 'assets/liso.png',
    'ONDULADO': 'assets/ondulado.png',
    'CACHEADO': 'assets/cacheado.png',
  };

  bool showErrorMessage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleção de Curvatura do Cabelo'),
      ),
      body: Center(
        child: Form(
          key: _dropdownFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Escolha uma opção:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Column(
                children: _buildChoiceList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (selectedOption != null) {
                    await _saveSelectionToDatabase(selectedOption!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EscolhaTipo(
                          curvaturaSelecionada: selectedOption!,
                        ),
                      ),
                    );
                    setState(() {
                      showErrorMessage = false;
                    });
                  } else {
                    setState(() {
                      showErrorMessage = true;
                    });
                  }
                },
                child: const Text('CONTINUAR'),
              ),
              const SizedBox(height: 20),
              if (showErrorMessage && selectedOption == null)
                const Text(
                  'Escolha uma opção',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveSelectionToDatabase(String option) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://localhost:5000/escolhacurvatura'), // URL do servidor Flask
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          'liso': option == 'LISO' ? 1 : 0,
          'ondulado': option == 'ONDULADO' ? 1 : 0,
          'cacheado': option == 'CACHEADO' ? 1 : 0,
        }),
      );
      if (response.statusCode == 200) {
        print('Dados inseridos com sucesso');
      } else {
        print('Erro ao inserir dados: ${response.body}');
      }
    } catch (e) {
      print('Erro ao conectar ao servidor: $e');
    }
  }

  List<Widget> _buildChoiceList() {
    List<Widget> choices = [];
    options.forEach((key, value) {
      choices.add(
        GestureDetector(
          onTap: () {
            setState(() {
              selectedOption = key;
            });
          },
          child: Column(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundColor: selectedOption == key ? Colors.brown : null,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(value),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                key,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    });
    return choices;
  }
}
