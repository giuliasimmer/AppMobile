import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final String result;

  const Resultado({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado da Consulta'),
      ),
      body: Center(
        child: Text(
          result,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
