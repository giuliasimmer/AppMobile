import 'package:flutter/material.dart';

class EscolhaTipo extends StatefulWidget {
  @override
  _EscolhaTipoState createState() => _EscolhaTipoState();
}

class _EscolhaTipoState extends State<EscolhaTipo> {
  String? selectedOption;
  final GlobalKey<FormState> _dropdownFormKey = GlobalKey<FormState>();
  final Map<String, String> options = {
    'Seco': 'assets/seco.png',
    'Médio': 'assets/normal.png',
    'Oleoso': 'assets/oleoso.png',
  };

  bool showErrorMessage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleção de Tipo de Cabelo'),
      ),
      body: Center(
        child: Form(
          key: _dropdownFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Escolha o tipo de cabelo:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Column(
                children: _buildChoiceList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_dropdownFormKey.currentState!.validate() &&
                        selectedOption != null) {
                      // Chamada para API ou próxima página após validação
                      _gerarConsulta(selectedOption!);
                      showErrorMessage = false;
                    } else {
                      showErrorMessage = true;
                    }
                  });
                },
                child: Text('Gerar Consulta'),
              ),
              SizedBox(height: 20),
              if (showErrorMessage && selectedOption == null)
                Text(
                  'Escolha uma opção',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildChoiceList() {
    List<Widget> choices = [];
    options.forEach((key, value) {
      choices.add(
        GestureDetector(
          onTap: () {
            setState(() {
              // Adiciona ou remove a seleção da opção
              selectedOption = selectedOption == key ? null : key;
            });
          },
          child: Column(
            children: [
              CircleAvatar(
                radius: 45, // Aumentar o tamanho da imagem
                backgroundColor: selectedOption == key ? Colors.brown : null,
                child: CircleAvatar(
                  radius: 40, // Aumentar o tamanho da imagem
                  backgroundImage: AssetImage(value),
                ),
              ),
              SizedBox(height: 10),
              Text(
                key,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      );
    });
    return choices;
  }

  // Função para chamar a API ou navegar para a próxima página
  void _gerarConsulta(String tipoCabelo) {
    // Aqui você faria a chamada para a API
    print('Consulta gerada para o tipo de cabelo: $tipoCabelo');
  }
}
