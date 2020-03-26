import 'package:flutter/material.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dao/usuario_dao.dart';
import 'package:tkv_books/util/router.dart';
import 'package:tkv_books/dialogs/error_login_dialog.dart';

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
      resizeToAvoidBottomPadding: false,
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
          _ingresarButton(_validarUsuario()),
          FlatButton(
            child: Text("Registrarme"),
            onPressed: () => Router.irRegistro(context),
          )
        ],
      ),
    );
  }

  Widget _ingresarButton(void onPressed) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: RaisedButton(
          color: Color(0xFF35A8A1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Ingresar",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontFamily: "Product_Sans_Bold"),
            ),
          ),
          onPressed: () => onPressed,
        ),
      ),
    );
  }

  void _validarUsuario() {
    if(nickname.text=="" || contrasenia.text == "") return null;
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
    UsuarioDao.getUsuarioByNickname(nickname.text).then((user) {
      Sesion.usuarioLogeado = user;
      Router.irPerfil(context);
    });
  }
}
