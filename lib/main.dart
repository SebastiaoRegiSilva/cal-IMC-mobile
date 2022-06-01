import 'package:flutter/material.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Flutter Stateful Clicker Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Cálculo de IMC.'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _peso = TextEditingController();
  TextEditingController _altura = TextEditingController();
  TextEditingController _resultado = TextEditingController();

  void calcImc() {
    double peso = double.parse(_peso.text);
    double altura = double.parse(_altura.text) / 100.0;
    double imc = peso / (altura * altura);

    setState(() {
      _resultado.text = "IMC = ${imc.toStringAsPrecision(2)}\n";
      // Depois substituir por um switch case.
      if (imc < 18.5)
        _resultado.text += "Abaixo do peso ideal.";
      else if (imc < 25.0)
        _resultado.text += "Peso ideal.";
      else if (imc < 30.0)
        _resultado.text += "Acima do peso ideal.";
      else
        _resultado.text += "Obeso.";
    });
  }

  void _limpar() {
    setState(() {
      _peso.text = "";
      _altura.text = "";

      _resultado.text = 'Informe seus dados!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextField(
                    controller: _altura,
                    decoration: InputDecoration(
                      icon: Icon(Icons.add_location_alt_rounded),
                      border: OutlineInputBorder(),
                      labelText: "Digite o altura",
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextField(
                    controller: _peso,
                    decoration: InputDecoration(
                      icon: Icon(Icons.access_alarms_outlined),
                      border: OutlineInputBorder(),
                      labelText: "Digite o peso",
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextField(
                    maxLength: 11,
                    enabled: false,
                    decoration: InputDecoration(
                      icon: Icon(Icons.question_answer),
                      border: OutlineInputBorder(),
                      labelText: "Resultado",
                    )),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 5, 20),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      primary: Colors.black,
                      padding: EdgeInsets.all(20.0),
                      textStyle: TextStyle(fontSize: 17),
                    ),
                    onPressed: () {
                      calcImc();
                    },
                    child: Text('Calcular IMC'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 20, 20),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      primary: Colors.black,
                      padding: EdgeInsets.all(20.0),
                      textStyle: TextStyle(fontSize: 17),
                    ),
                    onPressed: () {
                      _limpar();
                    },
                    child: Text("Limpar tudo"),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
