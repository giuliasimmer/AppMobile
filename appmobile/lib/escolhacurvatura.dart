import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'escolhatipo.dart';

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
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.white,
            child: Image.asset(
              'assets/fundo.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.brown.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: 250,
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.brown.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Escolha a curvatura do seu cabelo abaixo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _dropdownFormKey,
                  child: Column(
                    children: [
                      Column(
                        children: _buildChoiceList(),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.brown,
                          textStyle: TextStyle(fontWeight: FontWeight.bold),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
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
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveSelectionToDatabase(String option) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/escolhacurvatura'),
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
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selectedOption == key
                        ? Colors.brown
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.transparent,
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
