import 'dart:async';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/screens/transferencias/formulario.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = "Transferências";

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = List();

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

class ListaTransferenciaState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: widget._transferencias.length,
          itemBuilder: (context, indice) {
            final transferencia = widget._transferencias[indice];
            return ItemTrasferencia(transferencia);
          }),
      appBar: AppBar(title: Text(_tituloAppBar)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          })).then((transferenciarecebida) => _atualiza(transferenciarecebida));
        },
      ),
    );
  }

  void _atualiza(Transferencia transferenciarecebida) {
    if (transferenciarecebida != null) {
      setState(() {
        widget._transferencias.add(transferenciarecebida);
      });
    }
  }
}

class ItemTrasferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTrasferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text(_transferencia.valor.toString()),
            subtitle: Text(_transferencia.numeroConta.toString())));
  }
}
