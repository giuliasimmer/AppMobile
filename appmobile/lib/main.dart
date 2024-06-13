import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: 'admin',
    db: 'appmobile',
  );

  final conn = await MySqlConnection.connect(settings);

  runApp(MyApp(conn: conn));
}

class MyApp extends StatelessWidget {
  final MySqlConnection conn;

  const MyApp({Key? key, required this.conn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: Home(conn: conn),
    );
  }
}
