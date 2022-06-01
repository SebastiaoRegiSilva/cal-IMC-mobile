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

  void _calcImc() async {
    // if (_altura.text.trim().length >= 1 && _peso.text.trim().length >=1) {
    //     double resultado = double.parse(_peso.text) * double.parse(_altura.text);

    //   setState(() {
    //     _peso.text = _peso.toString();
    //     _altura.text = _altura.toString();
    //   });
    // }
    // return resultado;
  }

  void _calcular() {
    //_calcImc()();
    setState(() {});
  }

  void _limpar() {
    setState(() {
      _peso.text = "";
      _altura.text = "";
      _resultado.text = "";
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
                    maxLength: 8,
                    controller: _altura,
                    // Conforme inserção do cep, os campos subsequentes serão automaticamente preeenchidos.
                    onChanged: (inputValue) {
                      validator:
                      (value) {
                        if (value.isEmpty) {
                          return 'Informe altura válida!';
                        }
                      };

                      double? altura = double.tryParse(_altura.text);
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.add_location_alt_rounded),
                      border: OutlineInputBorder(),
                      labelText: "Digite o altura",
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextField(
                    maxLength: 11,
                    controller: _peso,
                    // Conforme a renda mensal for mudando o limite de crédito(30%) acompanha.
                    onChanged: (inputValue) {
                      var altura = double.tryParse(_altura.text);
                      var peso = double.tryParse(_peso.text);

                      var resultado = peso;

                      if (resultado != null) _resultado.text = resultado.toString();
                    },
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
                    controller: _resultado,
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
                      _calcular();
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
