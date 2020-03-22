import 'package:flutter/material.dart';
import 'package:tkv_books/model/usuario.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {

  Usuario userioNuevo = Usuario();
  final nombres = TextEditingController();
  final apellidos = TextEditingController();
  final apodo = TextEditingController();
  final contrasenia = TextEditingController();

  @override
  void dispose() {
    // Limpia los controlodadores
    nombres.dispose();
    apellidos.dispose();
    apodo.dispose();
    contrasenia.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          TextFormField(
            controller: nombres,
            decoration: InputDecoration(
              labelText: 'Nombres',
            ),
          ),
          TextFormField(
            controller: apellidos,
            decoration: InputDecoration(
              labelText: 'Apellidos',
            ),
          ),
          TextFormField(
            controller: apodo,
            decoration: InputDecoration(
              labelText: 'Apodo',
            ),
          ),
          TextFormField(
            controller: contrasenia,
            decoration: InputDecoration(
              labelText: 'Contraseña',
            ),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
