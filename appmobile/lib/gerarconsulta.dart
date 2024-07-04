import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'resultado.dart';

class GerarConsulta extends StatefulWidget {
  final String tipoCabelo;
  final String curvatura;

  const GerarConsulta({
    Key? key,
    required this.tipoCabelo,
    required this.curvatura,
  }) : super(key: key);

  @override
  _GerarConsultaState createState() => _GerarConsultaState();
}

class _GerarConsultaState extends State<GerarConsulta> {
  bool _isLoading = true;
  late String tableName;
  late List<dynamic> data; // Change to List<dynamic> to store the fetched data
  bool _canViewResult = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/recolhecabelo'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'tipo_cabelo': widget.tipoCabelo,
          'curvatura': widget.curvatura,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          tableName = responseData['result_table_name'];
          _fetchTableData(); // Fetch data from the table
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchTableData() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:5000/resultadocabelo'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          data = responseData[tableName];
          _canViewResult = true; // Habilita o botão para ver o resultado
        });
      } else {
        throw Exception('Failed to load table data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar dados da tabela: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/telaespera.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _isLoading ? CircularProgressIndicator() : SizedBox.shrink(),
                const SizedBox(height: 20),
                Text(
                  'Gerando consulta para tipo de cabelo: ${widget.tipoCabelo}',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  'Escolha de curvatura: ${widget.curvatura}',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _canViewResult
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Resultado(
                                result: json.encode(data),
                                tableName: tableName,
                                tipoCabelo: widget.tipoCabelo,
                                curvatura: widget.curvatura,
                              ),
                            ),
                          );
                        }
                      : null, // Desabilita o botão se não puder ver o resultado
                  child: Text('Ver Resultado'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
