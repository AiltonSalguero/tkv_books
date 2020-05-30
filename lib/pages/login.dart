import 'package:flutter/material.dart';
import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';
import 'package:tkv_books/dao/dao.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dialogs/error_cognito_dialog.dart';
import 'package:tkv_books/dialogs/normal_dialog.dart';
import 'package:tkv_books/widgets/buttons/large_button.dart';
import 'package:tkv_books/widgets/inputs/rounded_input.dart';
import 'package:tkv_books/widgets/labels/labelPerzonalizado.dart';
import 'package:tkv_books/widgets/page_background.dart';

/*
  Vista del Login de la app
*/
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nicknameController = TextEditingController();
  final contraseniaController = TextEditingController();

  void dispose() {
    //Limpia los controlodadores
    nicknameController.dispose();
    contraseniaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("login");
    Sesion.contextActual = context;
    return PageBackground(
      backgroundImagePath: "images/logo.jpg",
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            titulo1Label("Login"),
            RoundedInput(
              nombre: "Nickname",
              controller: nicknameController,
              tipoInput: TextInputType.text,
            ),
            RoundedInput(
              nombre: "Contraseña",
              controller: contraseniaController,
              tipoInput: TextInputType.visiblePassword,
              ocultarDatos: true,
            ),
            LargeButton(
              nombre: "Ingresar",
              accion: _ingresarDatos,
              primario: true,
            ),
          ],
        ),
      ),
    );
  }

  _ingresarDatos() {
    _validarDatos();
    _loginCognito();
  }

  _validarDatos() {
    String tituloDialog;
    String contenidoDialog;
    bool errorDatos = false;

    if (nicknameController.text.isEmpty || contraseniaController.text.isEmpty) {
      errorDatos = true;
      tituloDialog = "No hay datos";
      if (contraseniaController.text.isEmpty)
        contenidoDialog = "Escriba la contraseña";
      if (nicknameController.text.isEmpty)
        contenidoDialog = "Escriba el nickname";
    }
    if (errorDatos) {
      NormalDialog(
        context:context,
        title: tituloDialog,
        content: contenidoDialog,
        rightText: "Ok",
      ).build();
    }
  }

  _loginCognito() {
    FlutterAwsAmplifyCognito.signIn(
            nicknameController.text, contraseniaController.text)
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
          _iniciarSesion();
          break;
        case SignInState.UNKNOWN:
          print("9");
          break;
        case SignInState.ERROR:
          print("1");
          break;
      }
    }).catchError((error) {
      ErrorCognitoDialog(
        error: error,
        context: context,
      ).build();
    });
  }

  _iniciarSesion() {
    Sesion.usuarioLogeado.nickname = nicknameController.text;
    FlutterAwsAmplifyCognito.getTokens().then((Tokens tokens) {
      Dao.cognitoToken = tokens.idToken;
     // Sesion.getDatosUsuarioLogeado();
      Sesion.getLibroLeyendoUsuarioLogeado();
      Sesion.getLibrosUsuarioLogeado();
    }).catchError((error) {
      print(error);
    });
  }

  _irAperfil() {
    Navigator.of(context).pushReplacementNamed('/perfil');
  }
}
