import 'package:flutter/material.dart';
import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dao/usuario_dao.dart';
import 'package:tkv_books/dialogs/simple_dialog.dart';
import 'package:tkv_books/widgets/inputPersonalizado.dart';
import 'package:tkv_books/widgets/labelPerzonalizado.dart';
import 'package:tkv_books/widgets/large_button.dart';
import 'package:tkv_books/widgets/page_background.dart';

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
    print("login");
    return PageBackground(
      backgroundImagePath: "images/logo.jpg",
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            titulo1Label("Login"),
            inputPrincipal("Nickname", nickname),
            inputContrasenia("Contraseña", contrasenia),
            LargeButton(
              nombre: "Ingresar",
              accion: _loginCognito,
              primario: true,
            ),
          ],
        ),
      ),
    );
  }

  _validarUsuario() {
    print("Validando");
    _validarDatos();
    try {
      UsuarioDao.existeUsuario(nickname.text, contrasenia.text, context)
          .then((existe) {
        if (existe) {
          _logearUsuario();
        } else {
          _usuarioIncorrectoDialog();
        }
      });
    } catch (e) {
      print(e);
      _sinInternetDialog();
    }
  }

  _validarDatos() {
    if (nickname.text.isEmpty || contrasenia.text.isEmpty) _noHayDatosDialog();
    if (nickname.text.isEmpty) _noHayNicknameDialog();
    if (contrasenia.text.isEmpty) _noHayContraseniaDialog();
  }

  _logearUsuario() {
    UsuarioDao.getUsuarioByNickname(nickname.text).then((user) {
      Sesion.usuarioLogeado = user;
      // ('/perfil/codUusario=1')
      _irAperfil();
    });
  }

  _irAperfil() {
    Navigator.of(context).pushReplacementNamed('/perfil');
  }

  _loginCognito() {
    FlutterAwsAmplifyCognito.signIn(nickname.text, contrasenia.text)
        .then((SignInResult result) {
      switch (result.signInState) {
        case SignInState.SMS_MFA:
          print("1");
          break;
        case SignInState.PASSWORD_VERIFIER:
          print("2");
          break;
        case SignInState.CUSTOM_CHALLENGE:
          print("3");
          break;
        case SignInState.DEVICE_SRP_AUTH:
          print("4");
          break;
        case SignInState.DEVICE_PASSWORD_VERIFIER:
          print("5");
          break;
        case SignInState.ADMIN_NO_SRP_AUTH:
          print("6");
          break;
        case SignInState.NEW_PASSWORD_REQUIRED:
          print("7");
          break;
        case SignInState.DONE:
          print("8");
          _irAperfil();
          break;
        case SignInState.UNKNOWN:
          print("9");
          break;
        case SignInState.ERROR:
          print("1");
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  _noHayDatosDialog() {
    return SimpleDialogTkv(
            title: "No hay datos",
            content: "Escriba el nickname y la contraseña",
            rightText: "Ok")
        .build(context);
  }

  _sinInternetDialog() {
    return SimpleDialogTkv(
            title: "Sin internet",
            content: "No esta conectado a internet.",
            rightText: "Ok")
        .build(context);
  }

  _noHayNicknameDialog() {
    return SimpleDialogTkv(
            title: "No hay datos",
            content: "Escriba un nickname",
            rightText: "Ok")
        .build(context);
  }

  _noHayContraseniaDialog() {
    return SimpleDialogTkv(
            title: "No hay datos",
            content: "Escriba una contraseña",
            rightText: "Ok")
        .build(context);
  }

  _usuarioIncorrectoDialog() async {
    return SimpleDialogTkv(
            title: "Usuario incorrecto",
            content: "Escribe bien los datos",
            rightText: "Ok")
        .build(context);
  }
}
