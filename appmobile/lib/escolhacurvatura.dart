import 'package:flutter/material.dart';
import 'escolhatipo.dart'; // Importar a página EscolhaTipo

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
        title: Text('Seleção de Opções'),
      ),
      body: Center(
        child: Form(
          key: _dropdownFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Escolha uma opção:',
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
                    if (selectedOption != null) {
                      // Navegar para a próxima página (EscolhaTipo)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EscolhaTipo(),
                        ),
                      );
                      showErrorMessage = false;
                    } else {
                      showErrorMessage = true;
                    }
                  });
                },
                child: Text('CONTINUAR'),
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
}
