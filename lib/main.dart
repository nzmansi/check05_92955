import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Reservas de Mesa',

      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.pink,
      ),

      home: ReservaForm(),
    );

  }
}

class ReservaForm extends StatefulWidget {
  @override
  _ReservaFormState createState() => _ReservaFormState();
}

class _ReservaFormState extends State<ReservaForm> {

  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _numeroController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TelaDeConfirmacao(nome: _nomeController.text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Reserva de Mesa'),
        backgroundColor: Colors.purple,
      ),

      body: Padding(

        padding: EdgeInsets.all(16.0),

        child: Form(

          key: _formKey,

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome do cliente:'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do cliente';
                  } else if (value.length < 4) {
                    return 'O nome deve ter ao menos 4 caracteres';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              TextFormField(
                controller: _numeroController,
                decoration: InputDecoration(labelText: 'Número de pessoas:'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o número de pessoas';
                  }
                  final numero = int.tryParse(value);
                  if (numero == null || numero < 1 || numero > 20) {
                    return 'O número de pessoas deve ser entre 1 e 20';
                  }
                  return null;
                },
              ),

              SizedBox(height: 30),

              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Reservar'),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class TelaDeConfirmacao extends StatelessWidget {
  final String nome;

  TelaDeConfirmacao({required this.nome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Confirmação de Reserva'),
        backgroundColor: Colors.purple,
      ),

      body: Center(

        child: Text(
          'Mesa reservada para $nome!',
          style: TextStyle(fontSize: 32),
        ),

      ),

    );
  }
}