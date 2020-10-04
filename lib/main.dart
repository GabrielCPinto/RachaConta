import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // VARIAVEIS
  final _tTotal = TextEditingController();
  final _tPessoas = TextEditingController();
  final _tComissao = TextEditingController();
  var _infoText = "Informe seus dados!";
  var _textTotal = "";
  var _textPPessoa = "";
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Racha Conta"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetFields)
        ],
      ),
      body: _body(),
    );
  }

  // PROCEDIMENTO PARA LIMPAR OS CAMPOS
  void _resetFields(){
    _tTotal.text = "";
    _tPessoas.text = "";
    _tComissao.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _textTotal = "";
      _textPPessoa = "";
      _formKey = GlobalKey<FormState>();
    });
  }

  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _editText("Valor Total da Conta", _tTotal),
              _editText("Nº pessoas a Pagar", _tPessoas),
              _editText("Comissão ao Garçom (%)", _tComissao),
              _buttonCalcular(),
              _textIPPessoa(),
              _textInfo(),
              _textITotal(),
            ],
          ),
        ));
  }

  // Widget text
  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 22,
        color: Colors.blue,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 22,
          color: Colors.grey,
        ),
      ),
    );
  }

  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  String _validate(String text, String field) {
    if (text.isEmpty) {
      return "Digite $field";
    }
    return null;
  }

  // Widget button
  _buttonCalcular() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20),
      height: 45,
      child: RaisedButton(
        color: Colors.black,
        child:
        Text(
          "Calcular",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
            _calculate();
          }
        },
      ),
    );
  }

  // PROCEDIMENTO PARA CALCULAR A CONTA
  void _calculate(){
    setState(() {
      double total = double.parse(_tTotal.text);
      double comissao = total*double.parse(_tComissao.text)/100;
      int pessoas = int.parse(_tPessoas.text);
      double valTotal = total+comissao;
      double valPPessoa = total/pessoas;
      _textPPessoa = "Valor de Cada Pessoa: $valPPessoa";
      _infoText = "Valor ao Garçom: $comissao";
      _textTotal = "Valor Total a ser Pago: $valTotal";
    });
  }

  // // Widget text
  _textInfo() {
    return Text(
      _infoText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.blue, fontSize: 25.0),
    );
  }
  _textIPPessoa() {
    return Text(
      _textPPessoa,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.blue, fontSize: 25.0),
    );
  }
  _textITotal() {
    return Text(
      _textTotal,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.blue, fontSize: 25.0),
    );
  }
}
