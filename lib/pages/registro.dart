import 'package:flutter/material.dart';
import 'package:tkv_books/dao/usuario_dao.dart';
import 'package:tkv_books/model/usuario.dart';
import 'package:tkv_books/widgets/botonPersonalizado.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  Usuario usuarioNuevo;
  final nombres = TextEditingController();
  final apellidos = TextEditingController();
  final nickname = TextEditingController();
  final contrasenia = TextEditingController();

  @override
  void dispose() {
    // Limpia los controlodadores
    nombres.dispose();
    apellidos.dispose();
    nickname.dispose();
    contrasenia.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          "Registro",
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            controller: nickname,
            decoration: InputDecoration(
              labelText: 'Nickname',
            ),
          ),
          TextFormField(
            controller: contrasenia,
            decoration: InputDecoration(
              labelText: 'Contraseña',
            ),
            obscureText: true,
          ),
          botonPrincipal(_validarRegistro, "Crear cuenta")
        ],
      ),
    );
  }

  void _validarRegistro() {
    usuarioNuevo =
        Usuario(nombres.text, apellidos.text, nickname.text, contrasenia.text);
    // validar datos
    UsuarioDao.postUsuario(usuarioNuevo);
  }
}
