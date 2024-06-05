import 'package:flutter/material.dart';
import 'api_service.dart';

class Resultado extends StatefulWidget {
  const Resultado({Key? key, required String result}) : super(key: key);

  @override
  _ResultadoState createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado> {
  late Future<List<dynamic>> futureUsers;
  final ApiService apiService = ApiService(baseUrl: 'http://localhost:5000');

  @override
  void initState() {
    super.initState();
    futureUsers = apiService.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado da Consulta'),
      ),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: futureUsers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erro: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('Nenhum usuário encontrado');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('User ID: ${snapshot.data![index]['id']}'),
                    subtitle:
                        Text('Username: ${snapshot.data![index]['username']}'),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
