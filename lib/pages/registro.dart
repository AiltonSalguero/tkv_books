import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';
import 'package:tkv_books/cognito/registro_cognito.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dialogs/simple_dialog.dart';
import 'package:tkv_books/model/usuario.dart';
import 'package:tkv_books/widgets/buttons/large_button.dart';
import 'package:tkv_books/widgets/inputs/rounded_input.dart';
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

  bool datosValidados = false;

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
    Sesion.contextActual = context;
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
    if (datosValidados) {
      datosValidados = false;
      _registrarUsuario();
    }
  }

  _registrarUsuario() {
    Sesion.usuarioRegistro =
        Usuario(nombreCompleto.text, nickname.text, email.text);
    Sesion.atributosUsuarioRegistro = Map<String, String>();
    Sesion.atributosUsuarioRegistro["email"] = Sesion.usuarioRegistro.email;
    Sesion.contraseniaUsuario = contrasenia.text;
    Sesion.usuarioLogeado = Sesion.usuarioRegistro;
    RegistroCognito.registrarUsuario();
  }

  _iniciarSesion() {
    FlutterAwsAmplifyCognito.signIn(nickname.text, contrasenia.text)
        .then((result) {
      print(result);
      Sesion.usuarioLogeado = Sesion.usuarioRegistro;
      _irAperfil();
    });
  }

  _validarDatos() {
    String tituloDialog;
    String contenidoDialog;
    if (nickname.text.isEmpty ||
        email.text.isEmpty ||
        contrasenia.text.isEmpty ||
        nombreCompleto.text.isEmpty) {
      tituloDialog = "Campo incompleto";
      if (contrasenia.text.isEmpty) contenidoDialog = "Escriba una contraseña";
      if (email.text.isEmpty) contenidoDialog = "Escriba un email";
      if (nickname.text.isEmpty) contenidoDialog = "Escriba un nickname";
      if (nombreCompleto.text.isEmpty) contenidoDialog = "Escriba un nombre";
    }
    if (nickname.text.length > 12 || nombreCompleto.text.length > 12) {
      tituloDialog = "Campo muy largo";
      if (nickname.text.length > 12)
        contenidoDialog = "Escriba un nickname más corto";
      if (nombreCompleto.text.length > 12)
        contenidoDialog = "Escriba un nombre más corto";
    }

    if (nickname.text.length < 4 || contrasenia.text.length < 8) {
      tituloDialog = "Campo muy corto";
      if (contrasenia.text.length < 8)
        contenidoDialog = "Escriba una contraseña más larga";
      if (nickname.text.length < 4)
        contenidoDialog = "Escriba un nickname más largo";
    }
    datosValidados = true;
    if (!datosValidados) {
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
