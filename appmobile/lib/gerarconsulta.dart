import 'package:flutter/material.dart';

class GerarConsulta extends StatelessWidget {
  final String tipoCabelo;

  const GerarConsulta({Key? key, required this.tipoCabelo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simulação de uma chamada de API
    _simulateApiCall(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerando Consulta'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Gerando consulta para tipo de cabelo: $tipoCabelo'),
          ],
        ),
      ),
    );
  }

  void _simulateApiCall(BuildContext context) async {
    // Simulação de espera de uma chamada de API
    await Future.delayed(Duration(seconds: 3));
    // Após a espera, você pode navegar para outra página ou mostrar os resultados
    // Exemplo:
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => ResultPage(result: apiResult)),
    // );
  }
}
