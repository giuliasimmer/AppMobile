import 'package:flutter/material.dart';
import 'escolhacurvatura.dart'; // Certifique-se de que o caminho está correto

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/telafundo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EscolhaCurvatura(), // Navega para a página definida em escolhacurvatura.dart
                  ),
                );
              },
              child: Text('CRIAR MINHA CONSULTA DETALHADA'),
            ),
          ),
        ],
      ),
    );
  }
}
