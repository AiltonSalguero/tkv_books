import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';
import 'package:flutter_aws_amplify_cognito/sign_in/identity_provider.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dao/usuario_dao.dart';
import 'package:tkv_books/dialogs/simple_dialog.dart';
import 'package:tkv_books/dialogs/validar_codigo_dialog.dart';
import 'package:tkv_books/model/usuario.dart';
import 'package:tkv_books/widgets/buttons/large_button.dart';
import 'package:tkv_books/widgets/inputs/inputPersonalizado.dart';
import 'package:tkv_books/widgets/labels/labelPerzonalizado.dart';
import 'package:tkv_books/widgets/page_background.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final nombreCompleto = TextEditingController();
  final nickname = TextEditingController();
  final email = TextEditingController();
  final contrasenia = TextEditingController();

  @override
  void dispose() {
    // Limpia los controlodadores
    nombreCompleto.dispose();
    email.dispose();
    nickname.dispose();
    contrasenia.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("registro");
    return PageBackground(
      backgroundImagePath: "images/logo.jpg",
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            titulo1Label("Registro"),
            RoundedInput(
              nombre: "Nombre y apellido",
              controller: nombreCompleto,
              tipoInput: TextInputType.text,
              ocultarDatos: false,
            ),
            RoundedInput(
              nombre: "Nickname",
              controller: nickname,
              tipoInput: TextInputType.text,
              ocultarDatos: false,
            ),
            RoundedInput(
              nombre: "Email",
              controller: email,
              tipoInput: TextInputType.emailAddress,
              ocultarDatos: false,
            ),
            RoundedInput(
              nombre: "Contraseña",
              controller: contrasenia,
              tipoInput: TextInputType.text,
              ocultarDatos: true,
            ),
            LargeButton(
              nombre: "Crear cuenta",
              accion: _validarRegistro,
              primario: true,
            )
          ],
        ),
      ),
    );
  }

  _validarRegistro() {
    _validarDatos();

    _guardarDatos();

    _registrarUsuario();
  }

  _guardarDatos() {
    Sesion.usuarioRegistro =
        Usuario(nombreCompleto.text, nickname.text, email.text);
    Sesion.contraseniaRegistro = contrasenia.text;
  }

  _registrarUsuario() {
    Map<String, String> userAttributes = Map<String, String>();
    userAttributes["email"] = Sesion.usuarioRegistro.email;
    FlutterAwsAmplifyCognito.signUp(
            nickname.text, contrasenia.text, userAttributes)
        .then((SignUpResult result) {
      if (!result.confirmationState) {
        // Si aun no valida su codigo
        ValidarCodigo().dialog(context);
      } else {
        _iniciarSesion();
      }
    }).catchError((error) {
      String tituloDialog = "Error";
      String contenidoDialog = "Error desconocido";
      print(error.message);
      print(error.details);
      if (error.details.contains("User already exists")) {
        tituloDialog = "Nickname ya existente";
        contenidoDialog = "Escriba otro nickname";
      }
      if (error.details.contains("fadsfads")) {
        tituloDialog = "dsad";
        contenidoDialog = "dsd";
      }

      SimpleDialogTkv(
        title: tituloDialog,
        content: contenidoDialog,
        rightText: "Ok",
      ).build(context);
    });
  }

  _iniciarSesion() {
    FlutterAwsAmplifyCognito.signIn(nickname.text, contrasenia.text)
        .then((result) {});
  }

  _validarDatos() {
    String tituloDialog;
    String contenidoDialog;
    bool errorDatos = false;
    if (nickname.text.isEmpty ||
        email.text.isEmpty ||
        contrasenia.text.isEmpty ||
        nombreCompleto.text.isEmpty) {
      errorDatos = true;
      tituloDialog = "Campo incompleto";
      if (contrasenia.text.isEmpty) contenidoDialog = "Escriba una contraseña";
      if (email.text.isEmpty) contenidoDialog = "Escriba un email";
      if (nickname.text.isEmpty) contenidoDialog = "Escriba un nickname";
      if (nombreCompleto.text.isEmpty) contenidoDialog = "Escriba un nombre";
    }
    if (nickname.text.length > 12 || nombreCompleto.text.length > 12) {
      errorDatos = true;
      tituloDialog = "Campo muy largo";
      if (nickname.text.length > 12)
        contenidoDialog = "Escriba un nickname más corto";
      if (nombreCompleto.text.length > 12)
        contenidoDialog = "Escriba un nombre más corto";
    }

    if (nickname.text.length < 4 || contrasenia.text.length < 8) {
      errorDatos = true;
      tituloDialog = "Campo muy corto";
      if (contrasenia.text.length < 8)
        contenidoDialog = "Escriba una contraseña más larga";
      if (nickname.text.length < 4)
        contenidoDialog = "Escriba un nickname más largo";
    }

    if (errorDatos) {
      SimpleDialogTkv(
        title: tituloDialog,
        content: contenidoDialog,
        rightText: "Ok",
      ).build(context);
    }
  }

  _irAperfil() {
    Navigator.of(context).pushNamed('/perfil');
  }
}
