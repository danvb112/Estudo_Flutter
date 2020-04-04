import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());


class BytebankApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary
        )
      ),
      home: ListaTransferencias(),
        
      
    );
  }
}


class FormularioTransferencia extends StatefulWidget{


 
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
      appBar: AppBar(title: Text("Criando Transferência")),
      body: SingleChildScrollView(
              child: Column(
          children: <Widget> [
            Editor(
            controlador: _controladorCampoNumeroConta, 
            rotulo: "Numero da conta", 
            dica: "0000"),
            Editor(
              controlador: _controladorCampoValor, 
              rotulo: "Valor", 
              dica: "0.00", 
              icone: Icons.monetization_on),
            RaisedButton(
              child: Text("Confirmar"),
              onPressed: () => _criaTransferencia(context) ,
            )
          
          ]
         ),
      ),
    );
  }
    void _criaTransferencia(BuildContext context) {
    final int numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double valor = double.tryParse(_controladorCampoValor.text);
    if(numeroConta != null && valor != null){
      final transferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint("Criando Transferência");
      debugPrint("$transferenciaCriada");
      Navigator.pop(context, transferenciaCriada);
  }
}


}



class Editor extends StatelessWidget {

  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;

  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: controlador,
            style: TextStyle(
              fontSize: 24 
            ),
            decoration: InputDecoration(
              labelText: rotulo,
              hintText: dica,
              icon: icone != null ? Icon(icone) : null ,
            ),
            keyboardType: TextInputType.number,
          )
          );
  }
}


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
        }
        ),
      appBar: AppBar(title: Text("Transferências")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add), 
        onPressed: () {
          final Future<Transferencia> future = Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          future.then((transferenciarecebida) {
            Future.delayed(Duration(seconds: 5), () {
              debugPrint("Chegou no then do future");
              debugPrint("$transferenciarecebida");
              if(transferenciarecebida != null){
                setState(() {
                  widget._transferencias.add(transferenciarecebida);
                });
              }

            });
         
          });
        },
        
      ),
    );
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

class Transferencia{
  double valor;
  int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}