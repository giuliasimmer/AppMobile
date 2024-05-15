import 'package:flutter/material.dart';

class EscolhaCurvatura extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Escolha Curvatura')),
        body: Center(
            child: ElevatedButton(onPressed: null, child: Text('Continuar'))));
  }
}
