import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'gerarconsulta.dart';

class EscolhaTipo extends StatefulWidget {
  final String curvaturaSelecionada;

  const EscolhaTipo({Key? key, required this.curvaturaSelecionada})
      : super(key: key);

  @override
  _EscolhaTipoState createState() => _EscolhaTipoState();
}

class _EscolhaTipoState extends State<EscolhaTipo> {
  String? selectedOption;
  final GlobalKey<FormState> _dropdownFormKey = GlobalKey<FormState>();
  final Map<String, String> options = {
    'SECO': 'assets/seco.png',
    'NORMAL': 'assets/normal.png',
    'OLEOSO': 'assets/oleoso.png',
  };

  bool showErrorMessage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/fundo.png',
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 40,
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.brown.withOpacity(0.3),
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
                  width: 300,
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.brown.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Escolha seu tipo de cabelo abaixo:',
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
                            _showSelectedOptions();
                          } else {
                            setState(() {
                              showErrorMessage = true;
                            });
                          }
                        },
                        child: const Text('GERAR CONSULTA'),
                      ),
                      const SizedBox(height: 20),
                      if (showErrorMessage && selectedOption == null)
                        const Text(
                          'Escolha uma opção',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
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
        Uri.parse('http://localhost:5000/escolhatipo'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          'seco': option == 'SECO' ? 1 : 0,
          'normal': option == 'NORMAL' ? 1 : 0,
          'oleoso': option == 'OLEOSO' ? 1 : 0,
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

  void _showSelectedOptions() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Opções Selecionadas'),
          content: Text(
              'Curvatura: ${widget.curvaturaSelecionada}\nTipo: $selectedOption'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (selectedOption != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GerarConsulta(
                          tipoCabelo: selectedOption!,
                          curvatura: widget.curvaturaSelecionada),
                    ),
                  );
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
