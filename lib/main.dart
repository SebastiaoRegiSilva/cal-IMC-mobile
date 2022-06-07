import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controllerPeso = new TextEditingController();
  TextEditingController controllerAltura = new TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _info = "Informe os dados necessários";
  void _limparConteudo() {
    controllerAltura.text = "";
    controllerPeso.text = "";
    setState(() {
      _info = "Informe os dados necessários";
    });
  }

  String erro = "";
  bool _validaEntrada(String numero1, String numero2) {
    bool _retorno = false;
    erro = "";
    if (double.tryParse(numero1) == null)
      erro = 'O valor do peso não é numérico.';
    else if (double.tryParse(numero2) == null)
      erro = 'O valor da altura não é numérico.';
    else
      _retorno = true;
    return _retorno;
  }

  void calcularImc() {
    setState(() {
      if (_validaEntrada(controllerPeso.text, controllerAltura.text) == true && double.parse(controllerPeso.text) > 0 && double.parse(controllerAltura.text) > 0) {
        double peso = double.parse(controllerPeso.text);
        double altura = double.parse(controllerAltura.text) / 100;
        double imc = peso / (altura * altura);

        if (imc < 18.5) {
          _info = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
        } else if (imc > 18.5 && imc < 24.9) {
          _info = "Peso Ideal (${imc.toStringAsPrecision(4)})";
        } else if (imc > 24.9 && imc < 29.9) {
          _info = "Acima do Peso (${imc.toStringAsPrecision(4)})";
        } else {
          _info = "Obeso (${imc.toStringAsPrecision(4)})";
        }
      } else {
        _info = erro;
        _limparConteudo();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "CALCULADORA DE IMC",
            style: TextStyle(fontFamily: "Segoe UI"),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _limparConteudo,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            // para a tela rolar
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.person,
                    size: 120.0,
                    color: Colors.blue,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (Kg)",
                        labelStyle: TextStyle(
                          color: Colors.blue,
                          fontFamily: "Segoe UI",
                        )),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25.0,
                      fontFamily: "Segoe UI",
                    ),
                    controller: controllerPeso,
                    validator: (value) {
                      return "Insira seu Peso!";
                    },
                  ),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(
                          color: Colors.blue,
                          fontFamily: "Segoe UI",
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 25.0, fontFamily: "Segoe UI"),
                      controller: controllerAltura,
                      validator: (value) {
                        return "Insira sua Altura!";
                      }),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          calcularImc();
                        },
                        color: Colors.blue,
                        child: Text(
                          "Calcular",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: "Segoe UI",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          _limparConteudo();
                        },
                        color: Colors.blue,
                        child: Text(
                          "Limpar",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 25.0,
                            fontFamily: "Segoe UI",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(_info,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 25.0,
                        fontFamily: "Segoe UI",
                      ))
                ],
              ),
            )));
  }
}
