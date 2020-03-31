import 'package:flutter/material.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dao/usuario_dao.dart';
import 'package:tkv_books/util/confirmAction.dart';
import 'package:tkv_books/dialogs/error_dialog.dart';
import 'package:tkv_books/util/screen.dart';
import 'package:tkv_books/widgets/botonPersonalizado.dart';
import 'package:tkv_books/widgets/inputPersonalizado.dart';
import 'package:tkv_books/widgets/labelPerzonalizado.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nickname = TextEditingController();
  final contrasenia = TextEditingController();
  void dispose() {
    //Limpia los controlodadores
    nickname.dispose();
    contrasenia.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.topLeft,
        children: <Widget>[
          Image.asset(
            "images/logo.jpg",
            fit: BoxFit.cover,
            height: Screen.height * 0.35, // Responsive
            width: double.infinity,
          ),
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(32.0),
                topLeft: Radius.circular(32.0),
              ),
              border: Border.all(
                color: Colors.black,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 32.0,
                ),
              ],
              color: Color(0xfffafafa),
            ),
            margin: EdgeInsets.only(
              top: Screen.height * 0.3, // Responsive 266
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 32.0,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    titulo1Label("Login"),
                    inputPrincipal("Nickname", nickname),
                    inputSecundario("Contraseña", contrasenia),
                    _ingresarButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ingresarButton() {
    return botonPrincipal(_validarUsuario, "Ingresar");
  }

  _validarUsuario() {
    print("Validando");
    // si no hay datos que se ponga de color celeste turquesa
    if (nickname.text == "" || contrasenia.text == "")
      return _abrirErrorDatosDialog();
    UsuarioDao.existeUsuario(nickname.text, contrasenia.text).then((existe) {
      if (existe) {
        _logearUsuario();
      } else {
        _abrirErrorLoginDialog(nickname.text);
      }
    });
  }

  _abrirErrorDatosDialog() async {
    final ConfirmAction action = await errorLoginDialog(
        context, "No hay datos", "Escriba el nickname y la contraseña.");
  }

  _abrirErrorLoginDialog(String nickname) async {
    final ConfirmAction action = await errorLoginDialog(
        context, "Usuario incorrecto", "Escribe bien los datos gaa");
  }

  _logearUsuario() {
    UsuarioDao.getUsuarioByNickname(nickname.text).then((user) {
      Sesion.usuarioLogeado = user;
      // ('/perfil/codUusario=1')
      Navigator.of(context).pushReplacementNamed('/perfil');
    });
  }
}
