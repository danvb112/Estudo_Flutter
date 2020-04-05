import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = "Criando Transferência";

const _rotuloCampoNumeroConta = "Numero da conta";
const _dicaCampoNumeroConta = "0000";

const _rotuloCampoValor = "Valor";
const _dicaCampoValor = "0.00";

const _textoBotao = "Confirmar";

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final _controladorCampoNumeroConta = new TextEditingController();
  final _controladorCampoValor = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tituloAppBar)),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Editor(
              controlador: _controladorCampoNumeroConta,
              rotulo: _rotuloCampoNumeroConta,
              dica: _dicaCampoNumeroConta),
          Editor(
              controlador: _controladorCampoValor,
              rotulo: _rotuloCampoValor,
              dica: _dicaCampoValor,
              icone: Icons.monetization_on),
          RaisedButton(
            child: Text(_textoBotao),
            onPressed: () => _criaTransferencia(context),
          )
        ]),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double valor = double.tryParse(_controladorCampoValor.text);
    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      Navigator.pop(context, transferenciaCriada);
    }
  }
}
