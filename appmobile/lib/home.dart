import 'package:flutter/material.dart';
import 'escolhacurvatura.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
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
                    builder: (context) => EscolhaCurvatura(),
                  ),
                );
              },
              child: Text(
                'CRIAR MINHA CONSULTA DETALHADA',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
