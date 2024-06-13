import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      appBar: AppBar(
        title: const Text('Seleção de Tipo de Cabelo'),
      ),
      body: Center(
        child: Form(
          key: _dropdownFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Escolha o tipo de cabelo:',
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
                    _showSelectedOptions();
                    setState(() {
                      showErrorMessage = false;
                    });
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
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveSelectionToDatabase(String option) async {
    final url = Uri.parse('http://localhost:5000/escolhatipo');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'oleoso': option == 'OLEOSO' ? 1 : 0,
        'normal': option == 'NORMAL' ? 1 : 0,
        'seco': option == 'SECO' ? 1 : 0,
        'curvatura': widget.curvaturaSelecionada,
      }),
    );

    if (response.statusCode == 200) {
      print('Dados inseridos com sucesso na tabela EscolhaTipo.');
    } else {
      print('Erro ao inserir dados: ${response.body}');
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
