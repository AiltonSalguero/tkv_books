import 'package:flutter/material.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dao/usuario_dao.dart';
import 'package:tkv_books/util/router.dart';
import 'package:tkv_books/widgets/error_login_dialog.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nickname = TextEditingController();
  final contrasenia = TextEditingController();

  void dispose() {
    // Limpia los controlodadores
    nickname.dispose();
    contrasenia.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
        ),
      ),
      body: Column(
        children: <Widget>[
          Text(
            "Trikavengers",
          ),
          TextFormField(
            controller: nickname,
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
          ),
          FlatButton(
            child: Text("Registrarme"),
            onPressed: () => Router.irRegistro(context),
          )
        ],
      ),
    );
  }

  void _validarUsuario() {
    UsuarioDao.existeUsuario(nickname.text, contrasenia.text).then((existe) {
      if (existe) {
        _logearUsuario();
      } else {
        _abrirErrorLoginDialog(nickname.text);
      }
    });
  }

  void _abrirErrorLoginDialog(String nickname) async {
    final ConfirmAction action = await ErrorLoginDialog(context);
  }

  void _logearUsuario() {
    UsuarioDao.getUsuarioByNickname(nickname.text).then((user){
      Sesion.usuarioLogeado = user;
    });
    Router.irPerfil(context);
  }
}
