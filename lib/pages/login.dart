import 'package:flutter/material.dart';
import 'package:tkv_books/dao/usuario_dao.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final apodo = TextEditingController();
  final contrasenia = TextEditingController();

  void dispose() {
    // Limpia los controlodadores
    apodo.dispose();
    contrasenia.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text(
            "Trikavengers",
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
          FlatButton(
            child: Icon(Icons.send),
            onPressed: () => _validarUsuario(),
          )
        ],
      ),
    );
  }

  void _validarUsuario() {
    if (UsuarioDao.existeUsuario(apodo.text, contrasenia.text)) {
      _logearUsuario();
    } else {
      _abrirErrorLoginDialog(apodo.text);
    }
  }

  void _abrirErrorLoginDialog(String apodo) {}
  void _logearUsuario() {}
}
